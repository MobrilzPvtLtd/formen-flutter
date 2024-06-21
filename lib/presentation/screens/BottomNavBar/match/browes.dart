import 'dart:ui';
import 'package:dating/Logic/cubits/match_cubit/match_cubit.dart';
import 'package:dating/Logic/cubits/match_cubit/match_states.dart';
import 'package:dating/core/config.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/data/models/favoritelistmodel.dart';
import 'package:dating/data/models/newmatchmodel.dart';
import 'package:dating/data/models/passedmodel.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/BottomNavBar/match/matchprovider.dart';
import 'package:dating/presentation/screens/other/likeMatch/like_match.dart';
import 'package:dating/presentation/screens/other/likeMatch/likematch_provider.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/likememodel.dart';
import '../../../../language/localization/app_localization.dart';
import '../../../widgets/appbarr.dart';
import '../../other/profileAbout/detailprovider.dart';
import '../../other/profileAbout/detailscreen.dart';
import '../../splash_bording/onBordingProvider/onbording_provider.dart';

class BrowesPage extends StatefulWidget {
  const BrowesPage({super.key});
  static const browsPageRoute = "/browsPage";
  @override
  State<BrowesPage> createState() => _BrowesPage();
}

class _BrowesPage extends State<BrowesPage> {
  late MatchProvider matchProvider;

  @override
  void initState() {
    super.initState();
    matchProvider = Provider.of<MatchProvider>(context, listen: false);
    matchProvider.matchInit(context);
  }

