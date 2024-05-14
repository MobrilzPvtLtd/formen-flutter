// ignore_for_file: avoid_print, camel_case_types

import 'dart:ui';
import 'package:dating/presentation/screens/other/profileScreen/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../core/config.dart';
import '../../../../core/ui.dart';
import '../../../../language/localization/app_localization.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/other_widget.dart';

class Block_List extends StatefulWidget {
  const Block_List({Key? key}) : super(key: key);

  @override
  State<Block_List> createState() => _Block_ListState();
}

class _Block_ListState extends State<Block_List> {

  late ProfileProvider profileProvider;

  @override
  void initState() {
    // TODO: implement initState
    profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    profileProvider.blocklistaApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: const BackButtons(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Blocked Users (${profileProvider.blocklistApi.blocklist?.length})",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:
      // profileProvider.isLoading
      //     ?
      profileProvider.blocklistApi.blocklist!.isEmpty ? notFoundPage() : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // GridView.builder(
              //   shrinkWrap: true,
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: profileProvider.blocklistApi.blocklist?.length,
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: 10,
              //       crossAxisSpacing: 10,
              //       mainAxisExtent: 250
              //   ),
              //   itemBuilder: (context, index) {
              //     // Profilelist data = newMatchModel.profilelist![index];
              //     return InkWell(
              //       onTap: () {
              //         showModalBottomSheet(
              //           context: context,
              //           // backgroundColor: Colors.white,
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
              //           builder: (context) {
              //             return Stack(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.all(15),
              //                   child: SingleChildScrollView(
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         // Text("From where do you want to take the photo?".tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20)),
              //                         Text(AppLocalizations.of(context)?.translate("Unblock ${profileProvider.blocklistApi.blocklist?[index].profileName}?") ?? "Unblock ${profileProvider.blocklistApi.blocklist?[index].profileName}?", style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20)),
              //                         const SizedBox(height: 15),
              //                         Row(
              //                           children: [
              //                             // Expanded(
              //                             //   child: MainButton(
              //                             //       bgColor: AppColors.appColor,titleColor: Colors.white,
              //                             //       title: "Cancel",
              //                             //       onTap: () {
              //                             //         Navigator.pop(context);
              //                             //         print(" + + + + + + + : ------   ${profileProvider.blocklistApi.blocklist?[index].profileId}");
              //                             //       }
              //                             //     ),
              //                             // ),
              //                             Expanded(
              //                               child: OutlinedButton(
              //                                 style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: AppColors.appColor)),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),backgroundColor: const MaterialStatePropertyAll(Colors.white)),
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                   print(" + + + + + + + : ------   ${profileProvider.blocklistApi.blocklist?[index].profileId}");
              //                                 },
              //                                 // child: Text('Cancel'.tr,style: TextStyle(color: AppColors.appColor)),
              //                                 child: Text(AppLocalizations.of(context)?.translate("Cancel") ?? "Cancel",style: TextStyle(color: AppColors.appColor)),
              //                               ),
              //                             ),
              //                             const SizedBox(width: 8,),
              //                             Expanded(
              //                               child: MainButton(
              //                                   bgColor: AppColors.appColor,titleColor: Colors.white,
              //                                   // title: "Unblock".tr,
              //                                   title: AppLocalizations.of(context)?.translate("Unblock") ?? "Unblock",
              //                                   onTap: () {
              //                                     profileProvider.unblockApi(context: context, profileblock: "${profileProvider.blocklistApi.blocklist?[index].profileId}").then((value) {
              //                                       Navigator.pop(context);
              //                                       profileProvider.blocklistaApi(context);
              //                                       setState(() {
              //                                       });
              //                                     });
              //                                   }
              //                                  ),
              //                             ),
              //                           ],
              //                         ),
              //                         const SizedBox(height: 15),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //       },
              //       child: Stack(
              //         alignment: Alignment.topCenter,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //                 image: DecorationImage(
              //                     image: NetworkImage("${Config.baseUrl}${profileProvider.blocklistApi.blocklist?[index].profileImages?.first}"),
              //                     fit: BoxFit.cover),
              //                 border: Border.all(
              //                     color: AppColors.appColor, width: 4),
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: AppColors.greyLight),
              //           ),
              //           SvgPicture.asset("assets/Image/Rectangle.svg",
              //               fit: BoxFit.fitWidth,
              //               colorFilter: ColorFilter.mode(
              //                   AppColors.appColor.withOpacity(0.8),
              //                   BlendMode.srcIn)),
              //           Container(
              //             height: 30,
              //             width: 80,
              //             decoration: BoxDecoration(
              //                 color: AppColors.appColor,
              //                 borderRadius: const BorderRadius.vertical(
              //                     bottom: Radius.circular(15))),
              //             child: Center(
              //               child: RichText(
              //                   text: TextSpan(children: [
              //                     TextSpan(
              //                       text:
              //                       "${profileProvider.blocklistApi.blocklist?[index].matchRatio.toString().split(".").first}% ",
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .bodySmall!
              //                           .copyWith(
              //                           color: AppColors.white, fontSize: 12),
              //                     ),
              //                     TextSpan(
              //                       // text: "Match".tr,
              //                       text: AppLocalizations.of(context)?.translate("Match") ?? "Match",
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .bodySmall!
              //                           .copyWith(
              //                           color: AppColors.white, fontSize: 12),
              //                     ),
              //                   ])),
              //
              //               //     Text("${data.matchRatio.toString().split(".").first}% Match",
              //               //   style: Theme.of(context)
              //               //       .textTheme
              //               //       .bodySmall!
              //               //       .copyWith(color: AppColors.white, fontSize: 12),
              //               //   )
              //             ),
              //           ),
              //           Positioned(
              //             bottom: 80,
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(20),
              //               child: Container(
              //                 alignment: Alignment.center,
              //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              //                 decoration: BoxDecoration(
              //                     color: Colors.white.withOpacity(0.4),
              //                     borderRadius: BorderRadius.circular(20)),
              //                 child: BackdropFilter(
              //                   filter: ImageFilter.blur(
              //                       sigmaX: 10, sigmaY: 10),
              //                   child: RichText(
              //                       text: TextSpan(children: [
              //                         TextSpan(
              //                           text: "${profileProvider.blocklistApi.blocklist?[index].profileDistance} ",
              //                           style: Theme.of(context)
              //                               .textTheme
              //                               .bodyMedium!.copyWith(
              //                               color: Colors.white,
              //                               fontSize: 12),
              //                         ),
              //                         TextSpan(
              //                           // text: "Away".tr,
              //                           text: AppLocalizations.of(context)?.translate("Away") ?? "Away",
              //                           style: Theme.of(context)
              //                               .textTheme
              //                               .bodyMedium!
              //                               .copyWith(
              //                               color: Colors.white,
              //                               fontSize: 12),
              //                         ),
              //                       ])),
              //
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Positioned(
              //             bottom: 0,
              //             // left: 1,
              //             // right: 1,
              //             child: Container(
              //               width: MediaQuery.of(context).size.width /2 ,
              //               padding: const EdgeInsets.symmetric(horizontal: 15),
              //               child: Column(
              //                 children: [
              //
              //
              //
              //
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                     child: Text(
              //                         "${profileProvider.blocklistApi.blocklist?[index].profileName.toString()},${profileProvider.blocklistApi.blocklist?[index].profileAge}",
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .bodyLarge!
              //                             .copyWith(
              //                             color: Colors.white,
              //                             fontWeight: FontWeight.w800,
              //                             fontSize: 15),
              //                         maxLines: 1,
              //                         overflow: TextOverflow.ellipsis),
              //                   ),
              //                   const SizedBox(
              //                     height: 3,
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                     child: Text(
              //                         profileProvider.blocklistApi.blocklist![index].profileBio.toString().toUpperCase(),
              //                         style: Theme.of(context)
              //                             .textTheme
              //                             .bodySmall!
              //                             .copyWith(
              //                             color: Colors.white,
              //                             wordSpacing: 2,
              //                             fontSize: 12),
              //                         maxLines: 2,
              //                         textAlign: TextAlign.center,
              //                         overflow: TextOverflow.ellipsis),
              //                   ),
              //                   const SizedBox(
              //                     height: 15,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),



              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: profileProvider.blocklistApi.blocklist?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 250
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          // backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))),
                          builder: (context) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Text("From where do you want to take the photo?".tr, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20)),
                                        Text(AppLocalizations.of(context)?.translate("Unblock ${profileProvider.blocklistApi.blocklist?[index].profileName}?") ?? "Unblock ${profileProvider.blocklistApi.blocklist?[index].profileName}?", style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20)),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            // Expanded(
                                            //   child: MainButton(
                                            //       bgColor: AppColors.appColor,titleColor: Colors.white,
                                            //       title: "Cancel",
                                            //       onTap: () {
                                            //         Navigator.pop(context);
                                            //         print(" + + + + + + + : ------   ${profileProvider.blocklistApi.blocklist?[index].profileId}");
                                            //       }
                                            //     ),
                                            // ),
                                            Expanded(
                                              child: OutlinedButton(
                                                style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color: AppColors.appColor)),elevation: const MaterialStatePropertyAll(0),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),backgroundColor: const MaterialStatePropertyAll(Colors.white)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  print(" + + + + + + + : ------   ${profileProvider.blocklistApi.blocklist?[index].profileId}");
                                                },
                                                // child: Text('Cancel'.tr,style: TextStyle(color: AppColors.appColor)),
                                                child: Text(AppLocalizations.of(context)?.translate("Cancel") ?? "Cancel",style: TextStyle(color: AppColors.appColor)),
                                              ),
                                            ),
                                            const SizedBox(width: 8,),
                                            Expanded(
                                              child: MainButton(
                                                  bgColor: AppColors.appColor,titleColor: Colors.white,
                                                  // title: "Unblock".tr,
                                                  title: AppLocalizations.of(context)?.translate("Unblock") ?? "Unblock",
                                                  onTap: () {
                                                    profileProvider.unblockApi(context: context, profileblock: "${profileProvider.blocklistApi.blocklist?[index].profileId}").then((value) {
                                                      Navigator.pop(context);
                                                      profileProvider.blocklistaApi(context);
                                                      setState(() {
                                                      });
                                                    });
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("${Config.baseUrl}${profileProvider.blocklistApi.blocklist?[index].profileImages?.first}"),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                    color: AppColors.appColor, width: 4),
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.greyLight),
                          ),
                          SvgPicture.asset("assets/Image/Rectangle.svg",
                              fit: BoxFit.fitWidth,
                              colorFilter: ColorFilter.mode(
                                  AppColors.appColor.withOpacity(0.8),
                                  BlendMode.srcIn)),
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                color: AppColors.appColor,
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(15))),
                            child: Center(
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text:
                                      "${profileProvider.blocklistApi.blocklist?[index].matchRatio.toString().split(".").first}% ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                          color: AppColors.white, fontSize: 12),
                                    ),
                                    TextSpan(
                                      // text: "Match".tr,
                                      text: AppLocalizations.of(context)?.translate("Match") ?? "Match",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                          color: AppColors.white, fontSize: 12),
                                    ),
                                  ])),

                              //     Text("${data.matchRatio.toString().split(".").first}% Match",
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .bodySmall!
                              //       .copyWith(color: AppColors.white, fontSize: 12),
                              //   )
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20)),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10, sigmaY: 10),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: "${profileProvider.blocklistApi.blocklist?[index].profileDistance} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!.copyWith(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        TextSpan(
                                          // text: "Away".tr,
                                          text: AppLocalizations.of(context)?.translate("Away") ?? "Away",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ])),

                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width /2 ,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [




                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                        "${profileProvider.blocklistApi.blocklist?[index].profileName.toString()},${profileProvider.blocklistApi.blocklist?[index].profileAge}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                        profileProvider.blocklistApi.blocklist![index].profileBio.toString().toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            color: Colors.white,
                                            wordSpacing: 2,
                                            fontSize: 12),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      )
          // : Center(child: CircularProgressIndicator(backgroundColor: AppColors.appColor,)),
    );
  }

  Widget notFoundPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Lottie.asset("assets/Image/empty-match.json")),
      ],
    );
  }


}
