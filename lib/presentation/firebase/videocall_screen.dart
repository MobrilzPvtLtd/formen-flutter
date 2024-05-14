import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/core/config.dart';
import 'package:dating/presentation/firebase/vc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/ui.dart';
import 'chat_page.dart';

class VideoCall extends StatefulWidget {
  final String channel;
  const VideoCall({Key? key, required this.channel}) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {

  late VcProvider vcProvider;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    vcProvider = Provider.of<VcProvider>(context,listen: false);
    vcProvider.initAgora(Config.agoraVcKey, Config.agoraVcKey, widget.channel,context);
    streamSubscription =  FirebaseFirestore.instance.collection("chat_rooms").doc(widget.channel).collection("isVcAvailable").doc(widget.channel).snapshots().listen((event) {
      Map data = event.data()!;
      print(data);

      if(data["isVc"] == false){
        // WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.pop(context);
        // });
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    isvc(widget.channel,false);
    vcProvider.disposee();
    streamSubscription.cancel();
    vcProvider.localUserJoined = false;
    vcProvider.muteUnmute = false;
  }

  @override
  Widget build(BuildContext context) {
    vcProvider = Provider.of<VcProvider>(context);
    return Scaffold(
      body: Stack(
        children: [

          Center(
            child: vcProvider.remoteVideo(widget.channel,context),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: vcProvider.localUserJoined ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: vcProvider.engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                ) : CircularProgressIndicator(color: AppColors.appColor),
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            left: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Spacer(),

                  InkWell(
                    onTap: () async {
                      vcProvider.muteUnmute =! vcProvider.muteUnmute;
                      await vcProvider.engine.muteAllRemoteAudioStreams(vcProvider.muteUnmute);
                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: Icon(
                        vcProvider.muteUnmute ? Icons.media_bluetooth_off : Icons.media_bluetooth_on_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Spacer(),
                  InkWell(
                    onTap: () {

                      isvc(widget.channel,false);

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: const Icon(Icons.call_end),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      await vcProvider.engine.switchCamera();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: const Icon(
                        Icons.cameraswitch_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
