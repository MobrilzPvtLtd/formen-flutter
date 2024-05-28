// ignore_for_file: unused_local_variable, avoid_print, unnecessary_brace_in_string_interps, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dating/Logic/cubits/Home_cubit/home_cubit.dart';
import 'package:dating/Logic/cubits/language_cubit/language_bloc.dart';
import 'package:dating/Logic/cubits/litedark/lite_dark_cubit.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/presentation/screens/Splash_Bording/auth_screen.dart';
import 'package:dating/presentation/screens/other/editProfile/editprofile.dart';
import 'package:dating/presentation/screens/other/premium/plandetials.dart';
import 'package:dating/presentation/screens/other/premium/premium.dart';
import 'package:dating/presentation/screens/other/profileScreen/faqpage.dart';
import 'package:dating/presentation/screens/other/profileScreen/pagelist.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_privacy.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_provider.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Logic/cubits/Home_cubit/homestate.dart';
import '../../../../core/config.dart';
import '../../../../data/localdatabase.dart';
import '../../../../language/localization/app_localization.dart';
import '../../../firebase/chat_page.dart';
import '../../../widgets/appbarr.dart';
import '../../../widgets/main_button.dart';
import '../../BottomNavBar/bottombar.dart';
import '../../BottomNavBar/homeProvider/homeprovier.dart';

