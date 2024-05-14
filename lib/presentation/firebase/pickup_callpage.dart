import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/core/config.dart';
import 'package:dating/presentation/firebase/vc_provider.dart';
import 'package:dating/presentation/firebase/videocall_screen.dart';
import 'package:dating/presentation/screens/AudioCall/audiocall_screen.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import 'chat_page.dart';

class PickUpCall extends StatefulWidget {
  final Map userData;
  final bool isAudio;
  const PickUpCall({Key? key, required this.userData, required this.isAudio}) : super(key: key);

  @override
  State<PickUpCall> createState() => _PickUpCallState();
}

class _PickUpCallState extends State<PickUpCall> {

  String ids = "";
  String dataids = "";
  late VcProvider vcProvider;

  @override
  void initState() {
    super.initState();
    vcProvider = Provider.of<VcProvider>(context,listen: false);
    ids =  widget.isAudio ? "Audio": "vcId";
    dataids =  widget.isAudio ? "Audio": "isVc";
    widget.isAudio ? isAudio(widget.userData[ids], null) : isvc(widget.userData[ids],true);
     FirebaseFirestore.instance.collection("chat_rooms").doc(widget.userData[ids]).collection("isVcAvailable").doc(widget.userData[ids]).snapshots().listen((event) {
        Map data = event.data()!;

        if(data[dataids] == false){
          // WidgetsBinding.instance.addPostFrameCallback((_){
          // navigatorKey.currentState?.pop();
          Navigator.pop(context);
          if(vcProvider.ischatPage) {

            navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => ChattingPage(resiverUserId: widget.userData["id"], resiverUseremail: widget.userData["name"], proPic: widget.userData["propic"])));

          }
          // });
        }

    });
}

  @override
  void dispose() {
    super.dispose();
    vcProvider.ischatPage = false;
  }

  @override
  Widget build(BuildContext context) {
    vcProvider = Provider.of<VcProvider>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
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
          children: [
            const Spacer(flex: 2),
            Container(
              height: 180,width: 180,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage("${Config.baseUrl}${widget.userData["propic"]}"),fit: BoxFit.cover),
            ),),
            const SizBoxH(size: 0.03),
            Text(widget.userData["name"],style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),),
            const SizedBox(height: 10,),
            Text("In Coming ${widget.isAudio ? "Audio":"Video"} Call From ${widget.userData["name"]}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(

                  onTap: () {

                    vcProvider.updateIschatPage(false);
                    // Navigator.pop(context);
                    widget.isAudio ? isAudio(widget.userData[ids], false) : isvc(widget.userData[ids], false);

                  },

                  child: Container(
                     height: 60,
                     width: 60,
                     decoration: const BoxDecoration(
                     shape: BoxShape.circle,
                     color: Colors.red,
                  ), child: Center(child: SvgPicture.asset("assets/icons/Call Missed.svg",colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),)),

                  ),

                ),
                // const SizedBox(width: 10,),
                InkWell(

                  onTap: () {

                    vcProvider.updateIschatPage(false);

                    Navigator.pop(context);

                    if(widget.isAudio){

                      isAudio(widget.userData[ids], true);

                      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => PickUpAudioCall(channel: widget.userData[ids],userData: widget.userData,)));

                    }else{

                      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => VideoCall(channel: widget.userData[ids])));

                    }

                  },

                  child: Container(
                    height: 60,width: 60,
                    decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                    child: Center(child: SvgPicture.asset("assets/icons/phone-fill.svg",colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),)),
                 ),

                ),

                InkWell(
                  onTap: () {
                    vcProvider.updateIschatPage(true);
                    widget.isAudio ? isAudio(widget.userData[ids], false) : isvc(widget.userData[ids],false);
                  },
                  child: Container(
                    height: 60,width: 60,
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffF0F0F0).withOpacity(0.3),
                  ),
                    child: Center(child: SvgPicture.asset("assets/icons/Chat-fill.svg",colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),)),
                  ),
                )

              ],
            ),
            const SizedBox(height: 20,)

            // Image.network("${Config.baseUrl}${widget.userData["propic"]}"),

          ],
        ),
      ),
    );
  }
}
