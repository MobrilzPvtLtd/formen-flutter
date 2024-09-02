// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, avoid_print

import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating/core/config.dart';
import 'package:dating/data/models/detailsmodel.dart';
import 'package:dating/presentation/firebase/chat_page.dart';
import 'package:dating/presentation/screens/other/profileAbout/detailprovider.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../Logic/cubits/Home_cubit/home_cubit.dart';
import '../../../../Logic/cubits/Home_cubit/homestate.dart';
import '../../../../Logic/cubits/match_cubit/match_cubit.dart';
import '../../../../core/ui.dart';
import '../../../../language/localization/app_localization.dart';
import '../../BottomNavBar/homeProvider/homeprovier.dart';
import '../../BottomNavBar/home_screen.dart';
import '../premium/premium.dart';

enum SampleItem2 { itemOne, itemTwo, itemThree, itemfour }

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  static const String detailScreenRoute = "/detailScreen";

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailProvider detailProvider;

  @override
  void dispose() {
    super.dispose();
    detailProvider.isLoading = true;
    detailProvider.slider = 0;
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

  @override
  Widget build(BuildContext context) {
    detailProvider = Provider.of<DetailProvider>(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<HomePageCubit, HomePageStates>(
          builder: (context, state){
            if(state is HomeCompleteState){
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                decoration: BoxDecoration(
                    color: (detailProvider.status != "1"  && detailProvider.status != "3" && state.homeData.planId != "3") ? Theme.of(context).scaffoldBackgroundColor : AppColors.appColor,
                    borderRadius: BorderRadius.circular(100),
                  // shape: BoxShape.circle
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    (detailProvider.status == "1") ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MatchCubit>(context).profileLikeDislikeApi(
                                uid: Provider.of<HomeProvider>(context, listen: false).uid,
                                proId: detailProvider.detailModel.profileinfo!.profileId.toString(),
                                // action: "UNLIKE".tr).then((value) {
                                action: AppLocalizations.of(context)?.translate("UNLIKE") ?? "UNLIKE").then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(height: 55,width: 55,decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color:  Colors.white
                          ),child: Center(child: SvgPicture.asset("assets/icons/times.svg",colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),),
                        ),
                        // const SizBoxW(size: 0.05),
                        (detailProvider.status == "3" || state.homeData.planId == "3") ? const SizBoxW(size: 0.05) : const SizBoxW(size: 0),
                      ],
                    ) : const SizedBox(),

                    (detailProvider.status == "3" || state.homeData.planId == "3") ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingPage(
                              proPic: detailProvider.detailModel.profileinfo!.profileImages!.first,
                              resiverUserId: detailProvider.detailModel.profileinfo!.profileId.toString(),
                              resiverUseremail: detailProvider.detailModel.profileinfo!.profileName.toString(),
                            )));
                          },
                          child: Container(height: 55,width: 55,decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color:  Colors.white
                          ),child: Center(child: SvgPicture.asset("assets/icons/Chat-fill.svg",colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),),
                        ),
                      ],
                    ) : const SizedBox(),

                    state.homeData.planId == "0" ? Row(
                      children: [
                        const SizBoxW(size: 0.05),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
                          },
                          child: Container(height: 55,width: 55,decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color:  Colors.white
                          ),child: Center(child: SvgPicture.asset("assets/icons/star.svg",colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)),),
                        ),
                        if(detailProvider.status == "3" || (detailProvider.status != "3" && detailProvider.status != "2")) const SizBoxW(size: 0.05),
                      ],
                    ) : const SizedBox(),

                    (detailProvider.status != "3" && detailProvider.status != "2") ? Row(
                      children: [
                        state.homeData.planId == "0" ? const SizedBox() :  const SizBoxW(size: 0.05),
                        // (detailProvider.status != "1" || detailProvider.status != "3") ?  const SizBoxW(size: 0) : const SizBoxW(size: 0.05),
                        InkWell(
                          onTap: () {
                            BlocProvider.of<MatchCubit>(context).profileLikeDislikeApi(
                                uid: Provider.of<HomeProvider>(context, listen: false).uid,
                                proId: detailProvider.detailModel.profileinfo!.profileId.toString(),
                                // action: "LIKE".tr).then((value) {
                                action: AppLocalizations.of(context)?.translate("LIKE") ?? "LIKE").then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(height: 55,width: 55,decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color:  Colors.red
                          ),
                            child: Center(child: SvgPicture.asset("assets/icons/Heart-fill1.svg",colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),height: 25,width: 25,)),),
                        ),
                      ],
                    ) : const SizedBox(),

                  ],
                ),
              );
            }else{
              return const SizedBox();
            }
          }
        ),
        body: detailProvider.isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.appColor))
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    floating: true,
                    expandedHeight: 300,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                              ),
                              child:  Icon(Icons.close, size: 20, color: Theme.of(context).indicatorColor)),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: BackdropFilter(
                              filter:
                              ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: RichText(text: TextSpan(children: [
                                TextSpan(text: "${detailProvider.detailModel.profileinfo!.profileDistance} ",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                                // TextSpan(text: "Away".tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                                TextSpan(text: AppLocalizations.of(context)?.translate("Away") ?? "Away",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                              ])),
                            ),
                          ),
                        ),
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
                          child: const Icon(Icons.more_vert,color: Colors.white),
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
                                                    Text('Blocking ${detailProvider.detailModel.profileinfo!.profileName}',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),),
                                                    const SizedBox(height: 12,),
                                                    Text('Please tell us why you are blocking ${detailProvider.detailModel.profileinfo!.profileName}. Don`t worry we won`t tell them.',style: Theme.of(context).textTheme.bodySmall!,textAlign: TextAlign.center,),
                                                    const SizedBox(height: 10,),
                                                    Divider(color: Colors.grey.withOpacity(0.2)),
                                                    const SizedBox(height: 10,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.add_box_sharp,color: AppColors.appColor),
                                                        const SizedBox(width: 10,),
                                                        // Flexible(child: Text('They will not be able to find your profile and send you messages.'.tr,style: Theme.of(context).textTheme.bodySmall!,)),
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
                                                        // Flexible(child: Text('They will not be notified if you block them.'.tr,style: Theme.of(context).textTheme.bodySmall!,)),
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
                                                        // Flexible(child: Text('You can unblock them anytime in Settings.'.tr,style: Theme.of(context).textTheme.bodySmall!,)),
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
                                                            style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: AppColors.appColor)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),backgroundColor:  const MaterialStatePropertyAll(Colors.white)),
                                                            // child:  Text('Cancel'.tr,style: TextStyle(color: AppColors.appColor)),
                                                            child:  Text(AppLocalizations.of(context)?.translate("Cancel") ?? "Cancel",style: TextStyle(color: AppColors.appColor)),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5,),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              detailProvider.profileblockApi(context: context, profileblock: "${detailProvider.detailModel.profileinfo!.profileId}");
                                                              // print(" + + + + + :--- ${detailProvider.detailModel.profileinfo!.profileId}");
                                                            },
                                                            style: ButtonStyle(elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),backgroundColor: MaterialStatePropertyAll(AppColors.appColor)),
                                                            // child:  Text('Yes, Block'.tr,style: TextStyle(color: Colors.white)),
                                                            child:  Text(AppLocalizations.of(context)?.translate("Yes, Block") ?? "Yes, Block",style: const TextStyle(color: Colors.white)),
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
                                                    Text(
                                                        // 'Block'.tr,
                                                        AppLocalizations.of(context)?.translate("Block") ?? "Block",
                                                        style: Theme.of(context).textTheme.bodySmall!,
                                                        maxLines: 2,
                                                        softWrap: true
                                                    ),
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
                                                        Center(child: Text('Reporting ${detailProvider.detailModel.profileinfo!.profileName}',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22))),
                                                        const SizedBox(height: 12,),
                                                        Text('Please tell us why you are reporting ${detailProvider.detailModel.profileinfo!.profileName}. Don`t worry we won`t tell them.',style: Theme.of(context).textTheme.bodySmall!,textAlign: TextAlign.center,),
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
                                                                  detailProvider.profilereportApi(context: context, reportid: "${detailProvider.detailModel.profileinfo!.profileId}", comment: rejectmsg);
                                                                  print(" + + + + + + + + + :----  $rejectmsg");
                                                                },
                                                                style: ButtonStyle(elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),backgroundColor: MaterialStatePropertyAll(AppColors.appColor)),
                                                                // child: Text('Continue'.tr,style: TextStyle(color: Colors.white)),
                                                                child: Text(AppLocalizations.of(context)?.translate("Continue") ?? "Continue",style: const TextStyle(color: Colors.white)),
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
                                                        // 'Report'.tr,
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
                    ),
                    automaticallyImplyLeading: false,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child: Column(
                        children: [
                          detailProvider.detailModel.profileinfo!.profileImages!.length > 1 ? SizedBox(
                            height: 25,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(
                                detailProvider.detailModel.profileinfo!.profileImages!.length,
                                  (index) {
                                  return Indicator(
                                    isActive: detailProvider.slider == index
                                        ? true
                                        : false,
                                  );
                                }),
                              ],
                            ),
                          ) : const SizedBox(),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              border: Border.all(color: Theme.of(context).scaffoldBackgroundColor,width: 5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  flexibleSpace: FlexibleSpaceBar(
                      background: CarouselSlider.builder(
                          itemCount: detailProvider
                              .detailModel.profileinfo!.profileImages!.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("${Config.baseUrl}${detailProvider.detailModel.profileinfo!.profileImages![itemIndex]}"),
                                    fit: BoxFit.cover
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              viewportFraction: 1,
                              height: MediaQuery.of(context).size.height / 2,
                              autoPlay:detailProvider.detailModel.profileinfo!.profileImages!.length > 1 ? true : false,
                              enableInfiniteScroll:detailProvider.detailModel.profileinfo!.profileImages!.length > 1 ? true : false,
                              onPageChanged: (i, r) {
                                detailProvider.updateSlider(i);
                              }
                             )
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${detailProvider.detailModel.profileinfo!.profileName} (${detailProvider.detailModel.profileinfo!.profileAge})",
                                style: Theme.of(context).textTheme.headlineSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(width: 10,),
                              detailProvider.detailModel.profileinfo!.isVerify == "0" ? const Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Image(image: AssetImage("assets/icons/newverfy.png"),height: 22,width: 22,),
                              ) : detailProvider.detailModel.profileinfo!.isVerify == "2" ? const Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Image(image: AssetImage("assets/icons/approveicon.png"),height: 22,width: 22,),
                              ) : const SizedBox()
                            ],
                          ),
                          Text(
                            detailProvider.detailModel.profileinfo!.profileBio ??
                                "",
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            // "Interests".tr,
                            AppLocalizations.of(context)?.translate("Interests") ?? "Interests",
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20),
                          ),
                          const SizBoxH(size: 0.02),
                          Wrap(
                            spacing: 13,
                            runSpacing: 13,
                            children: [
                              for (int a = 0; a < detailProvider.detailModel.profileinfo!.interestList!.length; a++)
                                Builder(builder: (context) {
                                  InterestListElement data = detailProvider.detailModel.profileinfo!.interestList![a];
                                  return InkWell(
                                    onTap: () {

                                      // if (onBordingProvider.selectHobi.contains(data.id) ==
                                      //   true) {
                                      //   onBordingProvider.removeHobi(data.id);
                                      // } else {
                                      //   if (onBordingProvider.selectHobi.length < 5) {
                                      //       onBordingProvider.addInHobi(data.id);
                                      //   }
                                      // }

                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                              color: Theme.of(context).dividerTheme.color!)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(data.title.toString(), style: Theme.of(context).textTheme.bodySmall!),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Image.network(
                                            "${Config.baseUrl}/${data.img}",
                                            height: 24,
                                            width: 24,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            ],
                          ),

                          const SizBoxH(size: 0.03),

                          Text(
                            // "Languages I Know".tr,
                            AppLocalizations.of(context)?.translate("Languages I Know") ?? "Languages I Know",
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20),
                          ),

                          const SizBoxH(size: 0.02),

                          Wrap(
                            spacing: 13,
                            runSpacing: 13,
                            children: [
                              for (int a = 0; a < detailProvider.detailModel.profileinfo!.languageList!.length; a++)
                              Builder(
                                    builder: (context) {
                                    InterestListElement data = detailProvider.detailModel.profileinfo!.languageList![a];

                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(40), border: Border.all(color: Theme.of(context).dividerTheme.color!)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [

                                        Text(data.title.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                ),

                                        const SizedBox(
                                          width: 5,
                                        ),

                                        Image.network(
                                          "${Config.baseUrl}/${data.img}",
                                          height: 24,
                                          width: 24,
                                        )

                                      ],
                                    ),
                                  );

                                })
                            ],
                          ),

                          const SizBoxH(size: 0.03),
                          Text(
                            // "Relationship Goals".tr,
                            AppLocalizations.of(context)?.translate("Relationship Goals") ?? "Relationship Goals",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 20),
                          ),
                          const SizBoxH(size: 0.02),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: Theme.of(context).dividerTheme.color!)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(detailProvider.detailModel.profileinfo!.relationTitle ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        ),
                              ],
                            ),
                          ),

                          const SizBoxH(size: 0.03),
                          Text(
                            // "Religion".tr,
                            AppLocalizations.of(context)?.translate("Religion") ?? "Religion",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 20),
                          ),
                          const SizBoxH(size: 0.02),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: Theme.of(context).dividerTheme.color!)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    detailProvider.detailModel.profileinfo!
                                            .religionTitle ??
                                        "",
                                    style: Theme.of(context).textTheme.bodySmall!),
                              ],
                            ),
                          ),
                          const SizBoxH(size: 0.03),
                          detailProvider.detailModel.profileinfo!.height == null ? const SizedBox() : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "Height".tr,
                                AppLocalizations.of(context)?.translate("Height") ?? "Height",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 20),
                              ),
                              const SizBoxH(size: 0.01),
                            Text(
                                "${detailProvider.detailModel.profileinfo!.height} cm",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 18),
                              ),
                              const SizBoxH(size: 0.03),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
    ));
  }
}
