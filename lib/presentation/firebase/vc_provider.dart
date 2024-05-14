import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../language/localization/app_localization.dart';


class VcProvider extends ChangeNotifier{
  int? _remoteUid;
  bool localUserJoined = false;
  late RtcEngine engine;

  bool muteUnmute = false;

  Future<void> initAgora(appId,token,channel,context) async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
            localUserJoined = true;
             notifyListeners();
        },

        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $_remoteUid joined");
          _remoteUid = remoteUid;
          notifyListeners();
        },

        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $_remoteUid left channel");
          _remoteUid = null;
            notifyListeners();
        },

        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },

      ),
    );

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.enableVideo();
    await engine.startPreview();

    await engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> disposee() async {
    await engine.leaveChannel();
    await engine.release();
    await engine.disableAudio();
    await engine.disableVideo();
  }

  bool ischatPage = false;

  updateIschatPage(bool value){
    ischatPage = value;
    notifyListeners();
  }


  Widget remoteVideo(channel,context) {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection:  RtcConnection(channelId: channel),
        ),
      );
    } else {
      return  Text(
        AppLocalizations.of(context)?.translate("Please wait for user to join") ?? "Please wait for user to join",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
  }

}