  @override
  Widget build(BuildContext context) {
    matchProvider = Provider.of<MatchProvider>(context);
    return Scaffold(
      // appBar: appbarr(context, 'Explore'.tr),
      appBar: appbarr(context, AppLocalizations.of(context)?.translate("Explore") ?? "Explore"),
      // appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,leading: Image.asset("assets/Image/appmainLogo1.png",height: 50,width: 50,),title: Text("Explore",style: Theme.of(context).textTheme.bodyMedium,)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<MatchCubit, MatchStates>(
        builder: (context, state) {
          // if(state is MatchLoadingState){
          //   return const Center(child: CircularProgressIndicator(),);
          // }
          if (state is MatchCompleteState) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (c, i) {
                                return InkWell(
                                  onTap: () {
                                    matchProvider.updateIndex(i);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: matchProvider.selectIndex == i
                                            ? AppColors.appColor
                                            : const Color(0xffF7ECFF)),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            matchProvider.selectIndex == i
                                                ? "assets/icons/Heart-fill.svg"
                                                : "assets/icons/Heart.svg",
                                            colorFilter: ColorFilter.mode(
                                                matchProvider.selectIndex == i
                                                    ? AppColors.white
                                                    : AppColors.appColor,
                                                BlendMode.srcIn),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            matchProvider.menuData[i],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: matchProvider
                                                                .selectIndex ==
                                                            i
                                                        ? AppColors.white
                                                        : AppColors.appColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (c, i) {
                                return const SizBoxW(size: 0.03);
                              },
                              itemCount: matchProvider.menuData.length),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Builder(builder: (context) {
                    switch (matchProvider.selectIndex) {
                      case 0:
                        return newMatch(state.newMatchModel);
                      case 1:
                        return likeMe(state.likeMeModel);
                      case 2:
                        return favourite(state.favListModel);
                      case 3:
                        return passed(state.passedModel);
                      default:
                        return newMatch(state.newMatchModel);
                    }
                  }),
                  // SizedBox(height: 100,)
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(color: AppColors.appColor),
            );
          }
        },
        listener: (context, state) {
          if (state is MatchErrorState) {
            Fluttertoast.showToast(msg: state.error);
          }
        },
      ),
    );
  }

  Widget newMatch(NewMatchModel newMatchModel) {
    return newMatchModel.profilelist!.isEmpty
        ? notFoundPage()
        : Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: newMatchModel.profilelist!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 250),
              itemBuilder: (context, index) {
                Profilelist data = newMatchModel.profilelist![index];
                return ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: InkWell(
                    onTap: () {
                      var lat = Provider.of<OnBordingProvider>(context, listen: false).lat;
                      var long = Provider.of<OnBordingProvider>(context, listen: false).long;
                      Provider.of<DetailProvider>(context, listen: false).updateIsMatch(true);
                      Provider.of<DetailProvider>(context, listen: false).status = "1";
                      Provider.of<DetailProvider>(context, listen: false)
                          .detailsApi(
                              uid: Provider.of<HomeProvider>(context, listen: false).uid ?? "",
                              lat: lat.toString(),
                              long: long.toString(),
                              profileId: data.profileId ?? ''
                      )
                          .then((value) {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.detailScreenRoute,
                        ).then((value) {
                          matchProvider.callAllApi(context);
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${Config.baseUrl}${data.profileImages!.first}"),
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
                                    "${data.matchRatio.toString().split(".").first}% ",
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
                          bottom: data.profileBio.toString().toUpperCase().isEmpty ? 40 : 80,
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
                                        text: "${data.profileDistance} ",
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
                                     "${data.profileName.toString()},${data.profileAge}",
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
                                data.profileBio.toString().toUpperCase().isEmpty ? const SizedBox() : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                     data.profileBio.toString().toUpperCase(),
                                     style: Theme.of(context)
                                         .textTheme
                                         .bodySmall!
                                         .copyWith(
                                         color: Colors.white,
                                         wordSpacing: 2,
                                         fontSize: 12),
                                     maxLines: 2,
                                     textAlign: TextAlign.center,
                                     overflow: TextOverflow.ellipsis
                                                                 ),
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
            ),
          );
  }

  Widget passed(PassedModel passedModel) {
    return passedModel.passedlist!.isEmpty
        ? notFoundPage()
        : Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: passedModel.passedlist!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 250),
              itemBuilder: (context, index) {
                Passedlist data = passedModel.passedlist![index];
                return ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: InkWell(
                    onTap: () {
                      var lat =
                          Provider.of<OnBordingProvider>(context, listen: false)
                              .lat;
                      var long =
                          Provider.of<OnBordingProvider>(context, listen: false)
                              .long;
                      Provider.of<DetailProvider>(context, listen: false)
                          .updateIsMatch(true);
                      Provider.of<DetailProvider>(context, listen: false)
                          .status = "4";
                      Provider.of<DetailProvider>(context, listen: false)
                          .detailsApi(
                              uid: Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .uid ??
                                  "",
                              lat: lat.toString(),
                              long: long.toString(),
                              profileId: data.profileId ?? '')
                          .then((value) {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.detailScreenRoute,
                        ).then((value) {
                          matchProvider.callAllApi(context);
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${Config.baseUrl}${data.profileImages!.first}"),
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
                              child: RichText(text: TextSpan(children: [
                                TextSpan(text: "${data.matchRatio.toString().split(".").first}% ",style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.white, fontSize: 12),),
                                // TextSpan(text: "Match".tr,style: Theme.of(context)
                                TextSpan(text: AppLocalizations.of(context)?.translate("Match") ?? "Match",style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.white, fontSize: 12),),
                              ])),

                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10, sigmaY: 10),
                                child: RichText(text: TextSpan(children: [
                                  TextSpan(text: "${data.profileDistance} ",style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      color: Colors.white,
                                      fontSize: 12),),
                                  // TextSpan(text: "Away".tr,style: Theme.of(context)
                                  TextSpan(text: AppLocalizations.of(context)?.translate("Away") ?? "Away",style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      color: Colors.white,
                                      fontSize: 12),),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                      "${data.profileName.toString()},${data.profileAge}",
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
                                  height: 5,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                        data.profileBio.toString().toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.white,
                                                wordSpacing: 2,
                                                fontSize: 12),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis)),
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
            ),
          );
  }

  Widget notFoundPage() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Lottie.asset("assets/Image/empty-match.json")),
        ],
      ),
    );
  }

  Widget favourite(FavlistModel favListModel) {
    return favListModel.favlist!.isEmpty
        ? notFoundPage()
        : Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: favListModel.favlist!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 250
              ),
              itemBuilder: (context, index) {
                Favlist data = favListModel.favlist![index];
                return ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: InkWell(
                    onTap: () {
                      var lat =
                          Provider.of<OnBordingProvider>(context, listen: false)
                              .lat;
                      var long =
                          Provider.of<OnBordingProvider>(context, listen: false)
                              .long;
                      Provider.of<DetailProvider>(context, listen: false)
                          .updateIsMatch(true);
                      Provider.of<DetailProvider>(context, listen: false)
                          .status = "3";
                      Provider.of<DetailProvider>(context, listen: false)
                          .detailsApi(
                              uid: Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .uid ??
                                  "",
                              lat: lat.toString(),
                              long: long.toString(),
                              profileId: data.profileId ?? '')
                          .then((value) {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.detailScreenRoute,
                        ).then((value) {
                          matchProvider.callAllApi(context);
                        });
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${Config.baseUrl}${data.profileImages!.first}"),
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
                              child: RichText(text: TextSpan(children: [
                                TextSpan(text: "${data.matchRatio.toString().split(".").first}% ",style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.white, fontSize: 12),),
                                // TextSpan(text: "Match".tr,style: Theme.of(context)
                                TextSpan(text: AppLocalizations.of(context)?.translate("Match") ?? "Match",style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.white, fontSize: 12),),
                              ])),),
                        ),
                        Positioned(
                          bottom: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20)),
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10, sigmaY: 10),
                                  child: RichText(text: TextSpan(children: [
                                    TextSpan(text: "${data.profileDistance} ",style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                        color: Colors.white,
                                        fontSize: 12),),
                                    // TextSpan(text: "Away".tr,style: Theme.of(context)
                                    TextSpan(text: AppLocalizations.of(context)?.translate("Away") ?? "Away",style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                        color: Colors.white,
                                        fontSize: 12),),
                                  ]))
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
                                      "${data.profileName.toString()},${data.profileAge}",
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
                                  height: 5,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                        data.profileBio.toString().toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.white,
                                                wordSpacing: 2,
                                                fontSize: 12),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis)),
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
            ),
          );
  }

  Widget likeMe(LikeMeModel likeMeModel) {
    return likeMeModel.likemelist!.isEmpty
        ? notFoundPage()
        : Expanded(
            child: ListView.separated(
              // physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: likeMeModel.likemelist!.length,
              scrollDirection: Axis.vertical,
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,mainAxisExtent: 250),
              itemBuilder: (context, index) {
                Likemelist data = likeMeModel.likemelist![index];
                return SizedBox(
                  height: 250,
                  child: InkWell(
                    onTap: () {
                      var lat =
                          Provider.of<OnBordingProvider>(context, listen: false)
                              .lat;
                      var long =
                          Provider.of<OnBordingProvider>(context, listen: false)
                              .long;
                      Provider.of<DetailProvider>(context, listen: false)
                          .updateIsMatch(true);
                      Provider.of<DetailProvider>(context, listen: false)
                          .status = "2";
                      Provider.of<DetailProvider>(context, listen: false)
                          .detailsApi(
                              uid: Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .uid ??
                                  "",
                              lat: lat.toString(),
                              long: long.toString(),
                              profileId: data.profileId ?? '');

                      Navigator.pushNamed(
                        context,
                        DetailScreen.detailScreenRoute,
                      ).then((value) {
                        matchProvider.callAllApi(context);
                      });
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(30)),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${Config.baseUrl}${data.profileImages!.first}"),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                    color: AppColors.appColor, width: 4),
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.greyLight),
                          ),
                          SvgPicture.asset("assets/Image/Rectangle.svg",
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  AppColors.appColor, BlendMode.srcIn)),
                          Positioned(
                            right: 35,
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: AppColors.appColor,
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(15))),
                              child: Center(
                                  child: RichText(text: TextSpan(children: [
                                    TextSpan(text: "${data.matchRatio.toString().split(".").first}% ",style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: AppColors.white, fontSize: 12),),
                                    // TextSpan(text: "Match".tr,style: Theme.of(context)
                                    TextSpan(text: AppLocalizations.of(context)?.translate("Match") ?? "Match",style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: AppColors.white, fontSize: 12),),
                                  ])),),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SizedBox(
                              // padding: EdgeInsets.symmetric(horizontal: 15),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${data.profileName.toString()},${data.profileAge}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 15),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                data.profileBio
                                                    .toString()
                                                    .toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        wordSpacing: 2,
                                                        fontSize: 12),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<MatchCubit>(context)
                                              .profileLikeDislikeApi(
                                                  uid:
                                                      Provider.of<HomeProvider>(
                                                              context,
                                                              listen: false)
                                                          .uid,
                                                  proId: data.profileId!,
                                                  // action: "UNLIKE".tr)
                                                  action: AppLocalizations.of(context)?.translate("UNLIKE") ?? "UNLIKE")
                                              .then((value) {
                                            matchProvider.callAllApi(context);
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                                  .withOpacity(0.3)),
                                          child: Center(
                                              child: SvgPicture.asset(
                                            "assets/icons/times.svg",
                                            colorFilter: const ColorFilter.mode(
                                                Colors.white, BlendMode.srcIn),
                                          )),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<MatchCubit>(context)
                                              .profileLikeDislikeApi(
                                                  uid:
                                                      Provider.of<HomeProvider>(
                                                              context,
                                                              listen: false)
                                                          .uid,
                                                  proId: data.profileId!,
                                                  // action: "LIKE".tr)
                                                  action: AppLocalizations.of(context)?.translate("LIKE") ?? "LIKE")
                                              .then((value) {
                                            if (value == "true") {
                                              matchProvider.callAllApi(context);
                                              Provider.of<LikeMatchProvider>(
                                                      context,
                                                      listen: false)
                                                  .updateIsHome(false);
                                              Provider.of<LikeMatchProvider>(
                                                      context,
                                                      listen: false)
                                                  .likeMatchData
                                                  .add(data);
                                              Navigator.pushNamed(
                                                  context,
                                                  LikeMatchScreen
                                                      .likeMatchScreenRoute);
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.appColor),
                                          child: Center(
                                              child: SvgPicture.asset(
                                            "assets/icons/Heart-fill1.svg",
                                            colorFilter: const ColorFilter.mode(
                                                Colors.white, BlendMode.srcIn),
                                            height: 25,
                                            width: 25,
                                          )),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