List<CameraDescription> cameras = [];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const profilePageRoute = "/profilePage";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late HomeProvider homeProvider;
  late ProfileProvider profileProvider;
  late OnBordingProvider onBordingProvider;
  late CameraController imagecontroller;
  late HomePageCubit homePageCubit;
  late HomeCompleteState homeCompleteState;

  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context,listen: false);
    homeProvider = Provider.of<HomeProvider>(context,listen: false);
    profileProvider.faqApi(context);
    profileProvider.pageListApi(context);
    profileProvider.getPackage();
    getTheme().then((value) {
      setState(() {
        if(value == "dark"){
          profileProvider.isDartMode = true;
        }else{
          profileProvider.isDartMode = false;
        }
      });
    });
    BlocProvider.of<HomePageCubit>(context).getHomeData(uid: homeProvider.uid, lat: homeProvider.lat.toString(), long: homeProvider.long.toString(),context: context);


    imagecontroller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = imagecontroller.initialize();
    getdata();
    fun();

  }



  @override
  void dispose() {
    imagecontroller.dispose();
    super.dispose();
  }

  String networkImage = "";
  XFile? selectImageprofile;
  XFile? selectImageprofilevaridfy;
  ImagePicker picker = ImagePicker();
  ImagePicker pickervaridfy = ImagePicker();
  String? base64String;
  String? base64Stringverfy;


  bool _isFrontCamera = false;


  void _toggleCamera() async {
    CameraDescription newCameraDescription;
    if (_isFrontCamera) {
      newCameraDescription = cameras.firstWhere((camera) =>
      camera.lensDirection == CameraLensDirection.back);
    } else {
      newCameraDescription = cameras.firstWhere((camera) =>
      camera.lensDirection == CameraLensDirection.front);
    }

    if (imagecontroller.value.isRecordingVideo) {
      return;
    }

    // if (imagecontroller != null) {
    //   await imagecontroller.dispose();
    // }
    imagecontroller = CameraController(
      newCameraDescription,
      ResolutionPreset.medium,
    );

    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _initializeControllerFuture = imagecontroller.initialize();
    });
  }

  int value = 0;

  List languageimage = [
    'assets/icons/L-English.png',
    'assets/icons/L-Spanish.png',
    'assets/icons/L-Arabic.png',
    'assets/icons/L-Hindi-Gujarati.png',
    'assets/icons/L-Hindi-Gujarati.png',
    'assets/icons/L-Afrikaans.png',
    'assets/icons/L-Bengali.png',
    'assets/icons/L-Indonesion.png',
  ];

  List languagetext = [
    'English',
    'Spanish',
    'Arabic',
    'Hindi',
    'Gujarati',
    'Afrikaans',
    'Bengali',
    'Indonesian',
  ];


  fun() async {
    for(int a= 0 ;a<languagetext.length;a++){
      if(languagetext[a].toString().compareTo(Get.locale.toString()) == 0){
        setState(() {
          value = a;
        });
      }else{
      }
    }
  }


  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
   value = preferences.getInt("valuelangauge")!;
  }


  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    onBordingProvider = Provider.of<OnBordingProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: appbarr(context, 'Profile'.tr),
      appBar: appbarr(context, AppLocalizations.of(context)?.translate("Profile") ?? "Profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BlocBuilder<HomePageCubit,HomePageStates>(
                builder: (context1, state) {
                if(state is HomeCompleteState){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                          clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [

                              state.homeData.profilelist!.isEmpty ? const SizedBox() : SizedBox(
                                height: 70,
                                width : 70,
                                child: CircularProgressIndicator(
                                  strokeCap: StrokeCap.round,
                                    strokeWidth: 4,
                                    // backgroundColor: Colors.red,
                                    valueColor: AlwaysStoppedAnimation(AppColors.appColor),
                                    value: (double.parse(state.homeData.profilelist![homeProvider.currentIndex].matchRatio.toString().split(".").first) /100)
                                ),
                              ),

                              homeProvider.userlocalData.userLogin!.profilePic != null ? Container(
                                  height: 66,
                                  width: 66,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // image: DecorationImage(image:  NetworkImage('${Config.imagebaseurl}${profileImageController.profileimageeditApi!.userLogin.profilePic}'), fit: BoxFit.cover),
                                    image: DecorationImage(image:  NetworkImage("${Config.baseUrl}/${homeProvider.userlocalData.userLogin!.profilePic}"), fit: BoxFit.cover),
                                  )) : selectImageprofile == null ? CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                maxRadius: 33,
                                child: Center(child: Text("${homeProvider.userlocalData.userLogin!.name?[0]}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                              ) : Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: FileImage(File(selectImageprofile!.path)), fit: BoxFit.cover),
                                ),
                              ),


                              state.homeData.planId != "0" ? Positioned(
                                  top: -10,
                                  child: Image.asset("assets/icons/tajicon.png",height: 25,width: 25,),
                              ) : const SizedBox(),


                              state.homeData.profilelist!.isEmpty ? const SizedBox() : Positioned(
                                bottom: -10,
                                child: Container(
                                  height: 22,
                                  width: 35,
                                  decoration: BoxDecoration(
                                     border: Border.all(color: Colors.white,width: 3),
                                     // color: AppColors.appColor,
                                     borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    height: 22,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        // border: Border.all(color: Colors.white,width: 0.2),
                                        color: AppColors.appColor,
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${state.homeData.profilelist![homeProvider.currentIndex].matchRatio.toString().split(".").first}%",
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white,fontSize: 9,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )





                            ],
                          ),
                          const SizBoxW(size: 0.02),


                          BlocBuilder<HomePageCubit, HomePageStates>(
                              builder: (context, state) {
                                if (state is HomeCompleteState) {
                                  return Expanded(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${homeProvider.userlocalData.userLogin!.name}",
                                            style: Theme.of(context).textTheme.headlineSmall,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        state.homeData.isVerify == "0" ? InkWell(
                                          onTap: () {
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(child: Icon(Icons.camera_alt,color: AppColors.appColor,size: 30)),
                                                    const SizedBox(height: 10,),
                                                    // Center(child: Text('Get Photo Verified'.tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                                                    Center(child: Text(AppLocalizations.of(context)?.translate("Get Photo Verified") ?? "Get Photo Verified",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                                                    const SizedBox(height: 10,),
                                                    // Text("We want to know it`s really you.".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),),
                                                    Text(AppLocalizations.of(context)?.translate("We want to know it`s really you.") ?? "We want to know it`s really you.",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),),
                                                    // const SizedBox(height: 10,),
                                                    ListTile(
                                                      contentPadding: EdgeInsets.zero,
                                                      // title: Text("Tack a quick video selfie".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,fontWeight: FontWeight.bold),),
                                                      title: Text(AppLocalizations.of(context)?.translate("Tack a quick video selfie") ?? "Tack a quick video selfie",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,fontWeight: FontWeight.bold),),
                                                      // subtitle: Text("Confirm you`re the person in your photos.".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14,color: Colors.grey),),
                                                      subtitle: Text(AppLocalizations.of(context)?.translate("Confirm you`re the person in your photos.") ?? "Confirm you`re the person in your photos.",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14,color: Colors.grey),),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    MainButton(
                                                        bgColor: AppColors.appColor,titleColor: Colors.white,
                                                        // title: "Continue".tr,
                                                        title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",
                                                        onTap: () {
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
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  const SizedBox(height: 10,),
                                                                  // Center(child: Text('Before you continue...'.tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                                                                  Center(child: Text(AppLocalizations.of(context)?.translate("Before you continue...") ?? "Before you continue...",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                                                                  const SizedBox(height: 10,),
                                                                  ListTile(
                                                                    isThreeLine: true,
                                                                    contentPadding: EdgeInsets.zero,
                                                                    leading: Container(
                                                                      height: 20,
                                                                      width: 20,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors.appColor,
                                                                          borderRadius: BorderRadius.circular(65)
                                                                      ),
                                                                      child: const Center(child: Icon(Icons.check,color: Colors.white,size: 12,)),
                                                                    ),
                                                                    // title: Transform.translate(offset: const Offset(-10, -3),child: Text("Prep your lighting".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),)),
                                                                    title: Transform.translate(offset: const Offset(-10, -3),child: Text(AppLocalizations.of(context)?.translate("Prep your lighting") ?? "Prep your lighting",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),)),
                                                                    subtitle: Transform.translate(
                                                                      offset: const Offset(-10, 0),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          // SizedBox(height: 5,),

                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 7.0),
                                                                                child: Container(
                                                                                  height: 7,
                                                                                  width: 7,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colors.grey,
                                                                                      shape: BoxShape.circle
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 5,),
                                                                              // Flexible(child: Text("Choose a well-lit environment".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                              Flexible(child: Text(AppLocalizations.of(context)?.translate("Choose a well-lit environment") ?? "Choose a well-lit environment",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                            ],
                                                                          ),
                                                                          const SizedBox(height: 5,),
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 7.0),
                                                                                child: Container(
                                                                                  height: 7,
                                                                                  width: 7,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colors.grey,
                                                                                      shape: BoxShape.circle
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 5,),
                                                                              // Flexible(child: Text("Turn up your brightness".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                              Flexible(child: Text(AppLocalizations.of(context)?.translate("Turn up your brightness") ?? "Turn up your brightness",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))

                                                                            ],
                                                                          ),
                                                                          const SizedBox(height: 5,),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 7.0),
                                                                                child: Container(
                                                                                  height: 7,
                                                                                  width: 7,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colors.grey,
                                                                                      shape: BoxShape.circle
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 5,),
                                                                              Flexible(child: Text("Avoid ${homeProvider.userlocalData.userLogin!.name} glare and backlighting",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 10,),
                                                                  ListTile(
                                                                    isThreeLine: true,
                                                                    contentPadding: EdgeInsets.zero,
                                                                    leading: Container(
                                                                      height: 20,
                                                                      width: 20,
                                                                      decoration: BoxDecoration(
                                                                          color: AppColors.appColor,
                                                                          borderRadius: BorderRadius.circular(65)
                                                                      ),
                                                                      child: const Center(child: Icon(Icons.check,color: Colors.white,size: 12,)),
                                                                    ),
                                                                    // title: Transform.translate(offset: Offset(-10, -3),child: Text("Show your face".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),)),
                                                                    title: Transform.translate(offset: const Offset(-10, -3),child: Text(AppLocalizations.of(context)?.translate("Show your face") ?? "Show your face",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),)),
                                                                    subtitle: Transform.translate(
                                                                      offset: const Offset(-10, 0),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          // SizedBox(height: 5,),

                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 7.0),
                                                                                child: Container(
                                                                                  height: 7,
                                                                                  width: 7,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colors.grey,
                                                                                      shape: BoxShape.circle
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 5,),
                                                                              // Flexible(child: Text("Face the camera directly".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                              Flexible(child: Text(AppLocalizations.of(context)?.translate("Face the camera directly") ?? "Face the camera directly",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                            ],
                                                                          ),
                                                                          const SizedBox(height: 5,),
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 7.0),
                                                                                child: Container(
                                                                                  height: 7,
                                                                                  width: 7,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colors.grey,
                                                                                      shape: BoxShape.circle
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 5,),
                                                                              // Flexible(child: Text("Remove hats, sunglasses, and face coverings".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                              Flexible(child: Text(AppLocalizations.of(context)?.translate("Remove hats, sunglasses, and face coverings") ?? "Remove hats, sunglasses, and face coverings",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                                                                            ],
                                                                          ),

                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 10,),
                                                                  MainButton(
                                                                      bgColor: AppColors.appColor,titleColor: Colors.white,
                                                                      // title: "Continue".tr,
                                                                      title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",
                                                                      onTap: () async {
                                                                        // final picked1 = await pickervaridfy.pickImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.rear);
                                                                        // if(picked1!= null){
                                                                        //   setState(() {
                                                                        //     selectImageprofilevaridfy = picked1;
                                                                        //   });
                                                                        //
                                                                        //
                                                                        //   // List<int> imageByte =File(selectImageprofile!.path).readAsBytesSync();
                                                                        //   // base64String =base64Encode(imageByte);
                                                                        //   // profileProvider.profilepicApi(context: context,img: base64String.toString()).then((value) {
                                                                        //   //   Navigator.of(context).pop();
                                                                        //   //   setState(() {
                                                                        //   //
                                                                        //   //   });
                                                                        //   // });
                                                                        //
                                                                        // } else{
                                                                        //   print("did not pick an image!!");
                                                                        // }

                                                                        // showBottomSheet(
                                                                        //   context: context, builder: (context) {
                                                                        //   return Container(color: Colors.red,);
                                                                        // },);


                                                                        showModalBottomSheet(
                                                                            isScrollControlled: true,
                                                                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                                            context: context,
                                                                            builder: (c) {
                                                                              // editProvider = Provider.of<EditProfileProvider>(context, listen: false);
                                                                              return StatefulBuilder(builder: (context, setState) {
                                                                                return Container(
                                                                                  padding: const EdgeInsets.all(15),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Theme.of(context).scaffoldBackgroundColor,
                                                                                    borderRadius: BorderRadius.circular(16),
                                                                                  ),
                                                                                  child: SafeArea(
                                                                                    child: Scaffold(
                                                                                      resizeToAvoidBottomInset: false,
                                                                                      body: SingleChildScrollView(
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            const SizedBox(height: 30,),
                                                                                            InkWell(
                                                                                                onTap: () {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: const Icon(Icons.close)
                                                                                            ),
                                                                                            const SizedBox(height: 10,),
                                                                                            // Center(child: Text("Get ready for".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24,fontWeight: FontWeight.bold))),
                                                                                            Center(child: Text(AppLocalizations.of(context)?.translate("Get ready for") ?? "Get ready for",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24,fontWeight: FontWeight.bold))),
                                                                                            // Center(child: Text("your image selfie".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24,fontWeight: FontWeight.bold))),
                                                                                            Center(child: Text(AppLocalizations.of(context)?.translate("your image selfie") ?? "your image selfie",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24,fontWeight: FontWeight.bold))),
                                                                                            const SizedBox(height: 10,),
                                                                                            Center(
                                                                                              child: ClipOval(
                                                                                                child: SizedBox(
                                                                                                  height: 350,
                                                                                                  width: 230,
                                                                                                  child: selectImageprofilevaridfy == null ?
                                                                                                  GestureDetector(
                                                                                                    onDoubleTap: () {
                                                                                                      setState((){
                                                                                                        _toggleCamera();
                                                                                                      });
                                                                                                    },
                                                                                                    child: FutureBuilder<void>(
                                                                                                      future: _initializeControllerFuture,
                                                                                                      builder: (context, snapshot) {
                                                                                                        if (snapshot.connectionState == ConnectionState.done) {
                                                                                                          return CameraPreview(imagecontroller);
                                                                                                        } else {
                                                                                                          return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                                                                                                        }
                                                                                                      },
                                                                                                    ),
                                                                                                  ) :
                                                                                                  Image.file(File(selectImageprofilevaridfy!.path),fit: BoxFit.cover),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            // selectImageprofilevaridfy == null ? Container(height: 20,width: 20,color: Colors.yellow,) : Image.file(File(selectImageprofilevaridfy!.path),),
                                                                                            const SizedBox(height: 10,),
                                                                                            // Center(child: Text("Make sure to frame your face in the oval, then tap  'i`m ready'!".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,fontWeight: FontWeight.bold),maxLines: 2,textAlign: TextAlign.center,)),
                                                                                            Center(child: Text(AppLocalizations.of(context)?.translate("Make sure to frame your face in the oval, then tap  'I am Ready'!") ?? "Make sure to frame your face in the oval, then tap  'I am Ready'!",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,fontWeight: FontWeight.bold),maxLines: 2,textAlign: TextAlign.center,)),
                                                                                            const SizedBox(height: 10,),
                                                                                            MainButton(
                                                                                              bgColor: AppColors.appColor,titleColor: Colors.white,
                                                                                              // title: "i m ready".tr,
                                                                                              title: AppLocalizations.of(context)?.translate("I am Ready") ?? "I am Ready",
                                                                                              onTap: () async {

                                                                                                try {
                                                                                                  await _initializeControllerFuture;
                                                                                                  selectImageprofilevaridfy = await imagecontroller.takePicture();
                                                                                                  List<int> imageByte = File(selectImageprofilevaridfy!.path).readAsBytesSync();
                                                                                                  base64Stringverfy =base64Encode(imageByte);

                                                                                                  profileProvider.identiverifyApi(context: context,img: base64Stringverfy.toString()).then((value) {
                                                                                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BottomBar()), (route) => false);
                                                                                                    setState(() {

                                                                                                    });
                                                                                                  });

                                                                                                  print(" + + + + + :----  ${base64Stringverfy}");
                                                                                                } catch (e) {
                                                                                                  print('Error taking picture: $e');
                                                                                                }


                                                                                                setState((){});

                                                                                              },
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },);
                                                                            });

                                                                      }
                                                                  ),
                                                                  const SizedBox(height: 10,),
                                                                  // Center(child: Text('Maybe Later'.tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),)),
                                                                  Center(child: Text(AppLocalizations.of(context)?.translate("Maybe Later") ?? "Maybe Later",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),)),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child: Image(image: AssetImage("assets/icons/newverfy.png"),height: 22,width: 22),
                                          ),
                                        ) : state.homeData.isVerify == "1" ? InkWell(
                                          onTap: () {
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
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(image: NetworkImage("${Config.baseUrl}/${homeProvider.userlocalData.userLogin!.identityPicture}"),fit: BoxFit.cover)
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    // Center(child: Text('verification Under'.tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                                                    Center(child: Text(AppLocalizations.of(context)?.translate("verification Under") ?? "verification Under",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                                                    Center(child: Text('Review',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                                                    const SizedBox(height: 10,),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15,right: 15),
                                                      // child: Text("We are currently reviewing your selfies and will get back to you shortly!".tr,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),textAlign: TextAlign.center),
                                                      child: Text(AppLocalizations.of(context)?.translate("We are currently reviewing your selfies and will get back to you shortly!") ?? "We are currently reviewing your selfies and will get back to you shortly!",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),textAlign: TextAlign.center),
                                                    ),
                                                    // const SizedBox(height: 10,),
                                                    const SizedBox(height: 20,),
                                                    MainButton(
                                                        bgColor: AppColors.appColor,titleColor: Colors.white,
                                                        // title: "OKAY".tr,
                                                        title: AppLocalizations.of(context)?.translate("OKAY") ?? "OKAY",
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        }),
                                                    const SizedBox(height: 10,),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child: Image(image: AssetImage("assets/icons/progressicon.png"),height: 22,width: 22,),
                                          ),
                                        ) : const Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Image(image: AssetImage("assets/icons/approveicon.png"),height: 22,width: 22,),
                                        ),
                                        const SizedBox(width: 15,),
                                      ],
                                    ),
                                  );
                                }else{
                                  return const SizedBox();
                                }
                              }
                          ),



                          // Expanded(
                          //   child: Row(
                          //     children: [
                          //       Flexible(
                          //         child: Text(
                          //           "${homeProvider.userlocalData.userLogin!.name}",
                          //           style: Theme.of(context).textTheme.headlineSmall,
                          //           maxLines: 1,
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       ),
                          //       const SizedBox(width: 5),
                          //       homeProvider.userlocalData.userLogin!.isVerify == "0" ? InkWell(
                          //         onTap: () {
                          //           showDialog<String>(
                          //             barrierDismissible: false,
                          //             context: context,
                          //             builder: (BuildContext context) => AlertDialog(
                          //               elevation: 0,
                          //               insetPadding: const EdgeInsets.only(left: 10,right: 10),
                          //               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(20),
                          //               ),
                          //               title: Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                 children: [
                          //                   Center(child: Icon(Icons.camera_alt,color: AppColors.appColor,size: 30)),
                          //                   const SizedBox(height: 10,),
                          //                   Center(child: Text('Get Photo Verified',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                          //                   const SizedBox(height: 10,),
                          //                   Text("We want to know it`s really you.",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),),
                          //                   // const SizedBox(height: 10,),
                          //                   ListTile(
                          //                     contentPadding: EdgeInsets.zero,
                          //                     title: Text("Tack a quick video selfie",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,fontWeight: FontWeight.bold),),
                          //                     subtitle: Text("Confirm you`re the person in your photos.",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14,color: Colors.grey),),
                          //                   ),
                          //                   const SizedBox(height: 10,),
                          //                   MainButton(
                          //                       bgColor: AppColors.appColor,titleColor: Colors.white,
                          //                       title: "Continue",
                          //                       onTap: () {
                          //                         showDialog<String>(
                          //                           barrierDismissible: false,
                          //                           context: context,
                          //                           builder: (BuildContext context) => AlertDialog(
                          //                             elevation: 0,
                          //                             insetPadding: const EdgeInsets.only(left: 10,right: 10),
                          //                             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          //                             shape: RoundedRectangleBorder(
                          //                               borderRadius: BorderRadius.circular(20),
                          //                             ),
                          //                             title: Column(
                          //                               crossAxisAlignment: CrossAxisAlignment.start,
                          //                               mainAxisAlignment: MainAxisAlignment.start,
                          //                               children: [
                          //                                 const SizedBox(height: 10,),
                          //                                 Center(child: Text('Before you continue...',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                          //                                const SizedBox(height: 10,),
                          //                                ListTile(
                          //                                  isThreeLine: true,
                          //                                  contentPadding: EdgeInsets.zero,
                          //                                  leading: Container(
                          //                                    height: 20,
                          //                                    width: 20,
                          //                                    decoration: BoxDecoration(
                          //                                      color: AppColors.appColor,
                          //                                      borderRadius: BorderRadius.circular(65)
                          //                                    ),
                          //                                    child: const Center(child: Icon(Icons.check,color: Colors.white,size: 12,)),
                          //                                  ),
                          //                                  title: Transform.translate(offset: const Offset(-10, -3),child: Text("Prep your lighting",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),)),
                          //                                  subtitle: Transform.translate(
                          //                                    offset: const Offset(-10, 0),
                          //                                    child: Column(
                          //                                      crossAxisAlignment: CrossAxisAlignment.start,
                          //                                      children: [
                          //                                        // SizedBox(height: 5,),
                          //
                          //                                        Row(
                          //                                          crossAxisAlignment: CrossAxisAlignment.start,
                          //                                          mainAxisAlignment: MainAxisAlignment.start,
                          //                                          children: [
                          //                                            Padding(
                          //                                              padding: const EdgeInsets.only(top: 7.0),
                          //                                              child: Container(
                          //                                                height: 7,
                          //                                                width: 7,
                          //                                                decoration: const BoxDecoration(
                          //                                                  color: Colors.grey,
                          //                                                  shape: BoxShape.circle
                          //                                                ),
                          //                                              ),
                          //                                            ),
                          //                                            const SizedBox(width: 5,),
                          //                                            Flexible(child: Text("Choose a well-lit environment",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                          //                                          ],
                          //                                        ),
                          //                                        const SizedBox(height: 5,),
                          //                                        Row(
                          //                                          crossAxisAlignment: CrossAxisAlignment.start,
                          //                                          mainAxisAlignment: MainAxisAlignment.start,
                          //                                          children: [
                          //                                            Padding(
                          //                                              padding: const EdgeInsets.only(top: 7.0),
                          //                                              child: Container(
                          //                                                height: 7,
                          //                                                width: 7,
                          //                                                decoration: const BoxDecoration(
                          //                                                    color: Colors.grey,
                          //                                                    shape: BoxShape.circle
                          //                                                ),
                          //                                              ),
                          //                                            ),
                          //                                            const SizedBox(width: 5,),
                          //                                            Flexible(child: Text("Turn up your brightness",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                          //                                          ],
                          //                                        ),
                          //                                        const SizedBox(height: 5,),
                          //                                        Row(
                          //                                          mainAxisAlignment: MainAxisAlignment.start,
                          //                                          crossAxisAlignment: CrossAxisAlignment.start,
                          //                                          children: [
                          //                                            Padding(
                          //                                              padding: const EdgeInsets.only(top: 7.0),
                          //                                              child: Container(
                          //                                                height: 7,
                          //                                                width: 7,
                          //                                                decoration: const BoxDecoration(
                          //                                                    color: Colors.grey,
                          //                                                    shape: BoxShape.circle
                          //                                                ),
                          //                                              ),
                          //                                            ),
                          //                                            const SizedBox(width: 5,),
                          //                                            Flexible(child: Text("Avoid ${homeProvider.userlocalData.userLogin!.name} glare and backlighting",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                          //                                          ],
                          //                                        ),
                          //                                      ],
                          //                                    ),
                          //                                  ),
                          //                                ),
                          //                                const SizedBox(height: 10,),
                          //                                 ListTile(
                          //                                   isThreeLine: true,
                          //                                   contentPadding: EdgeInsets.zero,
                          //                                   leading: Container(
                          //                                     height: 20,
                          //                                     width: 20,
                          //                                     decoration: BoxDecoration(
                          //                                         color: AppColors.appColor,
                          //                                         borderRadius: BorderRadius.circular(65)
                          //                                     ),
                          //                                     child: const Center(child: Icon(Icons.check,color: Colors.white,size: 12,)),
                          //                                   ),
                          //                                   title: Transform.translate(offset: const Offset(-10, -3),child: Text("Show your face",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18,fontWeight: FontWeight.bold),)),
                          //                                   subtitle: Transform.translate(
                          //                                     offset: const Offset(-10, 0),
                          //                                     child: Column(
                          //                                       crossAxisAlignment: CrossAxisAlignment.start,
                          //                                       children: [
                          //                                         // SizedBox(height: 5,),
                          //
                          //                                         Row(
                          //                                           crossAxisAlignment: CrossAxisAlignment.start,
                          //                                           mainAxisAlignment: MainAxisAlignment.start,
                          //                                           children: [
                          //                                             Padding(
                          //                                               padding: const EdgeInsets.only(top: 7.0),
                          //                                               child: Container(
                          //                                                 height: 7,
                          //                                                 width: 7,
                          //                                                 decoration: const BoxDecoration(
                          //                                                     color: Colors.grey,
                          //                                                     shape: BoxShape.circle
                          //                                                 ),
                          //                                               ),
                          //                                             ),
                          //                                             const SizedBox(width: 5,),
                          //                                             Flexible(child: Text("Face the camera directly",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                          //                                           ],
                          //                                         ),
                          //                                         const SizedBox(height: 5,),
                          //                                         Row(
                          //                                           crossAxisAlignment: CrossAxisAlignment.start,
                          //                                           mainAxisAlignment: MainAxisAlignment.start,
                          //                                           children: [
                          //                                             Padding(
                          //                                               padding: const EdgeInsets.only(top: 7.0),
                          //                                               child: Container(
                          //                                                 height: 7,
                          //                                                 width: 7,
                          //                                                 decoration: const BoxDecoration(
                          //                                                     color: Colors.grey,
                          //                                                     shape: BoxShape.circle
                          //                                                 ),
                          //                                               ),
                          //                                             ),
                          //                                             const SizedBox(width: 5,),
                          //                                             Flexible(child: Text("Remove hats, sunglasses, and face coverings",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,color: Colors.grey,),maxLines: 2,))
                          //                                           ],
                          //                                         ),
                          //
                          //                                       ],
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                                const SizedBox(height: 10,),
                          //                                 MainButton(
                          //                                     bgColor: AppColors.appColor,titleColor: Colors.white,
                          //                                     title: "Continue",
                          //                                     onTap: () async {
                          //                                       // final picked1 = await pickervaridfy.pickImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.rear);
                          //                                       // if(picked1!= null){
                          //                                       //   setState(() {
                          //                                       //     selectImageprofilevaridfy = picked1;
                          //                                       //   });
                          //                                       //
                          //                                       //
                          //                                       //   // List<int> imageByte =File(selectImageprofile!.path).readAsBytesSync();
                          //                                       //   // base64String =base64Encode(imageByte);
                          //                                       //   // profileProvider.profilepicApi(context: context,img: base64String.toString()).then((value) {
                          //                                       //   //   Navigator.of(context).pop();
                          //                                       //   //   setState(() {
                          //                                       //   //
                          //                                       //   //   });
                          //                                       //   // });
                          //                                       //
                          //                                       // } else{
                          //                                       //   print("did not pick an image!!");
                          //                                       // }
                          //
                          //                                       // showBottomSheet(
                          //                                       //   context: context, builder: (context) {
                          //                                       //   return Container(color: Colors.red,);
                          //                                       // },);
                          //
                          //
                          //                                       showModalBottomSheet(
                          //                                           isScrollControlled: true,
                          //                                           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          //                                           context: context,
                          //                                           builder: (c) {
                          //                                             // editProvider = Provider.of<EditProfileProvider>(context, listen: false);
                          //                                             return StatefulBuilder(builder: (context, setState) {
                          //                                               return Container(
                          //                                                 padding: const EdgeInsets.all(15),
                          //                                                 decoration: BoxDecoration(
                          //                                                   color: Theme.of(context).scaffoldBackgroundColor,
                          //                                                   borderRadius: BorderRadius.circular(16),
                          //                                                 ),
                          //                                                 child: SafeArea(
                          //                                                   child: Scaffold(
                          //                                                     resizeToAvoidBottomInset: false,
                          //                                                     body: SingleChildScrollView(
                          //                                                       child: Column(
                          //                                                         crossAxisAlignment: CrossAxisAlignment.start,
                          //                                                         children: [
                          //                                                           const SizedBox(height: 30,),
                          //                                                           InkWell(
                          //                                                               onTap: () {
                          //                                                                 Navigator.pop(context);
                          //                                                               },
                          //                                                               child: const Icon(Icons.close)
                          //                                                           ),
                          //                                                           const SizedBox(height: 10,),
                          //                                                           Center(child: Text("Get ready for",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24,fontWeight: FontWeight.bold))),
                          //                                                           Center(child: Text("your image selfie",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24,fontWeight: FontWeight.bold))),
                          //                                                           const SizedBox(height: 10,),
                          //                                                           Center(
                          //                                                             child: ClipOval(
                          //                                                               child: SizedBox(
                          //                                                                 height: 350,
                          //                                                                 width: 230,
                          //                                                                 child: selectImageprofilevaridfy == null ?
                          //                                                                 GestureDetector(
                          //                                                                   onDoubleTap: () {
                          //                                                                     setState((){
                          //                                                                       _toggleCamera();
                          //                                                                     });
                          //                                                                   },
                          //                                                                   child: FutureBuilder<void>(
                          //                                                                     future: _initializeControllerFuture,
                          //                                                                     builder: (context, snapshot) {
                          //                                                                       if (snapshot.connectionState == ConnectionState.done) {
                          //                                                                         return CameraPreview(imagecontroller);
                          //                                                                       } else {
                          //                                                                         return Center(child: CircularProgressIndicator(color: AppColors.appColor,));
                          //                                                                       }
                          //                                                                     },
                          //                                                                   ),
                          //                                                                 ) :
                          //                                                                 Image.file(File(selectImageprofilevaridfy!.path),fit: BoxFit.cover),
                          //                                                               ),
                          //                                                             ),
                          //                                                           ),
                          //                                                           // selectImageprofilevaridfy == null ? Container(height: 20,width: 20,color: Colors.yellow,) : Image.file(File(selectImageprofilevaridfy!.path),),
                          //                                                           const SizedBox(height: 10,),
                          //                                                           Center(child: Text("Make sure to frame your face in the oval, then tap  'i`m ready'!",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16,fontWeight: FontWeight.bold),maxLines: 2,textAlign: TextAlign.center,)),
                          //                                                           const SizedBox(height: 10,),
                          //                                                           MainButton(
                          //                                                             bgColor: AppColors.appColor,titleColor: Colors.white,
                          //                                                             title: "i m ready",
                          //                                                             onTap: () async {
                          //
                          //                                                               try {
                          //                                                                 await _initializeControllerFuture;
                          //                                                                 selectImageprofilevaridfy = await imagecontroller.takePicture();
                          //                                                                 List<int> imageByte = File(selectImageprofilevaridfy!.path).readAsBytesSync();
                          //                                                                 base64Stringverfy =base64Encode(imageByte);
                          //
                          //                                                                 profileProvider.identiverifyApi(context: context,img: base64Stringverfy.toString()).then((value) {
                          //                                                                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const BottomBar()), (route) => false);
                          //                                                                   setState(() {
                          //
                          //                                                                   });
                          //                                                                 });
                          //
                          //                                                                 print(" + + + + + :----  ${base64Stringverfy}");
                          //                                                               } catch (e) {
                          //                                                                 print('Error taking picture: $e');
                          //                                                               }
                          //
                          //
                          //                                                               setState((){});
                          //
                          //                                                             },
                          //                                                           ),
                          //                                                         ],
                          //                                                       ),
                          //                                                     ),
                          //                                                   ),
                          //                                                 ),
                          //                                               );
                          //                                             },);
                          //                                           });
                          //
                          //                                     }
                          //                                     ),
                          //                                 const SizedBox(height: 10,),
                          //                                 Center(child: Text('Maybe Later',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),)),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                         );
                          //                       })
                          //                 ],
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         child: const Padding(
                          //           padding: EdgeInsets.only(top: 4.0),
                          //           child: Image(image: AssetImage("assets/icons/notverify.png"),height: 22,width: 22,),
                          //         ),
                          //       ) : homeProvider.userlocalData.userLogin!.isVerify == "1" ? InkWell(
                          //         onTap: () {
                          //           showDialog<String>(
                          //             barrierDismissible: false,
                          //             context: context,
                          //             builder: (BuildContext context) => AlertDialog(
                          //               elevation: 0,
                          //               insetPadding: const EdgeInsets.only(left: 10,right: 10),
                          //               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(20),
                          //               ),
                          //               title: Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.center,
                          //                 children: [
                          //                   Container(
                          //                     height: 100,
                          //                     width: 100,
                          //                     decoration: BoxDecoration(
                          //                       shape: BoxShape.circle,
                          //                       image: DecorationImage(image: NetworkImage("${Config.baseUrl}${homeProvider.userlocalData.userLogin!.identityPicture}"),fit: BoxFit.cover)
                          //                     ),
                          //                   ),
                          //                   const SizedBox(height: 10,),
                          //                   Center(child: Text('verification Under',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                          //                   Center(child: Text('Review',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 22),)),
                          //                   const SizedBox(height: 10,),
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(left: 15,right: 15),
                          //                     child: Text("We are currently reviewing your selfies and will get back to you shortly!",style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),textAlign: TextAlign.center),
                          //                   ),
                          //                   // const SizedBox(height: 10,),
                          //                   const SizedBox(height: 20,),
                          //                   MainButton(
                          //                       bgColor: AppColors.appColor,titleColor: Colors.white,
                          //                       title: "OKAY",
                          //                       onTap: () {
                          //                         Navigator.pop(context);
                          //                       }),
                          //                   const SizedBox(height: 10,),
                          //                 ],
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         child: const Padding(
                          //           padding: EdgeInsets.only(top: 4.0),
                          //           child: Image(image: AssetImage("assets/icons/progressicon.png"),height: 22,width: 22,),
                          //         ),
                          //       ) : const Padding(
                          //         padding: EdgeInsets.only(top: 4.0),
                          //         child: Image(image: AssetImage("assets/icons/approveicon.png"),height: 22,width: 22,),
                          //       ),
                          //       const SizedBox(width: 15,),
                          //     ],
                          //   ),
                          // ),

                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                builder: (context) {
                                  return _buildImageSelectionModal(context);
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.appColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)?.translate("Edit") ?? "Edit",
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                                  ),
                                  const SizedBox(width: 5),
                                  SvgPicture.asset("assets/icons/edit.svg"),
                                ],
                              ),
                            ),
                          ),


                          // InkWell(
                          //  onTap: () {
                          //    // Navigator.pushNamed(context, EditProfile.editProfileRoute);
                          //
                          //
                          //    showModalBottomSheet(
                          //      context: context,
                          //      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          //      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                          //      builder: (context) {
                          //      return Stack(
                          //        children: [
                          //          Padding(
                          //            padding: const EdgeInsets.all(15),
                          //            child: SingleChildScrollView(
                          //              child: Column(
                          //                children: [
                          //                  // Text("From where do you want to take the photo?".tr, style: TextStyle(fontSize: 20, color: Colors.black),),
                          //                  Text(AppLocalizations.of(context)?.translate("From where do you want to take the photo?") ?? "From where do you want to take the photo?", style: Theme.of(context).textTheme.bodyLarge,),
                          //                  const SizedBox(height: 15),
                          //                  Row(
                          //                    children: [
                          //                      Expanded(
                          //                        child: MainButton(
                          //                            bgColor: AppColors.appColor,titleColor: Colors.white,
                          //                            // title: "Gallery".tr,
                          //                            title: AppLocalizations.of(context)?.translate("Gallery") ?? "Gallery",
                          //                            onTap: () async {
                          //                              final picked=await picker.pickImage(source: ImageSource.gallery);
                          //                              if(picked!= null){
                          //                                setState(() {
                          //                                  selectImageprofile = picked;
                          //                                });
                          //
                          //                                List<int> imageByte = File(selectImageprofile!.path).readAsBytesSync();
                          //                                base64String = base64Encode(imageByte);
                          //
                          //                                profileProvider.profilepicApi(context: context,img: base64String.toString()).then((value) {
                          //                                  Navigator.of(context).pop();
                          //                                  setState(() {
                          //
                          //                                  });
                          //                                });
                          //
                          //                              } else{
                          //                                print("did not pick an image!!");
                          //                              }
                          //                            }),
                          //                      ),
                          //                      const SizedBox(width: 8),
                          //                      Expanded(
                          //                        child: MainButton(
                          //                            bgColor: AppColors.appColor,titleColor: Colors.white,
                          //                            // title: "Camera".tr,
                          //                            title: AppLocalizations.of(context)?.translate("Camera") ?? "Camera",
                          //                            onTap: () async {
                          //                              final picked=await picker.pickImage(source: ImageSource.camera);
                          //                              if(picked!= null){
                          //                                setState(() {
                          //                                  selectImageprofile = picked;
                          //                                });
                          //
                          //                                List<int> imageByte =File(selectImageprofile!.path).readAsBytesSync();
                          //                                base64String =base64Encode(imageByte);
                          //                                profileProvider.profilepicApi(context: context,img: base64String.toString()).then((value) {
                          //                                  Navigator.of(context).pop();
                          //                                  setState(() {
                          //
                          //                                  });
                          //                                });
                          //
                          //                              } else{
                          //                                print("did not pick an image!!");
                          //                              }
                          //                            }
                          //                            ),
                          //                      ),
                          //                    ],
                          //                  ),
                          //                  const SizedBox(height: 15),
                          //                ],
                          //              ),
                          //            ),
                          //          ),
                          //        ],
                          //      );
                          //    },
                          //  );
                          //
                          //
                          //  },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: AppColors.appColor,
                          //       borderRadius: BorderRadius.circular(20)
                          //     ),
                          //     padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                          //     child: Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           // Text("Edit".tr,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),),
                          //           Text(AppLocalizations.of(context)?.translate("Edit") ?? "Edit",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),),
                          //           const SizedBox(width: 5,),
                          //           SvgPicture.asset("assets/icons/edit.svg"),
                          //
                          //     ]),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      InkWell(
                        onTap: () {
                          state.homeData.planId != "0" ?
                          Navigator.pushNamed(context, PlanDetils.planRoutes) :
                          Navigator.pushNamed(context, PremiumScreen.premiumScreenRoute);
                        },

                        child: Container(
                          // height: 110,
                          width: MediaQuery.of(context).size.width,
                          // padding: const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.appColor,
                              image: const DecorationImage(image: AssetImage("assets/Image/profileBg.png"),fit: BoxFit.cover),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(state.homeData.planId != "0" ?"You're Activated Membership!".tr :"Join Our Membership Today!".tr,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis),
                                    Text(state.homeData.planId != "0" ?AppLocalizations.of(context)?.translate("You're Activated Membership!") ?? "You're Activated Membership!" :AppLocalizations.of(context)?.translate("Join Our Membership Today!") ?? "Join Our Membership Today!",style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.white,fontWeight: FontWeight.w700),maxLines: 1,overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 5,),
                                    // Text(state.homeData.planId != "0" ? "Enjoy  premium and match anywhere.".tr : "Checkout GoMeet Premium".tr,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,overflow: TextOverflow.ellipsis),maxLines: 1,overflow: TextOverflow.ellipsis),
                                    Text(state.homeData.planId != "0" ? AppLocalizations.of(context)?.translate("Enjoy  premium and match anywhere.") ?? "Enjoy  premium and match anywhere." : AppLocalizations.of(context)?.translate("Checkout ForMen Premium") ?? "Checkout ForMen Premium",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,overflow: TextOverflow.ellipsis),maxLines: 1,overflow: TextOverflow.ellipsis),
                                  ],
                                ),),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  // child: Text(state.homeData.planId != "0" ? "Active".tr :"Go".tr,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.appColor)),
                                  child: Text(state.homeData.planId != "0" ? AppLocalizations.of(context)?.translate("Active") ?? "Active" : AppLocalizations.of(context)?.translate("Go") ?? "Go",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.appColor)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizBoxH(size: 0.01),
                      ListView.builder(
                        clipBehavior: Clip.none,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return i == 2 ? profileProvider.isLoading?  ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Loream(title: profileProvider.privacyPolicy.pagelist![index].title.toString(), discription: profileProvider.privacyPolicy.pagelist![index].description.toString()),));
                                    },
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    leading: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: SvgPicture.asset("assets/icons/clipboard-text.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),
                                          // height: 25,
                                          // width: 25,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      profileProvider.privacyPolicy.pagelist![index].title.toString(),
                                      style: Theme.of(context).textTheme.bodyMedium!,
                                    ),
                                    trailing:  SvgPicture.asset("assets/icons/Arrow - Right 2.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),),
                                  );
                                }  ,itemCount: profileProvider.privacyPolicy.pagelist!.length) : const SizedBox() :



                            ListTile(
                              onTap: () async {
                                if (i == 0) {
                                  Navigator.pushNamed(context, EditProfile.editProfileRoute);
                                }
                                else if(i == 3){
                                  Navigator.pushNamed(context, FaqPage.faqRoute);
                                }
                                else if(i == 4){
                                  profileProvider.blocklistaApi(context).then((value) {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const profile_privacyy(),));
                                    setState(() {
                                    });
                                  });

                                }
                                else if(i == 5){
                                  // profileProvider.blocklistaApi(context).then((value) {
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => const profile_privacyy(),));
                                  //   setState(() {
                                  //   });
                                  // });

                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                    return Container(
                                      height: 610,
                                      decoration:  BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: 8,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () async{

                                                      SharedPreferences preferences = await SharedPreferences.getInstance();

                                                      setState(()  {
                                                        value = index;
                                                        preferences.setInt("valuelangauge", value);
                                                      });



                                                      switch (index) {
                                                        case 0:
                                                          BlocProvider.of<LanguageCubit>(context).toEnglish();
                                                          Navigator.pop(context);
                                                          break;
                                                        case 1:
                                                          BlocProvider.of<LanguageCubit>(context).toSpanish();
                                                          Navigator.pop(context);
                                                          break;
                                                        case 2:
                                                          BlocProvider.of<LanguageCubit>(context).toArabic();
                                                          Navigator.pop(context);
                                                          break;
                                                        case 3:
                                                          BlocProvider.of<LanguageCubit>(context).toHindi();
                                                          Navigator.pop(context);
                                                          break;
                                                        case 4:
                                                          BlocProvider.of<LanguageCubit>(context).toGujarati();
                                                          Navigator.pop(context);
                                                          break;
                                                        case 5:
                                                          BlocProvider.of<LanguageCubit>(context).toAfrikaans();
                                                          Navigator.pop(context);
                                                          break;
                                                        case 6:
                                                          BlocProvider.of<LanguageCubit>(context).toBengali();
                                                          Navigator.pop(context);
                                                          break;
                                                        case 7:
                                                          BlocProvider.of<LanguageCubit>(context).toIndonesian();
                                                          Navigator.pop(context);
                                                          break;
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      width: MediaQuery.of(context).size.width,
                                                      margin: const EdgeInsets.symmetric(vertical: 7),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: value == index ? AppColors.appColor : Colors.transparent,),
                                                          color:  Theme.of(context).scaffoldBackgroundColor,
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 45,
                                                                  width: 60,
                                                                  margin: const EdgeInsets.symmetric(
                                                                      horizontal: 10),
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    borderRadius: BorderRadius.circular(100),
                                                                  ),
                                                                  child: Center(
                                                                    child: Container(
                                                                      height: 32,
                                                                      width: 32,
                                                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(languageimage[index]),)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 10),
                                                                // Column(
                                                                //   crossAxisAlignment:
                                                                //   CrossAxisAlignment.start,
                                                                //   children: [
                                                                //     Text(languagetext[index],
                                                                //         style: TextStyle(
                                                                //             fontSize: 14,
                                                                //             color: AppColors.black
                                                                //         )),
                                                                //   ],
                                                                // ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(languagetext[index], style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14)),
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                CheckboxListTile(index),
                                                                const SizedBox(width: 15,),
                                                              ],
                                                            ),
                                                          ]),
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                     },
                                  );

                                }
                                else if(i == profileProvider.menuList.length -2) {
                                  profileProvider.deleteButtomSheet(context);
                                }else if(i == profileProvider.menuList.length -3) {
                                  Share.share(
                                    "Hey! 👋've found this awesome dating app called ${profileProvider.appName} and thought you might be interested too! 😊.Check it out:${Platform.isAndroid
                                        ? 'https://play.google.com/store/apps/details?id=${profileProvider.packageName}'
                                        : Platform.isIOS
                                        ? 'https://apps.apple.com/us/app/${profileProvider.appName}/id${profileProvider.packageName}'
                                        : ""}",
                                  );
                                }
                                else if(i == profileProvider.menuList.length -1) {
                                  isUserLogOut(Provider.of<HomeProvider>(context,listen: false).uid);
                                  Navigator.pushNamedAndRemoveUntil(context, AuthScreen.authScreenRoute,(route) => false,);
                                  homeProvider.setSelectPage(0);
                                  Preferences.clear();
                                  await GoogleSignIn().signOut();
                                  await FacebookAuth.instance.logOut();
                                }
                              },
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: SvgPicture.asset("${profileProvider.menuList[i]["icon"]}",colorFilter: ColorFilter.mode(profileProvider.menuList[i]["iconShow"] == "0" ? Colors.red : Theme.of(context).indicatorColor, BlendMode.srcIn),
                                    // height: 25,
                                    // width: 25,
                                  ),
                                ),
                              ),
                              // title: Text("${profileProvider.menuList[i]["title"]}", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: profileProvider.menuList[i]["iconShow"] == "0" ? Colors.red : null),),
                              title: Text(AppLocalizations.of(context)?.translate("${profileProvider.menuList[i]["title"]}") ?? "${profileProvider.menuList[i]["title"]}", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: profileProvider.menuList[i]["iconShow"] == "0" ? Colors.red : null),),
                              trailing: profileProvider.menuList[i]["iconShow"] == "2" ? SizedBox(
                                height: 40,
                                width: 30,
                                child: Transform.scale(
                                    scale: 0.7,
                                    child: Switch(
                                        value: profileProvider.isDartMode,
                                        onChanged: (r) async {
                                          profileProvider.changeMode();

                                          if(r) {
                                            BlocProvider.of<ThemeBloc>(context).addTheme(ThemeEvent.toggleDark);
                                            setThemeData('dark');
                                          } else {
                                            BlocProvider.of<ThemeBloc>(context).addTheme(ThemeEvent.toggleLight);
                                            setThemeData('lite');
                                          }

                                        })),
                              ) : profileProvider.menuList[i]["iconShow"] == "1" ? SvgPicture.asset("${profileProvider.menuList[i]["traling"]}",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),) : const SizedBox(),
                            );
                          },
                          itemCount: profileProvider.menuList.length
                      ),
                      // SizedBox(height: 100,)
                    ],
                  );
                }else{
                  return Center(child: CircularProgressIndicator(color: AppColors.appColor));
                }
              }
            ),
          ),
        ),
      ),
    );
  }

  setThemeData(String value) async {
    SharedPreferences preferences =  await SharedPreferences.getInstance();

    preferences.setString("ThemeData", value);
  }


  Widget CheckboxListTile(int index) {
    return SizedBox(
      height: 24,
      width: 24,
      child: ElevatedButton(
        onPressed: () async {
          value = index;
          SharedPreferences preferences = await SharedPreferences.getInstance();
          setState(() {
            value = index;
            preferences.setInt("valuelangauge", value);

            switch (index) {
              case 0:
                BlocProvider.of<LanguageCubit>(context).toEnglish();
                Navigator.pop(context);
                break;
              case 1:
                BlocProvider.of<LanguageCubit>(context).toSpanish();
                Navigator.pop(context);
                break;
              case 2:
                BlocProvider.of<LanguageCubit>(context).toArabic();
                Navigator.pop(context);
                break;
              case 3:
                BlocProvider.of<LanguageCubit>(context).toHindi();
                Navigator.pop(context);
                break;
              case 4:
                BlocProvider.of<LanguageCubit>(context).toGujarati();
                Navigator.pop(context);
                break;
              case 5:
                BlocProvider.of<LanguageCubit>(context).toAfrikaans();
                Navigator.pop(context);
                break;
              case 6:
                BlocProvider.of<LanguageCubit>(context).toBengali();
                Navigator.pop(context);
                break;
              case 7:
                BlocProvider.of<LanguageCubit>(context).toIndonesian();
                Navigator.pop(context);

            }

          });
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xffEEEEEE),
          side: BorderSide(
            color: (value == index)
                ? Colors.transparent
                : Colors.transparent,
            width: (value == index) ? 2 : 2,
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Center(
            child: Icon(
              Icons.check,
              color: value == index ? Colors.black : Colors.transparent,
              size: 18,
            )),
      ),
    );
  }

  Widget _buildImageSelectionModal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)?.translate("From where do you want to take the photo?") ?? "From where do you want to take the photo?",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    bgColor: AppColors.appColor,
                    titleColor: Colors.white,
                    title: AppLocalizations.of(context)?.translate("Gallery") ?? "Gallery",
                    onTap: () => _selectImageFromGallery(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MainButton(
                    bgColor: AppColors.appColor,
                    titleColor: Colors.white,
                    title: AppLocalizations.of(context)?.translate("Camera") ?? "Camera",
                    onTap: () => _selectImageFromCamera(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImageFromGallery(BuildContext context) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _processSelectedImage(context, picked.path);
    } else {
      print("No image selected!");
    }
  }

  Future<void> _selectImageFromCamera(BuildContext context) async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      _processSelectedImage(context, picked.path);
    } else {
      print("No image selected!");
    }
  }

  void _processSelectedImage(BuildContext context, String imagePath) {
    // Process the selected image, for example, uploading it to a server or displaying it in UI.
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64String = base64Encode(imageBytes);

    profileProvider.profilepicApi(context: context, img: base64String).then((value) {
      Navigator.of(context).pop(); // Close the bottom modal sheet
      setState(() {
        // Update UI if necessary
      });
    });
  }

}
