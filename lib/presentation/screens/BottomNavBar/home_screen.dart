import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating/Logic/cubits/Home_cubit/home_cubit.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/BottomNavBar/notification_page.dart';
import 'package:dating/presentation/screens/other/editProfile/editprofile_provider.dart';
import 'package:dating/presentation/screens/other/likeMatch/like_match.dart';
import 'package:dating/presentation/screens/other/likeMatch/likematch_provider.dart';
import 'package:dating/presentation/screens/other/premium/premium.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../Logic/cubits/Home_cubit/homestate.dart';
import '../../../Logic/cubits/onBording_cubit/onbording_cubit.dart';
import '../../../core/config.dart';
import '../../../core/ui.dart';
import '../../../language/localization/app_localization.dart';
import '../../firebase/chat_page.dart';
import '../../widgets/sizeboxx.dart';
import '../other/editProfile/editprofile.dart';
import '../other/profileAbout/detailprovider.dart';
import '../other/profileAbout/detailscreen.dart';
import '../splash_bording/onBordingProvider/onbording_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String homeScrennRoute = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  late HomeProvider homeProvider;
  late EditProfileProvider editProfileProvider;

  @override
  void initState() {
    super.initState();
   StackTrace;
    BlocProvider.of<HomePageCubit>(context).initforHome(context);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    initForHome();
    homeProvider.localData(context);
    homeProvider.controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400),);
    homeProvider.animation = Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, -1.0)).animate(homeProvider.controller);
  }

  initForHome(){
    BlocProvider.of<OnbordingCubit>(context).religionApi().then((value) {
      editProfileProvider.valuInReligion(value.religionlist!);
      BlocProvider.of<OnbordingCubit>(context).relationGoalListApi().then((value) {
        editProfileProvider.valuInrelationShip(value.goallist!);
        BlocProvider.of<OnbordingCubit>(context).languagelistApi().then((value)  {
          editProfileProvider.valuInLanguage(value.languagelist!);
          BlocProvider.of<OnbordingCubit>(context).getInterestApi().then((value) {
            editProfileProvider.valuInIntrest(value.interestlist!);
          });
        });
      });
    });
  }

  @override
  void dispose() {
    homeProvider.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StackTrace;
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar:  PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: BlocBuilder<HomePageCubit, HomePageStates>(
                builder: (context, state) {
                  if (state is HomeCompleteState) {
          return  Container(
            // height: 70,

            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Theme.of(context).scaffoldBackgroundColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    homeProvider.userlocalData.userLogin!.profilePic != null ? Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("${Config.baseUrl}${homeProvider.userlocalData.userLogin!.profilePic}"),
                              fit: BoxFit.cover
                          ),
                      ),
                    ) : Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                          shape: BoxShape.circle,
                          // image: DecorationImage(image: NetworkImage("${Config.baseUrl}${homeProvider.userlocalData.userLogin!.profilePic}"), fit: BoxFit.cover)
                      ),
                      child: Center(child: Text("${homeProvider.userlocalData.userLogin!.name?[0]}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    ),
                    const SizBoxW(size: 0.02),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                                  children: [
                                  // TextSpan(text: "Hello".tr,style: Theme.of(context).textTheme.bodySmall,),
                                  TextSpan(text: AppLocalizations.of(context)?.translate("Hello") ?? "Hello",style: Theme.of(context).textTheme.bodySmall,),
                                  TextSpan(text: " 👋",style: Theme.of(context).textTheme.bodySmall,),
                           ])
                          ),

                          Text(
                            "${homeProvider.userlocalData.userLogin!.name}",
                            style: Theme.of(context).textTheme.headlineSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                        ],
                      ),
                    ),

                    // const Spacer(),

                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,  NotificationPage.notificationRoute);
                        },
                        child: SvgPicture.asset("assets/icons/notificationicon.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),)),
                    const SizBoxW(size: 0.03),
                    InkWell(
                        onTap: () {
                          state.homeData.filterInclude == "1"? Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute):
                          homeProvider.filterBottomSheet(context);
                        },
                        child: SvgPicture.asset("assets/icons/Filter.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),)
                    ),
                  ],
                ),

                // Spacer(),
              ],
            ),
          );
          }else{
            return const SizedBox();
          }
        }
              ),
            ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<HomePageCubit, HomePageStates>(
          builder: (context1, state) {
            if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator(color: AppColors.appColor));
            } else if (state is HomeCompleteState) {
              return state.homeData.profilelist!.isEmpty ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                   children: [
                     const Spacer(),
                     // Text("No New Profiles".tr,style: Theme.of(context).textTheme.headlineMedium,),
                     Text(AppLocalizations.of(context)?.translate("No New Profiles") ?? "No New Profiles",style: Theme.of(context).textTheme.headlineMedium,),
                     // Text("Change your preferences to expand your search and see new profiles.".tr,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center),
                     Text(AppLocalizations.of(context)?.translate("Change your preferences to expand your search and see new profiles.") ?? "Change your preferences to expand your search and see new profiles.",style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center),
                     const Spacer(),
                     MainButton(
                        bgColor: AppColors.appColor,
                        // title: "Change my preferences".tr,onTap: () {
                        title: AppLocalizations.of(context)?.translate("Change my preferences") ?? "Change my preferences",onTap: () {
                        homeProvider.setSelectPage(4);
                        Navigator.pushNamed(context, EditProfile.editProfileRoute);
                     },),
                     const SizedBox(height: 12,),
                     MainButton(
                       // title: "Refresh".tr,
                       title: AppLocalizations.of(context)?.translate("Refresh") ?? "Refresh",
                       bgColor: AppColors.borderColor,
                       titleColor: AppColors.black,
                       onTap: () {
                       BlocProvider.of<HomePageCubit>(context).initforHome(context);
                     },
                   ),

                   ],
                ),
              ) :
              Stack(
                   clipBehavior: Clip.none,
                   alignment: Alignment.bottomCenter,
                   children: [
                   PageView.builder(
                       itemCount: state.homeData.profilelist!.length,
                       onPageChanged: (i) {
                         homeProvider.upDateCurrentindex(i);
                       },
                       itemBuilder: (context, index) {
                         int nextIndex = homeProvider.currentIndex == state.homeData.profilelist!.length - 1 ? 0 : homeProvider.currentIndex + 1;
                         return index == state.homeData.profilelist!.length - 1 ? const SizedBox() :
                         SingleChildScrollView(
                           physics: const NeverScrollableScrollPhysics(),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 15.0),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(48),
                               child: SizedBox(
                                 height: MediaQuery.of(context).size.height / 1.45,
                                 child: Stack(
                                   children: [
                                     Container(
                                       height: MediaQuery.of(context).size.height / 1.45,
                                       width: MediaQuery.of(context).size.width,
                                       decoration: BoxDecoration(
                                         color: Theme.of(context).cardColor,
                                           image: DecorationImage(
                                               image: NetworkImage("${Config.baseUrl}${state.homeData.profilelist![nextIndex].profileImages!.first}"),
                                               fit: BoxFit.cover
                                           )),
                                     ),

                                     Stack(
                                       alignment: Alignment.bottomCenter,
                                       children: [
                                         Container(
                                           height: MediaQuery.of(context).size.height / 1.45,
                                           width: MediaQuery.of(context).size.width,
                                           decoration: BoxDecoration(
                                             gradient: LinearGradient(
                                               begin: Alignment.topCenter,
                                               end: Alignment.bottomCenter,
                                               stops: const [0.4, 1, 1.5],
                                               colors: [
                                                 Colors.transparent,
                                                 AppColors.appColor,
                                                 AppColors.appColor,
                                               ],
                                             ),
                                           ),
                                         ),

                                         Padding(
                                           padding: const EdgeInsets.all(15.0),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.end,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 crossAxisAlignment: CrossAxisAlignment.end,
                                                 children: [

                                                   Expanded(
                                                     child: Text(
                                                       "${state.homeData.profilelist![nextIndex].profileName}",
                                                       style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                                                       overflow: TextOverflow.ellipsis,
                                                       maxLines: 1,
                                                     ),
                                                   ),

                                                   Expanded(
                                                     child: Text(
                                                       ",${state.homeData.profilelist![nextIndex].profileAge}",
                                                       style: Theme.of(context)
                                                           .textTheme
                                                           .headlineSmall!
                                                           .copyWith(
                                                           color: Colors.white),
                                                       overflow: TextOverflow.ellipsis,
                                                       maxLines: 1,
                                                     ),
                                                   ),

                                                   // const Spacer(),
                                                   Expanded(
                                                     child: Column(
                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                       children: [
                                                         Stack(
                                                           alignment: Alignment.center,
                                                           clipBehavior: Clip.none,
                                                           children: [

                                                             SizedBox(
                                                               height: 50,
                                                               width: 50,
                                                               child: CircularProgressIndicator(
                                                                   backgroundColor: Colors.white.withOpacity(0.3),
                                                                   valueColor: const AlwaysStoppedAnimation(Colors.white),
                                                                   value: (double.parse(state.homeData.profilelist![nextIndex].matchRatio.toString().split(".").first) /100)
                                                               ),
                                                             ),
                                                             state.homeData.profilelist![nextIndex].isSubscribe != "0"?  Row(
                                                               children: [
                                                                 Image.asset("assets/Image/premium.png",height: 25,width: 25,),
                                                                 const SizedBox(width: 8,),
                                                                 Text("Premium",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),)
                                                               ],
                                                             ) : const SizedBox(),
                                                             state.homeData.profilelist![nextIndex].isSubscribe != "0"? const SizBoxH(size: 0.02) : const SizedBox(),
                                                             Text(
                                                               "${state.homeData.profilelist![nextIndex].matchRatio.toString().split(".").first}%",
                                                               style: Theme.of(context)
                                                                   .textTheme
                                                                   .bodySmall!
                                                                   .copyWith(color: Colors.white),
                                                             ),

                                                           ],
                                                         ),
                                                         const SizBoxH(size: 0.02),
                                                         Container(
                                                           padding:
                                                               const EdgeInsets.symmetric(
                                                                   vertical: 6,
                                                                   horizontal: 12
                                                               ),
                                                           decoration:
                                                               BoxDecoration(
                                                             borderRadius: BorderRadius.circular(16),
                                                             color: const Color(0xffF0F0F0).withOpacity(0.25),
                                                           ),
                                                           child: Row(
                                                             children: [
                                                               SvgPicture.asset(
                                                                 "assets/icons/Location.svg",
                                                                 height: 15,
                                                                 width: 15,
                                                               ),
                                                               const SizBoxW(size: 0.02),
                                                               Expanded(
                                                                 child: Text(
                                                                   state.homeData.profilelist![
                                                                   nextIndex].profileDistance.toString(),
                                                                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white,fontSize: 12),
                                                                   overflow: TextOverflow.ellipsis,
                                                                   maxLines: 1,
                                                                 ),
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                               Text(
                                                 "${state.homeData.profilelist![nextIndex].profileBio}",
                                                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                                                 overflow: TextOverflow.ellipsis,
                                                 maxLines: 1,
                                               ),
                                               const SizBoxH(size: 0.04),
                                             ],
                                           ),
                                         ),

                                       ],
                                     ),

                                     state.homeData.profilelist![nextIndex].profileImages!.length> 1?  SizedBox(
                                       height: 25,
                                       width : MediaQuery.of(context).size.width,
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [

                                           ...List.generate(
                                               state.homeData.profilelist![nextIndex].profileImages!.length,
                                               (index) {
                                               return Indicator(
                                                 isActive: homeProvider.interIndex1 == index ? true : false,
                                               );
                                           }),

                                         ],
                                       ),
                                     ) : const SizedBox(),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         );
                       },
                     ),

                   InkWell(
                    onTap: () {
                      var lat = Provider.of<OnBordingProvider>(context, listen: false).lat;
                      var long = Provider.of<OnBordingProvider>(context, listen: false).long;
                      Provider.of<DetailProvider>(context, listen: false).updateIsMatch(false);
                      Provider.of<DetailProvider>(context, listen: false).status = "1";
                      Provider.of<DetailProvider>(context, listen: false).detailsApi(uid: homeProvider.userlocalData.userLogin!.id ?? "", lat: lat.toString(), long: long.toString(), profileId: state.homeData.profilelist![homeProvider.currentIndex].profileId ?? '').then((value) {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.detailScreenRoute,
                        );
                      });
                    },
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.homeData.profilelist!.length,
                      onPageChanged: (i) {
                        homeProvider.upDateCurrentindex(i);
                      },
                      itemBuilder: (context, index) {
                        if (state.homeData.profilelist!.isEmpty) {
                          return const SizedBox();
                        } else {
                          return SlideTransition(
                          position: homeProvider.animation,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48),
                                  child:   Container(
                                  color:  Theme.of(context).cardColor,
                                  height:  MediaQuery.of(context).size.height / 1.45,
                                  child: Stack(
                                    children: [

                                      CarouselSlider.builder(
                                        itemCount: state.homeData.profilelist![homeProvider.currentIndex].profileImages!.length,
                                        carouselController: homeProvider.carouselController,
                                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                                          return Container(
                                            height: MediaQuery.of(context).size.height / 1.45,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage("${Config.baseUrl}/${state.homeData.profilelist![homeProvider.currentIndex].profileImages![itemIndex]}"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        },
                                        options: CarouselOptions(
                                          autoPlay: state.homeData.profilelist![homeProvider.currentIndex].profileImages!.length > 1? true : false,
                                          enableInfiniteScroll: state.homeData.profilelist![homeProvider.currentIndex].profileImages!.length > 1? true : false,
                                          height: MediaQuery.of(context).size.height / 1.45,
                                          onPageChanged: (i, r) {
                                            homeProvider.upDateinnerindex(i);
                                          },
                                          viewportFraction: 1,
                                        ),
                                      ),


                                      Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [

                                          Positioned(
                                            bottom: 0,
                                            child: Container(
                                              height: MediaQuery.of(context).size.height / 1.45,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: const [0.4, 1, 1.5],
                                                  colors: [
                                                    Colors.transparent,
                                                    homeProvider.slidecolor,
                                                    homeProvider.slidecolor,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [

                                                    Expanded(
                                                      child: Text(
                                                        "${state.homeData.profilelist![homeProvider.currentIndex].profileName}",
                                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),

                                                    Expanded(
                                                      child: Text(
                                                        ",${state.homeData.profilelist![homeProvider.currentIndex].profileAge}",
                                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),

                                                    // const Spacer(),

                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [

                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Stack(
                                                                alignment: Alignment.center,
                                                                clipBehavior: Clip.none,
                                                                children: [

                                                                  SizedBox(
                                                                    height: 50,
                                                                    width : 50,
                                                                    child: CircularProgressIndicator(
                                                                        backgroundColor: Colors.white.withOpacity(0.3),
                                                                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                                                                        value: (double.parse(state.homeData.profilelist![homeProvider.currentIndex].matchRatio.toString().split(".").first) /100)
                                                                    ),
                                                                  ),

                                                                  Text(
                                                                    "${state.homeData.profilelist![homeProvider.currentIndex].matchRatio.toString().split(".").first}%",
                                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                                                  ),

                                                                ],
                                                              ),
                                                            ],
                                                          ),

                                                        const SizBoxH(size: 0.02),

                                                        state.homeData.profilelist![homeProvider.currentIndex].isSubscribe != "0"?  Row(
                                                            children: [
                                                              Image.asset("assets/Image/premium.png",height: 25,width: 25,),
                                                              const SizedBox(width: 8,),
                                                              // Text("Premium".tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),),
                                                              Text(AppLocalizations.of(context)?.translate("Premium") ?? "Premium",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),),
                                                            ],
                                                          ) : const SizedBox(),
                                                          state.homeData.profilelist![homeProvider.currentIndex].isSubscribe != "0"? const SizBoxH(size: 0.02) : const SizedBox(),

                                                          Container(
                                                            // width: 90,
                                                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(16),
                                                              color: const Color(0xffF0F0F0).withOpacity(0.25),
                                                            ),

                                                            child: Row(
                                                              children: [

                                                                SvgPicture.asset(
                                                                  "assets/icons/Location.svg",
                                                                  height: 15,
                                                                  width: 15,
                                                                ),

                                                                const SizBoxW(size: 0.01),

                                                                Expanded(
                                                                  child: Text(
                                                                    state.homeData.profilelist![homeProvider.currentIndex].profileDistance.toString(),
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white,fontSize: 12),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Text(
                                                  "${state.homeData.profilelist![homeProvider.currentIndex].profileBio}",
                                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),

                                                const SizBoxH(size: 0.04),

                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      state.homeData.profilelist![homeProvider.currentIndex].profileImages!.length > 1? SizedBox(
                                        height: 25,
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            ...List.generate(
                                                state.homeData.profilelist![homeProvider.currentIndex].profileImages!.length, (index) {
                                                  return Indicator(
                                                    isActive: homeProvider.interIndex == index ? true : false,
                                                  );
                                                }
                                            ),

                                            ],
                                          ),
                                        ) : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                   Positioned(
                     bottom: -7,
                     child: SizedBox(
                      height: 90,
                      child: Column(
                        children: [

                          Expanded(
                            child: ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                separatorBuilder: (c, i) {
                                  return const SizedBox(
                                    width: 20,
                                  );
                                },
                                itemCount: homeProvider.flotingIcons.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (c, i) {
                                  return Center(
                                    child: InkWell(
                                      onTap: () {

                                        if (i == 2  && state.homeData.planId == "0") {
                                          Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
                                        }
                                        if (state.homeData.profilelist!.isNotEmpty) {
                                          if (i == 0) {
                                            homeProvider.cancleButton(state, context);
                                            BlocProvider.of<HomePageCubit>(context).profileLikeDislikeApi(
                                              uid: homeProvider.uid,
                                              proId: state.homeData.profilelist![homeProvider.currentIndex].profileId!,
                                              action: "UNLIKE",
                                              lat: homeProvider.lat,
                                              long: homeProvider.long,
                                            );
                                            // Remove the current profile from the list
                                            state.homeData.profilelist!.removeAt(homeProvider.currentIndex);
                                          } else if (i == 1) {
                                            homeProvider.likeButton(state, context);
                                            BlocProvider.of<HomePageCubit>(context).profileLikeDislikeApi(
                                              uid: homeProvider.uid,
                                              proId: state.homeData.profilelist![homeProvider.currentIndex].profileId!,
                                              action: "LIKE",
                                              lat: homeProvider.lat,
                                              long: homeProvider.long,
                                            );
                                          }
                                        }

                                      },
                                      child: (i == 2 && state.homeData.planId != "0") ? (state.homeData.planId == "3") ? InkWell(
                                        onTap: () {
                                          // BlocProvider.of<HomePageCubit>(context).planDataApi(context, state.homeData.profilelist![homeProvider.currentIndex].profileId).then((value) {

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingPage(
                                                proPic: state.homeData.profilelist![homeProvider.currentIndex].profileImages!.first,
                                                resiverUserId: state.homeData.profilelist![homeProvider.currentIndex].profileId!,
                                                resiverUseremail: state.homeData.profilelist![homeProvider.currentIndex].profileName!,
                                              )));



                                          // });


                                        },
                                        child: Container(
                                          height: (i == 0 || i == homeProvider.flotingIcons.length-1) ? 60 : 72,
                                          width:  (i == 0 || i == homeProvider.flotingIcons.length-1) ? 60 : 72,
                                          decoration: BoxDecoration(color: AppColors.darkContainer,
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Center(child: SvgPicture.asset("assets/icons/Chat-fill.svg",height: 29, width: 29,)),
                                        ),
                                      ) : const SizedBox() : Container(
                                        height: (i == 0 || i == homeProvider.flotingIcons.length-1) ? 60 : 72,
                                        width:  (i == 0 || i == homeProvider.flotingIcons.length-1) ? 60 : 72,
                                        decoration: BoxDecoration(color: AppColors.darkContainer,
                                        borderRadius: BorderRadius.circular(20)),
                                        child: Center(child: SvgPicture.asset(homeProvider.flotingIcons[i],height: 29, width: 29,)),
                                      ),
                                    ),
                                  );
                                }),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                        ],
                      ),
                                       ),
                   ),

                ],
              );
            } else {
              return const SizedBox();
            }

          },
          listener: (context, state) {

            if (state is HomeErrorState) {
              Fluttertoast.showToast(msg: state.error);
            }

            if(state is HomeCompleteState) {
              if(state.homeData.totalliked!.isNotEmpty) {
                Provider.of<LikeMatchProvider>(context,listen: false).likeMatchData.addAll(state.homeData.totalliked!);
                Provider.of<LikeMatchProvider>(context,listen: false).updateIsHome(true);
                Navigator.pushNamed(context, LikeMatchScreen.likeMatchScreenRoute).then((value) {
                  BlocProvider.of<HomePageCubit>(context).getHomeData(uid: homeProvider.uid, lat: homeProvider.lat.toString(), long: homeProvider.long.toString(),context: context);
                });
              }
            }

          },
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        // duration: const Duration(microseconds: 600),
        height: isActive ?  6 : 6,
        width: isActive  ? 15 : 6,
        decoration: BoxDecoration(
          color: isActive ? AppColors.appColor : AppColors.borderColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
