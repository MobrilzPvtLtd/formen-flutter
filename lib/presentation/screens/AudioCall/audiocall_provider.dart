import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioCallProvider extends ChangeNotifier {
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; //
  bool muteUnmute = false;

bool isLoading = false;
updateIsLoading(bool value){
  isLoading = value;
  notifyListeners();
}

  updateMuteUnmute(){
    muteUnmute =! muteUnmute;
    notifyListeners();
  }

  Future<void> setupVoiceSDKEngine(appId) async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize( RtcEngineContext(
        appId: appId
    ));

  agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            isJoined = true;
            notifyListeners();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            stopwatch.start();
            _remoteUid = remoteUid;
            notifyListeners();
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
            _remoteUid = null;
            notifyListeners();
        },
      ),
);

}

  void  join(channel,token) async {
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channel,
      options: options,
      uid: uid,
    );
  }

  void leave() {
        isJoined = false;
       _remoteUid = null;
      notifyListeners();
    agoraEngine.leaveChannel();
  }

  late Stopwatch stopwatch;
  late Timer t;

  void handleStartStop() {

    if(stopwatch.isRunning) {
      stopwatch.stop();
    }

    else {
      stopwatch.start();
    }

  }

  managetimer(){
    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      notifyListeners();
    });
  }

  String returnFormattedText() {

    var milli = stopwatch.elapsed.inMilliseconds;

    String seconds = ((milli ~/ 1000)  % 60).toString().padLeft(2, "0");   // this is for the second
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");  // this is for the minute

    return "$minutes:$seconds";
  }

}