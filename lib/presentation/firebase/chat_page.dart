// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/language/localization/app_localization.dart';
import 'package:dating/presentation/firebase/chatting_provider.dart';
import 'package:dating/presentation/firebase/videocall_screen.dart';
import 'package:dating/presentation/screens/AudioCall/audio_callingscreen.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/other/premium/premium.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Logic/cubits/Home_cubit/home_cubit.dart';
import '../../Logic/cubits/Home_cubit/homestate.dart';
import '../../core/config.dart';
import '../../core/ui.dart';
import '../screens/other/premium/premium_provider.dart';
import '../screens/other/profileAbout/detailprovider.dart';
import '../screens/other/profileAbout/detailscreen.dart';

class ChattingPage extends StatefulWidget {
  final String resiverUserId;
  final String resiverUseremail;
  final String proPic;
  const ChattingPage(
      {Key? key,
        required this.resiverUserId,
        required this.resiverUseremail,
        required this.proPic})
      : super(key: key);

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  late ChattingProvider chattingProvider;
  late PremiumProvider premiumProvider;
  late DetailProvider detailProvider;
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();

    chattingProvider = Provider.of<ChattingProvider>(context, listen: false);

    detailProvider = Provider.of<DetailProvider>(context, listen: false);

    chattingProvider.isMeassageAvalable(widget.resiverUserId);
    chattingProvider.updateUid(Provider.of<HomeProvider>(context, listen: false).uid);
    chattingProvider.isUserOnlie(chattingProvider.uid!, true);
    Provider.of<PremiumProvider>(context,listen: false).planDataApi(context,widget.resiverUserId);

  }

  @override
  void dispose() {
    super.dispose();
    chattingProvider.isUserOnlie(chattingProvider.uid!, false);

    // chattingProvider.scrollController.dispose();
  }
  var selectedRadioTile;
  String rejectmsg = "";

  List cancelList = [
    {"id": 1, "title": "Harassment"},
    {"id": 2, "title": "Inappropriate Content"},
    {"id": 3, "title": "Violation of Terms"},
    {"id": 4, "title": "Offensive Language"},
    {"id": 5, "title": "Disrespectful Behavior"},
    {"id": 6, "title": "Threats"},
    {"id": 7, "title": "Catfishing"},
    {"id": 7, "title": "Unwanted Advances"},
    {"id": 7, "title": "Unsolicited Explicit Content"},
    {"id": 7, "title": "Privacy Concerns"},
    {"id": 7, "title": "Scam or Spam"},
    {"id": 7, "title": "Something else"},
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    chattingProvider = Provider.of<ChattingProvider>(context);
    premiumProvider = Provider.of<PremiumProvider>(context);
    detailProvider = Provider.of<DetailProvider>(context);
   homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appbar(
          proPic: widget.proPic,
          resiverUseremail: widget.resiverUseremail,
          resiverUserId: widget.resiverUserId,
          context: context
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                  child: chattingProvider.buildMessageList(context: context, resiverUserId: widget.resiverUserId),
              ),
              chattingProvider.buildMessageInpurt(resiverUserId: widget.resiverUserId, context: context),
            ],
          ),
          chattingProvider.isLoading
              ? CircularProgressIndicator(color: AppColors.appColor)
              : const SizedBox(),
        ],
      ),
    );
  }

  PreferredSizeWidget appbar({required String resiverUserId,
    required String resiverUseremail,
        required String proPic,
        required context}) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: const BackButtons(),
      title: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("datingUser")
              .doc(resiverUserId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              Map data = snapshot.data?.data() ?? {};
              print(data.isEmpty);
              return BlocBuilder<HomePageCubit, HomePageStates>(
                  builder: (context1, state) {
                    if (state is HomeCompleteState) {
                      return Row(
                        children: [
                          proPic == "null"
                              ? const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              backgroundImage: AssetImage(
                                "assets/Image/05.png",
                              ))
                              : CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage("${Config.baseUrl}/$proPic")
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  resiverUseremail,
                                  style: Theme.of(context).textTheme.bodyLarge!,
                                ),



                                const SizedBox(
                                  height: 3,
                                ),

                                data["isOnline"] == true
                                    ?Text(
                                      "Online",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.green)
                                      )
                                    :  const SizedBox()

                              ],
                            ),
                          ),
                          const Spacer(flex: 2),
                          InkWell(
                              onTap: () {
                                  if (state.homeData.audioVideo == "0") {
                                    Navigator.pushNamed(
                                        context, PremiumScreen.premiumScreenRoute);
                                  }
                                  else {
                                    chattingProvider.updateIsLoading(true);
                                    List<String> ids = [
                                      Provider.of<HomeProvider>(context, listen: false).uid,
                                      resiverUserId
                                    ];
                                    ids.sort();
                                    String vcRoomId = ids.join("_");

                                    isAudio(vcRoomId, null).then((value) {
                                      _firebaseStorage
                                          .collection("chat_rooms")
                                          .doc(vcRoomId)
                                          .collection("isVcAvailable")
                                          .doc(vcRoomId)
                                          .get()
                                          .then((value) {

                                        // if(value.data()!["Audio"] == true){
                                        chattingProvider.audioNotificationMessage(
                                            "In Coming Audio Call From ${Provider.of<HomeProvider>(context, listen: false).userlocalData.userLogin!.name}",
                                            Provider.of<HomeProvider>(context,
                                                listen: false)
                                                .userlocalData
                                                .userLogin!
                                                .name
                                                .toString(),
                                            chattingProvider.fmctoken,
                                            context,
                                            vcRoomId)
                                            .then((value) {
                                          chattingProvider.updateIsLoading(false);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AudioCallingScreen(
                                                        userData: data,
                                                        channel: vcRoomId),
                                              ));
                                        });

                                        // }
                                      });
                                    });
                                  }


                              },
                              child: SvgPicture.asset(
                                "assets/icons/Call.svg",
                                height: 25,
                                width: 25,
                                colorFilter: ColorFilter.mode(homeProvider.userlocalData.userLogin!.planId == "1" ? Theme.of(context).indicatorColor.withOpacity(0.2) : homeProvider.userlocalData.userLogin!.planId == "2" ? Theme.of(context).indicatorColor.withOpacity(0.2) : Theme.of(context).indicatorColor, BlendMode.srcIn),
                              )),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                print(chattingProvider.fmctoken);
                                  if (state.homeData.audioVideo == "0") {
                                    Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
                                  }
                                  else {
                                    chattingProvider.updateIsLoading(true);
                                    List<String> ids = [
                                      Provider.of<HomeProvider>(context, listen: false).uid,
                                      resiverUserId
                                    ];
                                    ids.sort();
                                    String vcRoomId = ids.join("_");
                                    isvc(vcRoomId, true).then((value) {
                                      _firebaseStorage.collection("chat_rooms").doc(vcRoomId).collection("isVcAvailable").doc(vcRoomId).get().then((value) {
                                        if (value.data()!["isVc"] == true) {
                                          chattingProvider.vcNotificationMessage(
                                              "In Coming Video Call From ${Provider.of<HomeProvider>(context, listen: false).userlocalData.userLogin!.name}",
                                              Provider.of<HomeProvider>(context, listen: false).userlocalData.userLogin!.name.toString(),
                                              chattingProvider.fmctoken,
                                              context,
                                              vcRoomId)
                                              .then((value) {
                                            chattingProvider.updateIsLoading(false);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoCall(channel: vcRoomId),
                                                ));
                                          });
                                        }
                                      });
                                    });
                                  }
                              },
                              child: SvgPicture.asset(
                                "assets/icons/Video.svg",
                                height: 25,
                                width: 25,
                                colorFilter: ColorFilter.mode(homeProvider.userlocalData.userLogin!.planId == "1" ? Theme.of(context).indicatorColor.withOpacity(0.2) : homeProvider.userlocalData.userLogin!.planId == "2" ? Theme.of(context).indicatorColor.withOpacity(0.2) : Theme.of(context).indicatorColor, BlendMode.srcIn),
                              )),
                          const Spacer(),
                          // SvgPicture.asset(
                          //   "assets/icons/More Circle.svg",
                          //   height: 25,
                          //   width: 25,
                          //   colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),
                          // ),

                          PopupMenuButton(
                            tooltip: '',
                            padding: const EdgeInsets.all(0),
                            offset: const Offset(110, 30),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            // initialValue: selectedMenu,
                            constraints: const BoxConstraints(
                              maxWidth: 310,
                              maxHeight: 540,
                            ),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: SvgPicture.asset(
                              "assets/icons/More Circle.svg",
                              height: 25,
                              width: 25,
                              colorFilter: ColorFilter.mode(homeProvider.userlocalData.userLogin!.planId == "1" ? Theme.of(context).indicatorColor.withOpacity(0.2) : homeProvider.userlocalData.userLogin!.planId == "2" ? Theme.of(context).indicatorColor.withOpacity(0.2) : Theme.of(context).indicatorColor, BlendMode.srcIn),
                            ),
                            itemBuilder: (context) =>
                            <PopupMenuEntry<SampleItem2>>[
                              PopupMenuItem(
                                  enabled: true,
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      // for (int i = 0; i < notification.length; i++)
                                      Column(children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showDialog<String>(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                elevation: 0,
                                                insetPadding: const EdgeInsets.only(left: 10,right: 10),
                                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                title: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 200,
                                                      width: 200,
                                                      child: Lottie.asset('assets/lottie/block.json',fit: BoxFit.cover),
                                                    ),
                                                    // const SizedBox(height: 30,),
                                                    Row(
                                                      children: [
                                                        // AppLocalizations.of(context).translate("Blocking") ?? "Blocking",





                                                        Text(AppLocalizations.of(context)?.translate("Blocking") ?? "Blocking",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),),
                                                        Text(' ${widget.resiverUseremail}',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 12,),
                                                    Text('Please tell us why you are blocking ${widget.resiverUseremail}. Don`t worry we won`t tell them.',style: Theme.of(context).textTheme.bodySmall!,textAlign: TextAlign.center,),
                                                    const SizedBox(height: 10,),
                                                    Divider(color: Colors.grey.withOpacity(0.2)),
                                                    const SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.add_box_sharp,color: AppColors.appColor),
                                                        const SizedBox(width: 10,),
                                                        // Flexible(child: Text('They will not be able to find your profile and send you messages.',style: Theme.of(context).textTheme.bodySmall!,)),
                                                        Flexible(child: Text(AppLocalizations.of(context)?.translate("They will not be able to find your profile and send you messages.") ?? "They will not be able to find your profile and send you messages.",style: Theme.of(context).textTheme.bodySmall!,)),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.notifications_off_outlined,color: AppColors.appColor),
                                                        const SizedBox(width: 10,),
                                                        Flexible(child: Text(AppLocalizations.of(context)?.translate("They will not be notified if you block them.") ?? "They will not be notified if you block them.",style: Theme.of(context).textTheme.bodySmall!,)),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.settings,color: AppColors.appColor),
                                                        const SizedBox(width: 10,),
                                                        // Flexible(child: Text('You can unblock them anytime in Settings.',style: Theme.of(context).textTheme.bodySmall!,)),
                                                        Flexible(child: Text(AppLocalizations.of(context)?.translate("You can unblock them anytime in Settings.") ?? "You can unblock them anytime in Settings.",style: Theme.of(context).textTheme.bodySmall!,)),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 30,),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: AppColors.appColor)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),backgroundColor: const MaterialStatePropertyAll(Colors.white)),
                                                            // child:  Text('Cancel'.tr,style: TextStyle(color: AppColors.appColor)),
                                                            child:  Text(AppLocalizations.of(context)?.translate("Cancel") ?? "Cancel",style: TextStyle(color: AppColors.appColor)),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5,),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              detailProvider.profileblockApi(context: context, profileblock: widget.resiverUserId);
                                                              // print(" + + + + + :--- ${detailProvider.detailModel.profileinfo!.profileId}");
                                                            },
                                                            style: ButtonStyle(elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),backgroundColor: MaterialStatePropertyAll(AppColors.appColor)),
                                                            // child:  Text('Yes, Block'.tr,style: TextStyle(color: Colors.white)),
                                                            child:  Text(AppLocalizations.of(context)?.translate("Yes, Block") ?? "Yes, Block",style: TextStyle(color: Colors.white)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Image(image: AssetImage("assets/icons/block.png"),height: 20,width: 20),
                                              const SizedBox(width: 10,),
                                              Flexible(
                                                child: Column(
                                                  children: [
                                                    // Text('Block'.tr, style: Theme.of(context).textTheme.bodySmall!, maxLines: 2, softWrap: true),
                                                    Text(AppLocalizations.of(context)?.translate("Block") ?? "Block", style: Theme.of(context).textTheme.bodySmall!, maxLines: 2, softWrap: true),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 50,)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Divider(
                                            color: Colors.grey.withOpacity(0.2)),
                                        const SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showDialog<String>(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) => StatefulBuilder(builder: (context, setState) {
                                                return SingleChildScrollView(
                                                  child: AlertDialog(
                                                    elevation: 0,
                                                    insetPadding: const EdgeInsets.only(left: 10,right: 10),
                                                    // contentPadding: EdgeInsets.zero,
                                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        // Center(
                                                        //   child: SizedBox(
                                                        //      height: 200,
                                                        //      width: 200,
                                                        //      child: Lottie.asset('assets/lottie/block.json',fit: BoxFit.cover),
                                                        //    ),
                                                        // ),
                                                        // const SizedBox(height: 30,),
                                                        Row(
                                                          children: [
                                                            // Center(child: Text('Reporting'.tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22))),
                                                            Center(child: Text(AppLocalizations.of(context)?.translate("Reporting") ?? "Reporting",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22))),
                                                            Center(child: Text(' ${widget.resiverUseremail}',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22))),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 12,),
                                                        Text('Please tell us why you are reporting ${widget.resiverUseremail}. Don`t worry we won`t tell them.',style: Theme.of(context).textTheme.bodySmall!,textAlign: TextAlign.center,),
                                                        const SizedBox(height: 10,),
                                                        // Text("Why did you report this user?".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18)),
                                                        Text(AppLocalizations.of(context)?.translate("Why did you report this user?") ?? "Why did you report this user?",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18)),
                                                        const SizedBox(height: 10,),
                                                        SizedBox(
                                                          height: 570,
                                                          width: MediaQuery.of(context).size.width,
                                                          child: ListView.builder(
                                                            itemCount: cancelList.length,
                                                            shrinkWrap: true,
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            itemBuilder: (ctx, i) {
                                                              return Transform.translate(
                                                                offset: const Offset(-10, 0),
                                                                child: RadioListTile(
                                                                  contentPadding: EdgeInsets.zero,
                                                                  dense: true,
                                                                  value: i,
                                                                  fillColor:  MaterialStatePropertyAll(AppColors.appColor),
                                                                  activeColor: AppColors.appColor,
                                                                  tileColor: AppColors.appColor,
                                                                  selected: true,
                                                                  groupValue: selectedRadioTile,
                                                                  // title: Text(cancelList[i]["title"], style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),),
                                                                  title: Text(AppLocalizations.of(context)?.translate("${cancelList[i]["title"]}") ?? "${cancelList[i]["title"]}", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),),
                                                                  onChanged: (val) {
                                                                    setState(() {});
                                                                    selectedRadioTile = val;
                                                                    rejectmsg = cancelList[i]["title"];
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(height: 30,),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                  detailProvider.profilereportApi(context: context, reportid: widget.resiverUserId, comment: rejectmsg);
                                                                  print(" + + + + + + + + + :----  $rejectmsg");
                                                                },
                                                                style: ButtonStyle(elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),backgroundColor: MaterialStatePropertyAll(AppColors.appColor)),
                                                                // child: Text('Continue'.tr,style: TextStyle(color: Colors.white)),
                                                                child: Text(AppLocalizations.of(context)?.translate("Continue") ?? "Continue",style: TextStyle(color: Colors.white)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },),
                                            );
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Image(image: AssetImage("assets/icons/report.png"),height: 20,width: 20),
                                              const SizedBox(width: 10,),
                                              Flexible(
                                                child: Column(
                                                  children: [

                                                    Text(
                                                        AppLocalizations.of(context)?.translate("Report") ?? "Report",
                                                        style: Theme.of(context).textTheme.bodySmall!,
                                                        maxLines: 2,
                                                        softWrap: true
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ]),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  });
            } else {
              return Row(
                children: [
                  commonSimmer(height: 42, width: 42, radius: 50),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonSimmer(
                          height: 10,
                          radius: 10,
                          width: MediaQuery.of(context).size.width * 0.3
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      commonSimmer(
                          height: 10,
                          radius: 10,
                          width: MediaQuery.of(context).size.width * 0.1),
                    ],
                  ),
                ],
              );
            }
          }),
    );
  }
}

final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

Future isvc(channel, bool isvc) async {
  await _firebaseStorage
      .collection("chat_rooms")
      .doc(channel)
      .collection("isVcAvailable")
      .doc(channel)
      .set({"isVc": isvc});
}

Future isAudio(channel, isvc) async {
  await _firebaseStorage
      .collection("chat_rooms")
      .doc(channel)
      .collection("isVcAvailable")
      .doc(channel)
      .set({"Audio": isvc});
}

Future<dynamic> isUserLogOut(String uid) async {
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('datingUser');
  collectionReference.doc(uid).update({"token": ""});
}
