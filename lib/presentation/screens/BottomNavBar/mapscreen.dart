import 'package:dating/core/config.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../language/localization/app_localization.dart';

class MapScreen extends StatefulWidget {
  static const mapScreenRoute = "/mapScreen";
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late HomeProvider homeProvider;

  @override
  void dispose() {
    super.dispose();
    homeProvider.mapDataList.clear();
    homeProvider.markers.clear();
  }


  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.loadDataFrorMap(context);
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: homeProvider.isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.appColor))
            : Stack(
                children: [

                  GoogleMap(
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: homeProvider.kGooglePlex,
                    markers: Set<Marker>.of(homeProvider.markers),
                    onMapCreated: (GoogleMapController controller) {
                      homeProvider.updateMapController(controller);
                    },
                  ),

                  Row(
                    children: [

                      Expanded(
                        child: Container(
                          // height: 50,
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Theme.of(context).cardColor,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/Location.svg",
                                              colorFilter: ColorFilter.mode(AppColors.appColor, BlendMode.srcIn),
                                              height: 22,
                                              width: 22,
                                            ),

                                            const SizedBox(
                                              width: 6,
                                            ),

                                            Flexible(
                                              child: RichText(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  text: TextSpan(children: [
                                                // TextSpan(text: "Location (Within ".tr,style: Theme.of(context)
                                                TextSpan(text: AppLocalizations.of(context)?.translate("Location (Within ") ?? "Location (Within ",style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    ),
                                                TextSpan(text: homeProvider.radius.toStringAsFixed(2),style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    ),
                                                // TextSpan(text: " km)".tr,style: Theme.of(context)
                                                TextSpan(text: AppLocalizations.of(context)?.translate(" km)") ?? " km)",style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    ),
                                              ])),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [

                                            const SizedBox(
                                              width: 8,
                                            ),

                                            Text(
                                              homeProvider.location,
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith( fontWeight: FontWeight.w800),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  homeProvider.isedit
                                      ? InkWell(
                                          onTap: () {
                                            homeProvider.updateisEdit();
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                       horizontal: 12,
                                                       vertical: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                color: AppColors.appColor,
                                              ),
                                              child: Row(
                                                children: [

                                                  SvgPicture.asset(
                                                      "assets/icons/edit.svg",
                                                      height: 18,
                                                      width: 18,
                                                      colorFilter: ColorFilter.mode(
                                                              AppColors.white,
                                                              BlendMode.srcIn
                                                      )),

                                                  const SizedBox(
                                                    width: 6,
                                                  ),

                                                  Text(
                                                    // "Edit".tr,
                                                    AppLocalizations.of(context)?.translate("Edit") ?? "Edit",
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),

                                                ],
                                              )),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              homeProvider.isedit
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: 12,
                                    ),
                              homeProvider.isedit
                                  ? const SizedBox()
                                  : SliderTheme(
                                      data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
                                      child: Slider(
                                        value: homeProvider.radius,
                                        max: 500,
                                        min: 10,
                                        // divisions: 10,
                                        activeColor: AppColors.appColor,
                                        inactiveColor: AppColors.greyLight,
                                        label: homeProvider.radius.abs().toString(),
                                        onChanged: (double value) {
                                          homeProvider.updateRadius(value);
                                        },
                                      ),
                                    ),
                              homeProvider.isedit
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: 12,
                                    ),
                              homeProvider.isedit
                                  ? const SizedBox()
                                  : MainButton(bgColor: AppColors.appColor,

                                      title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",
                                      onTap: () {

                                        var lat = Provider.of<OnBordingProvider>(context, listen: false).lat;
                                        var long = Provider.of<OnBordingProvider>(context, listen: false).long;

                                        homeProvider.updateisEdit();

                                        homeProvider.mapDataList.removeWhere((element) {
                                          return element["id"] != "${Provider.of<HomeProvider>(context, listen: false).uid}";
                                        });

                                        homeProvider.markers.removeWhere((marker) {
                                          return marker.markerId.value != "${Provider.of<HomeProvider>(context, listen: false).uid}";
                                        });

                                        homeProvider.mapData(
                                            uid: homeProvider.userlocalData.userLogin!.id.toString(),
                                            lat: lat.toString(),
                                            long: long.toString(),
                                            radius: homeProvider.radius.toString()
                                        );
                                      }),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),

                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Builder(builder: (context) {
                        return PageView.builder(
                          controller: homeProvider.pageController,
                          itemCount: homeProvider.mapModel.profilelist!.length,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {

                            homeProvider.mapOnChange(value);

                          },
                          itemBuilder: (context, index) {

                            return InkWell(
                              onTap: () {



                              },
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).cardColor),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                height: 100,
                                width: 100,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                          "${Config.baseUrl}${homeProvider.mapModel.profilelist![index].profileImages!.first}"),
                                    ),
                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                              "${homeProvider.mapModel.profilelist![index].profileName.toString()}, ${homeProvider.mapModel.profilelist![index].profileAge.toString()}",
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(

                                                    fontWeight: FontWeight.w800,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                              maxLines: 1
                                          ),

                                          const SizedBox(height: 2),

                                          Text(
                                              homeProvider.mapModel.profilelist![index].profileBio.toString(),
                                              style: Theme.of(context).textTheme.bodySmall!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                          ),

                                        ],
                                      ),
                                    ),
                                    // const Spacer(),
                                    Container(
                                      height: 45,
                                      width: 45,

                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.appColor,
                                      ),

                                      child: Center(
                                          child: SvgPicture.asset('assets/icons/Heart-fill.svg', colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn))
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
         ),
      ),
    );
  }
}
