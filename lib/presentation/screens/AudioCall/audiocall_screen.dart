import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/core/config.dart';
import 'package:dating/presentation/screens/AudioCall/audiocall_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../core/ui.dart';
import '../../firebase/chat_page.dart';

class PickUpAudioCall extends StatefulWidget {
  final Map userData;
  final String channel;
  const PickUpAudioCall({Key? key, required this.userData, required this.channel}) : super(key: key);

  @override
  State<PickUpAudioCall> createState() => _PickUpAudioCallState();
}

class _PickUpAudioCallState extends State<PickUpAudioCall> {
  late AudioCallProvider audioCallProvider;
  @override
  void initState() {
    super.initState();
    audioCallProvider = Provider.of<AudioCallProvider>(context,listen: false);
    audioCallProvider.updateIsLoading(true);
    audioCallProvider.setupVoiceSDKEngine(Config.agoraVcKey).then((value) {
      audioCallProvider.join(widget.channel, Config.agoraVcKey);
      audioCallProvider.stopwatch = Stopwatch();
      audioCallProvider.managetimer();
      audioCallProvider.updateIsLoading(false);
    });


    FirebaseFirestore.instance.collection("chat_rooms").doc(widget.channel).collection("isVcAvailable").doc(widget.channel).snapshots().listen((event) {
      Map data = event.data()!;
       if(data["Audio"] == false) {
        Navigator.pop(context);
        audioCallProvider.leave();
        audioCallProvider.stopwatch.reset();
      }
    });
  }

  @override
  void dispose() async {
    await audioCallProvider.agoraEngine.leaveChannel();
    audioCallProvider.isJoined = false;
    audioCallProvider.muteUnmute = false;
    audioCallProvider.isLoading = false;
    isAudio(widget.channel, false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    audioCallProvider = Provider.of<AudioCallProvider>(context);
    return Scaffold(
      body:   audioCallProvider.isLoading ? Center(child: CircularProgressIndicator(color: AppColors.appColor)) : Container(
        decoration: const BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.1,
                0.2,
                0.4,
                0.6,
                0.7,
              ],
              colors: [
                Color(0xff62e2f4),
                Color(0xff8290f4),
                Color(0xfff269cf),
                Color(0xffef5b5e),
                Color(0xfff07f51),
              ],
            )),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage("${Config.baseUrl}${widget.userData["propic"]}"),),
              const SizedBox(height: 10,),
              Text(widget.userData["name"], style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),),
              const SizedBox(height: 5,),
              Text(audioCallProvider.returnFormattedText(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  InkWell(
                    onTap: () async {
                      audioCallProvider.updateMuteUnmute();
                      await audioCallProvider.agoraEngine.muteAllRemoteAudioStreams(audioCallProvider.muteUnmute);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: Icon(
                        audioCallProvider.muteUnmute ? Icons.media_bluetooth_off : Icons.media_bluetooth_on_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),

              InkWell(
                onTap: () {
                isAudio(widget.channel, false);
                },
                child: Container(
                  height: 60,width: 60,decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                ),
                      child: Center(child: SvgPicture.asset("assets/icons/Call Missed.svg",colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn))),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 20,),

            ]),
      ),
    );
  }
}
