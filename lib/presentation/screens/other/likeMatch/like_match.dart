import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating/core/config.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/presentation/firebase/chat_page.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/other/likeMatch/likematch_provider.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../language/localization/app_localization.dart';
import '../../BottomNavBar/home_screen.dart';

class LikeMatchScreen extends StatefulWidget {
  static const String likeMatchScreenRoute = "/likeMatchScreen";
  const LikeMatchScreen({Key? key}) : super(key: key);

  @override
  State<LikeMatchScreen> createState() => _LikeMatchScreenState();
}

class _LikeMatchScreenState extends State<LikeMatchScreen> with TickerProviderStateMixin {
  late LikeMatchProvider likeMatchProvider;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    likeMatchProvider = Provider.of<LikeMatchProvider>(context,listen: false);
    controller = AnimationController(vsync: this);
    if(likeMatchProvider.isHome){
      likeMatchProvider.profileViewApi(uid: Provider.of<HomeProvider>(context,listen: false).uid, profileId: likeMatchProvider.likeMatchData.first.profileId);
    }
  }

  @override
  dispose() {
    controller.dispose();
    likeMatchProvider.likeMatchData.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    likeMatchProvider = Provider.of<LikeMatchProvider>(context);
    return Scaffold(
      appBar: AppBar(leading: const BackButtons(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset("assets/Image/multiheart.json",controller: controller,
            repeat: true,
            delegates: LottieDelegates(
              values: [
                ValueDelegate.color(
                  const ['**', 'Red Heart Comp 1', '**'],
                  value: AppColors.appColor,
                ),
              ],
            ),
            onLoaded: (p0) {
            controller..duration = const Duration(milliseconds: 4500)..forward().then((value) {
              controller.repeat();
            });
          },),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        children: [
                  // TextSpan(text: "You and ".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:AppColors.appColor,fontSize: 25)),
                  TextSpan(text: AppLocalizations.of(context)?.translate("You and ") ?? "You and ",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:AppColors.appColor,fontSize: 25)),
                  TextSpan(text: "${likeMatchProvider.likeMatchData[likeMatchProvider.interIndex].profileName}",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:AppColors.appColor.withOpacity(0.5),fontSize: 25)),
                  // TextSpan(text: " liked each other!".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:AppColors.appColor,fontSize: 25)),
                  TextSpan(text: AppLocalizations.of(context)?.translate(" liked each other!") ?? " liked each other!",style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:AppColors.appColor,fontSize: 25)),
                ])),
              ),
              const Spacer(flex: 3),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [

                  CarouselSlider(
                      items: [
                        for(int a =0; a<likeMatchProvider.likeMatchData.length; a++)
                        Row(
                        children: [const SizedBox(width: 12,),
                         Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.27,
                            decoration:  BoxDecoration(
                              border: Border.all(color: AppColors.appColor,width: 8),
                              image: DecorationImage(image: NetworkImage("${Config.baseUrl}${Provider.of<HomeProvider>(context).userlocalData.userLogin!.otherPic.toString().split("\$;").first}"),fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(80),bottomLeft: Radius.circular(80),topRight: Radius.circular(80)),
                            ),
                          ),
                         ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration:  BoxDecoration(
                              image: DecorationImage(image: NetworkImage("${Config.baseUrl}${likeMatchProvider.likeMatchData[likeMatchProvider.interIndex].profileImages.first}"),fit: BoxFit.cover),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(80),bottomRight: Radius.circular(80),topRight: Radius.circular(80)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12,),
                          ],
                        ),
                      ],
                      options: CarouselOptions(
                        enableInfiniteScroll:  likeMatchProvider.likeMatchData.length ==1 ? false : true,
                        onPageChanged: (i, r) {

                          if(likeMatchProvider.isHome){
                            likeMatchProvider.profileViewApi(uid: Provider.of<HomeProvider>(context,listen: false).uid, profileId: likeMatchProvider.likeMatchData[i].profileId);
                          }

                          likeMatchProvider.upDateinnerindex(i);

                      },
                      viewportFraction: 1,
                      autoPlay: true
                  )),

                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff4B164C),
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [

                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                                backgroundColor: AppColors.appColor.withOpacity(0.5),
                                valueColor:  AlwaysStoppedAnimation(AppColors.appColor),
                                value: double.parse("0.${likeMatchProvider.likeMatchData[likeMatchProvider.interIndex].matchRatio.toString().split(".").first}")),
                          ),

                          Text(
                            "${likeMatchProvider.likeMatchData[likeMatchProvider.interIndex].matchRatio.toString().split(".").first}%",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white,fontWeight: FontWeight.w800),
                          ),

                        ],
                      ),
                    ),
                  ),

                  likeMatchProvider.likeMatchData.length == 1 ?
                  const SizedBox() :
                  Positioned(
                    bottom: -30,
                    child : SizedBox(
                      height: 25,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                                likeMatchProvider.likeMatchData.length,
                                (index) {
                                return Indicator(
                                  isActive: likeMatchProvider.interIndex == index ? true : false,
                                );
                             },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 3),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    // MainButton(title: "Send a message".tr,iconpath: "assets/icons/chattingIcon.svg",onTap: () {
                    MainButton(title: AppLocalizations.of(context)?.translate("Send a message") ?? "Send a message",iconpath: "assets/icons/chattingIcon.svg",onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingPage(resiverUserId: likeMatchProvider.likeMatchData[likeMatchProvider.interIndex].profileId, resiverUseremail: likeMatchProvider.likeMatchData[likeMatchProvider.interIndex].profileName, proPic: likeMatchProvider.likeMatchData[likeMatchProvider.interIndex].profileImages.first),));
                    },),
                    const SizedBox(height: 10,),
                    // MainButton(title: "Keep Swiping".tr,iconpath: "assets/icons/swiping.svg",),
                    MainButton(title: AppLocalizations.of(context)?.translate("Keep Swiping") ?? "Keep Swiping",iconpath: "assets/icons/swiping.svg",onTap: () {
                      Navigator.pop(context);
                    },),
                  ],
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
