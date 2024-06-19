// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:dating/core/ui.dart';
import 'package:dating/presentation/screens/BottomNavBar/match/browes.dart';
import 'package:dating/presentation/screens/BottomNavBar/chats.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/BottomNavBar/home_screen.dart';
import 'package:dating/presentation/screens/BottomNavBar/mapscreen.dart';
import 'package:dating/presentation/screens/chatroom/chatroom.dart';
import 'package:dating/presentation/screens/other/premium/premium.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import '../../../Logic/cubits/Home_cubit/home_cubit.dart';
import '../../../Logic/cubits/Home_cubit/homestate.dart';

class BottomBar extends StatefulWidget {
  static const String bottomBarRoute = "/bottomBar";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  List pages = [
    // HomePage(),
    const HomeScreen(),
    const MapScreen(),
    const BrowesPage(),
    // const LikesScreen(),
    // const Chatroom()
    const  ChatScreen(),
    const ProfilePage(),
  ];
  List bottomItems = [
    "Home",
    "Maps",
    "Match",
    "Chats",
    "Profile",
  ];

  List bottomItemsIcons = [
    "assets/icons/Home.svg",
    "assets/icons/Discovery.svg",
    "assets/icons/Heart.svg",
    "assets/icons/Chat.svg",
    "assets/icons/Profile.svg",
  ];

  List bottomItemsIconsfill = [
    "assets/icons/Home-fill.svg",
    "assets/icons/Discovery-fill.svg",
    "assets/icons/Heart-fill.svg",
    "assets/icons/Chat-fill.svg",
    "assets/icons/Profile-fill.svg",
  ];

  late HomeProvider homeProvider;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     homeProvider.selectPageIndex = index;
  //   });
  // }

 @override
  void initState() {
    super.initState();
    // BlocProvider.of<HomePageCubit>(context,listen: false).initforHome(context);
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          extendBody: true,
          // backgroundColor: Color(0x27262b),
          backgroundColor: Colors.transparent,
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: Container(
          //   color: Colors.transparent,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: Container(
          //           height: 63,
          //           margin: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
          //           // width: MediaQuery.of(context).size.width,
          //           decoration: BoxDecoration(
          //             color: const Color(0xff27262B),
          //             borderRadius: BorderRadius.circular(30),
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               BlocBuilder<HomePageCubit, HomePageStates>(
          //                   builder: (context, state) {
          //                     if(state is HomeCompleteState){
          //                       return ListView.builder(
          //                         clipBehavior: Clip.none,
          //                         // physics: const NeverScrollableScrollPhysics(),
          //                         itemCount: bottomItemsIcons.length,
          //                         shrinkWrap: true,
          //                         padding: EdgeInsets.zero,
          //                         scrollDirection: Axis.horizontal,
          //                         itemBuilder: (context, index) {
          //                           return InkWell(
          //                               onTap: () {
          //                                 homeProvider.setSelectPage(index);
          //                                 if(homeProvider.selectPageIndex == 2 && state.homeData.likeMenu == "0") {
          //                                   homeProvider.setSelectPage(0);
          //                                   Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
          //                                 }else if(homeProvider.selectPageIndex == 3 && (state.homeData.chat == "0")) {
          //                                   homeProvider.setSelectPage(0);
          //                                   Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
          //                                 }
          //                               },
          //                               child: Container(
          //                                 height: 45,
          //                                 // width: 50,
          //                                 width: constraints.maxWidth * 0.1833,
          //                                 margin: const EdgeInsets.symmetric(vertical: 5),
          //                                 decoration: BoxDecoration(
          //                                   color: homeProvider.selectPageIndex == index ? AppColors.white : Colors.transparent,
          //                                   shape: BoxShape.circle,
          //                                 ),
          //                                 // color: Colors.red,
          //                                 child: Column(
          //                                   mainAxisAlignment: MainAxisAlignment.center,
          //                                   children: [
          //
          //                                     SvgPicture.asset(
          //                                       homeProvider.selectPageIndex == index ? bottomItemsIconsfill[index] : bottomItemsIcons[index],
          //                                       width: 22,
          //                                       height: 22,
          //                                       color: homeProvider.selectPageIndex == index
          //                                           ? AppColors.appColor
          //                                           : AppColors.white,
          //                                     ),
          //
          //                                     // const SizedBox(
          //                                     //   height: 3,
          //                                     // ),
          //
          //                                     // Flexible(
          //                                     //     child: Text(
          //                                     //         bottomItems[index].toString(),
          //                                     //         style: TextStyle(
          //                                     //             fontSize: 12,
          //                                     //             color: homeProvider.selectPageIndex == index ? AppColors.appColor : Theme.of(context).indicatorColor,
          //                                     //             fontWeight: FontWeight.w400,
          //                                     //             fontFamily: FontFamilyy.medium
          //                                     //         ),
          //                                     //         overflow: TextOverflow.ellipsis
          //                                     //     )),
          //
          //                                   ],
          //                                 ),
          //                               ));
          //                         },
          //                       );
          //                     }else{
          //                       return ListView.builder(
          //                         clipBehavior: Clip.none,
          //                         // physics: const NeverScrollableScrollPhysics(),
          //                         itemCount: bottomItemsIcons.length,
          //                         shrinkWrap: true,
          //                         scrollDirection: Axis.horizontal,
          //                         itemBuilder: (context, index) {
          //
          //                           return Container(
          //                             height: 50,
          //                             // width: 50,
          //                             // width: constraints.maxWidth * 0.18,
          //                             // margin: EdgeInsets.all(10),
          //                             width: constraints.maxWidth * 0.1833,
          //                             margin: const EdgeInsets.symmetric(vertical: 5),
          //                             decoration: BoxDecoration(
          //                                 color: homeProvider.selectPageIndex == index ? AppColors.white : Colors.transparent,
          //                                 shape: BoxShape.circle
          //                             ),
          //                             // color: Colors.red,
          //                             child: Column(
          //                               mainAxisAlignment: MainAxisAlignment.center,
          //                               children: [
          //
          //                                 SvgPicture.asset(
          //                                   homeProvider.selectPageIndex == index ? bottomItemsIconsfill[index] : bottomItemsIcons[index],
          //                                   width: 22,
          //                                   height: 22,
          //                                   color: homeProvider.selectPageIndex == index
          //                                       ? AppColors.appColor
          //                                       : AppColors.white,
          //                                 ),
          //
          //                                 // const SizedBox(
          //                                 //   height: 3,
          //                                 // ),
          //                                 //
          //                                 // Flexible(
          //                                 //     child: Text(
          //                                 //         bottomItems[index].toString(),
          //                                 //         style: TextStyle(
          //                                 //             fontSize: 12,
          //                                 //             color: homeProvider.selectPageIndex == index ? AppColors.appColor : Theme.of(context).indicatorColor,
          //                                 //             fontWeight: FontWeight.w400,
          //                                 //             fontFamily: FontFamilyy.medium
          //                                 //         ),
          //                                 //         overflow: TextOverflow.ellipsis
          //                                 //     )
          //                                 // ),
          //
          //                               ],
          //                             ),
          //                           );
          //                         },
          //                       );
          //                     }
          //                   }
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          bottomNavigationBar: Container(
            // color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 63,
                    margin: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xff27262B),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BlocBuilder<HomePageCubit, HomePageStates>(
                            builder: (context, state) {
                            if(state is HomeCompleteState){
                              return ListView.builder(
                                clipBehavior: Clip.none,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: bottomItemsIcons.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        homeProvider.setSelectPage(index);
                                        // if(homeProvider.selectPageIndex == 2 && state.homeData.likeMenu == "0") {
                                        //   homeProvider.setSelectPage(0);
                                        //   Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
                                        // }else if(homeProvider.selectPageIndex == 3 && (state.homeData.chat == "0")) {
                                        //   homeProvider.setSelectPage(0);
                                        //   Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
                                        // }
                                      },
                                      child: Container(
                                        height: 45,
                                        // width: 50,
                                        width: constraints.maxWidth * 0.1833,
                                       margin: const EdgeInsets.symmetric(vertical: 5),
                                       decoration: BoxDecoration(
                                           color: homeProvider.selectPageIndex == index ? AppColors.white : Colors.transparent,
                                         shape: BoxShape.circle,
                                       ),
                                        // color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [

                                            SvgPicture.asset(
                                              homeProvider.selectPageIndex == index ? bottomItemsIconsfill[index] : bottomItemsIcons[index],
                                              width: 22,
                                              height: 22,
                                              color: homeProvider.selectPageIndex == index
                                                  ? AppColors.appColor
                                                  : AppColors.white,
                                            ),

                                            // const SizedBox(
                                            //   height: 3,
                                            // ),

                                            // Flexible(
                                            //     child: Text(
                                            //         bottomItems[index].toString(),
                                            //         style: TextStyle(
                                            //             fontSize: 12,
                                            //             color: homeProvider.selectPageIndex == index ? AppColors.appColor : Theme.of(context).indicatorColor,
                                            //             fontWeight: FontWeight.w400,
                                            //             fontFamily: FontFamilyy.medium
                                            //         ),
                                            //         overflow: TextOverflow.ellipsis
                                            //     )),

                                          ],
                                        ),
                                      ));
                                },
                              );
                            }else{
                              return ListView.builder(
                                clipBehavior: Clip.none,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: bottomItemsIcons.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {

                                  return Container(
                                    height: 50,
                                    // width: 50,
                                    // width: constraints.maxWidth * 0.18,
                                    // margin: EdgeInsets.all(10),
                                    width: constraints.maxWidth * 0.1833,
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        color: homeProvider.selectPageIndex == index ? AppColors.white : Colors.transparent,
                                        shape: BoxShape.circle
                                    ),
                                    // color: Colors.red,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        SvgPicture.asset(
                                          homeProvider.selectPageIndex == index ? bottomItemsIconsfill[index] : bottomItemsIcons[index],
                                          width: 22,
                                          height: 22,
                                          color: homeProvider.selectPageIndex == index
                                              ? AppColors.appColor
                                              : AppColors.white,
                                        ),

                                        // const SizedBox(
                                        //   height: 3,
                                        // ),
                                        //
                                        // Flexible(
                                        //     child: Text(
                                        //         bottomItems[index].toString(),
                                        //         style: TextStyle(
                                        //             fontSize: 12,
                                        //             color: homeProvider.selectPageIndex == index ? AppColors.appColor : Theme.of(context).indicatorColor,
                                        //             fontWeight: FontWeight.w400,
                                        //             fontFamily: FontFamilyy.medium
                                        //         ),
                                        //         overflow: TextOverflow.ellipsis
                                        //     )
                                        // ),

                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        ),
                         ],
                       ),
                     ),
                ),
                 ],
               ),
          ),
          body: pages[homeProvider.selectPageIndex],
        );
      },
    );
  }
}
