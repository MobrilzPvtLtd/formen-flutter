import 'package:dating/Logic/cubits/onBording_cubit/onbording_cubit.dart';
import 'package:dating/data/models/relationGoalModel.dart';
import 'package:dating/presentation/screens/splash_bording/onbording_screens.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/ui.dart';
import '../../../../data/localdatabase.dart';
import '../../../../data/models/getinterest_model.dart';
import '../../../../data/models/languagemodel.dart';
import '../../../../data/models/religionmodel.dart';
import '../../../../language/localization/app_localization.dart';
import '../../BottomNavBar/bottombar.dart';
import '../auth_screen.dart';

class OnBordingProvider with ChangeNotifier {
  final name =                    TextEditingController();
  final email =                   TextEditingController();
  final emailLogin =              TextEditingController();
  final password =                TextEditingController();
  final passwordLogin =           TextEditingController();
  final referelCode =             TextEditingController();
  final bio =                     TextEditingController();
  final mobileNumber =            TextEditingController();
  final languageContoller =       TextEditingController();
  final hobieSearchContoller =    TextEditingController();
  final religionSearchContoller = TextEditingController();


  bool proisLast = true;

  updateProisLast(bool value){
    proisLast = value;
    notifyListeners();
  }

  bool isLast = false;

  updateIsLast(){
    isLast =! isLast;
    notifyListeners();
  }

  desposee() {
    name.clear();
    password.clear();
    referelCode.clear();
    bio.clear();
    mobileNumber.clear();
    languageContoller.clear();
    hobieSearchContoller.clear();
    religionSearchContoller.clear();
    email.clear();
  }

  // bool isedit = false;
  // updateIsEdit(bool value) {
  //   isedit = value;
  //   notifyListeners();
  // }


  int onboradingCurrent = 0;
  PageController onbordingScroll = PageController();

  updateOnboradingCurrent(int value){
    onboradingCurrent = value;
    notifyListeners();
  }
  List onBordingData = [
    {
      "title": "Find Your Spark: Where Connections Ignite.",
      "image": "assets/Image/mainHomeBackground.jpg",
    },
    {
      "title": "Connecting Hearts, One Swipe at a Time",
      "image": "assets/Image/mainMembrosBackground.jpg",
    },
    {
      "title": "Discover, Connect, Love: Your Journey Starts Here",
      "image": "assets/Image/mainHomeBackground.jpg",
    },
    {
      "title": "It’s match",
      "image": "assets/Image/mainMembrosBackground.jpg",
    }
  ];

  List<XFile> images = [];
  final ImagePicker picker = ImagePicker();

  String ccode = "91";
  List manWoman = ["Man", "Woman", "Other"];
  List searchPref = ["Man", "Woman", "Both"];

  int select = -1;
  int select1 = -1;
  int stepsCount = 0;
  int selectReligion = -1;
  int relationGoal = -1;
  double kmCounter = 10;
  String otp = "";

  DateTime? bdatePicker;
  bool loginpassObs = true;

  updatebloginPass() {
    loginpassObs = !loginpassObs;
    notifyListeners();
  }

  updatebdate(DateTime date) {
    bdatePicker = date;
    notifyListeners();
  }

  RelationGoalModel? relationGoalData;
  InterestModel? getInterestModel;
  LanguageModel? languageModel;
  ReligionModel? religionModel;

  bool isEmailEdite = false;

  List selectHobi = [];
  List selectedLanguage = [];
  List searchForLanguage = [];
  List searchForHobie = [];
  List searchForReligion = [];

  pickupImage(int index) async {
    if (images.length == index) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      images.add(image!);
      notifyListeners();
    }
  }

  String vericitionId = "";

  otpBottomSheet(context,bool isForgot) {
    return showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (BuildContext context) {
           return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Awesome", style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 5),
                    RichText(text: TextSpan(children: [
                      // TextSpan(text: "We have sent the OTP to".tr,style: Theme.of(context).textTheme.bodyMedium),
                      TextSpan(text: AppLocalizations.of(context)?.translate("We have sent the OTP to") ?? "We have sent the OTP to",style: Theme.of(context).textTheme.bodyMedium),
                      TextSpan(text: " +$ccode ${mobileNumber.text}",style: Theme.of(context).textTheme.bodyMedium),
                    ])),
                    const SizedBox(height: 10),

                    OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 45,
                      keyboardType: TextInputType.number,
                      outlineBorderRadius: 8,
                      style: Theme.of(context).textTheme.headlineSmall!,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(borderColor: Theme.of(context).dividerTheme.color!,errorBorderColor: Theme.of(context).dividerTheme.color!,focusBorderColor: AppColors.appColor,enabledBorderColor: Theme.of(context).dividerTheme.color!,disabledBorderColor: Theme.of(context).dividerTheme.color!,backgroundColor: Theme.of(context).cardColor),
                      onChanged: (value) {
                        otp = value;
                        notifyListeners();
                      },
                    ),

                    const SizedBox(height: 20),
                    MainButton(
                      // title: "Continue".tr,
                      title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",
                      onTap: () async {
                        try {
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vericitionId, smsCode: otp);
                          await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                            if (value.user != null) {
                              if(isForgot){
                                Navigator.pop(context);
                                newPassWord(context,mobileNumber.text,ccode);
                              }else{
                                updatestepsCount(2);
                                Navigator.pop(context);
                              }
                            }
                          });

                        } catch (e) {
                          // Fluttertoast.showToast(msg: "OTP Invalid".tr);
                          Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("OTP Invalid") ?? "OTP Invalid");
                        }
                      },

                    )
                  ],
                ),
              ),
            ),
        );
    });
  }

  TextEditingController pass = TextEditingController();
  TextEditingController newPass = TextEditingController();

newPassWord(context,mobileNumber,ccode){
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context, builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Password".tr,style: Theme.of(context).textTheme.bodySmall,),
              Text(AppLocalizations.of(context)?.translate("Password") ?? "Password",style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: 5,),
              // TextFieldPro(controller: pass, hintText: "Password".tr,textalingn: TextAlign.start),
              TextFieldPro(controller: pass, hintText: AppLocalizations.of(context)?.translate("Password") ?? "Password",textalingn: TextAlign.start),
              const SizedBox(height: 10),
              // Text("Confirm Password".tr,style: Theme.of(context).textTheme.bodySmall,),
              Text(AppLocalizations.of(context)?.translate("Confirm Password") ?? "Confirm Password",style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: 5,),
              // TextFieldPro(controller: newPass, hintText: "Confirm".tr,textalingn: TextAlign.start,),
              TextFieldPro(controller: newPass, hintText: AppLocalizations.of(context)?.translate("Confirm") ?? "Confirm",textalingn: TextAlign.start,),
              const SizedBox(height: 20,),
               Row(
                children: [
                  // Expanded(child: MainButton(title: "Submit".tr,onTap: () {
                  Expanded(child: MainButton(title: AppLocalizations.of(context)?.translate("Submit") ?? "Submit",onTap: () {
                    if(pass.text == newPass.text){
                      BlocProvider.of<OnbordingCubit>(context).forgotPassApi(context: context,ccode: ccode,mobile: mobileNumber,password: newPass.text);
                    }else{
                      // Fluttertoast.showToast(msg: "Password Not Match".tr);
                      Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Password Not Match") ?? "Password Not Match");
                    }

                  },)),
                ],
              ),
            ],
          ),
        ),
      );
    },);
}


  removeImages(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  searchLanguage(s) {
    searchForLanguage = [];
    for (int i = 0; i < languageModel!.languagelist!.length; i++) {
      if (languageModel!.languagelist![i].title
          .toString()
          .toLowerCase()
          .contains(s.toLowerCase())) {
        final ids = languageModel!.languagelist!.map<String>((e) => e.id!).toSet();

        languageModel!.languagelist!.retainWhere((x) {
          return ids.remove(x.id);
        });

        searchForLanguage.add(i);
        notifyListeners();
      }
      else {
        notifyListeners();
      }
    }
  }

  searchHobie(s) {
    searchForHobie = [];
    for (int i = 0; i < getInterestModel!.interestlist!.length; i++) {
      if (getInterestModel!.interestlist![i].title
          .toString()
          .toLowerCase()
          .contains(s.toLowerCase())) {
        final ids = getInterestModel!.interestlist!.map<String>((e) => e.id!).toSet();

        getInterestModel!.interestlist!.retainWhere((x) {
          return ids.remove(x.id);
        });

        searchForHobie.add(i);
        notifyListeners();
      } else {
        notifyListeners();
      }
    }
  }

  searchReligion(s) {
    searchForReligion = [];
    for (int i = 0; i < religionModel!.religionlist!.length; i++) {
      if (religionModel!.religionlist![i].title.toString().toLowerCase().contains(s.toLowerCase())) {

        final ids = religionModel!.religionlist!.map<String>((e) => e.id!).toSet();

        religionModel!.religionlist!.retainWhere((x) {
          return ids.remove(x.id);
        });

        searchForReligion.add(i);
        notifyListeners();

      } else {
        notifyListeners();
      }
    }
  }

  String maleFemaleOther(int value) {
    switch (value) {
      case 0:
        return "MALE";
      case 1:
        return "FEMALE";
      case 2:
        return "OTHER";
      default:
        return "";
    }
  }

  String maleFemaleBoth(int value) {
    switch (value) {
      case 0:
        return "MALE";
      case 1:
        return "FEMALE";
      case 2:
        return "BOTH";
      default:
        return "";
    }
  }

  addlanguage(value) {
    selectedLanguage.add(value);
    notifyListeners();
  }

  removelanguage(value) {
    selectedLanguage.remove(value);
    notifyListeners();
  }

  addInHobi(index) {
    selectHobi.add(index);
    notifyListeners();
  }

  removeHobi(index) {
    selectHobi.remove(index);
    notifyListeners();
  }

  updatekm(double value) {
    kmCounter = value;
    notifyListeners();
  }

  setreligionModel(ReligionModel value) {
    religionModel = value;
    notifyListeners();
  }

  setlanguageModel(LanguageModel value) {
    languageModel = value;
    notifyListeners();
  }

  setRelationGoalModel(RelationGoalModel value) {
    relationGoalData = value;
    notifyListeners();
  }

  setInterestModel(InterestModel value) {
    getInterestModel = value;
    notifyListeners();
  }

  updaterelationGoal(int value) {
    relationGoal = value;
    notifyListeners();
  }

  updatereligion(int value) {
    selectReligion = value;
    notifyListeners();
  }

  updatestepsCount(int value) {
    stepsCount = value;
    notifyListeners();
  }

  updateMaleFemale1(int value) {
    select1 = value;
    notifyListeners();
  }

  updateMaleFemale(int value) {
    select = value;
    notifyListeners();
  }

  updateNameFiled({required TextEditingController controller, value}) {
    controller.text = value;
    notifyListeners();
  }

  updateVeriable(value2) {
    notifyListeners();
    return value2;
  }

  setDataInFildes(User userdata) {
    name.text = userdata.displayName ?? "";
    email.text = userdata.email ?? "";
    mobileNumber.text = userdata.phoneNumber ?? "";
    if (userdata.email!.isNotEmpty) {
      isEmailEdite = true;
    } else {
      isEmailEdite = false;
    }
    notifyListeners();
  }

  double? lat;
  double? long;

  getCurrentLatAndLong(context) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      lat = 40.463667;
      long = -3.74922;
      notifyListeners();
    }
    try {
      var currentLocation = await locateUser();
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      notifyListeners();
      nextPage(context);
    } catch (e) {
      lat = 40.463667;
      long = -3.74922;
      notifyListeners();
      nextPage(context);
    }
  }

  nextPage(context) {
    Future.delayed(const Duration(seconds: 3), () {
      Preferences.fetchUserDetails().then((value) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        bool onBording =  preferences.getBool("Onbording") ?? true;
        if (value != null && value.toString().isNotEmpty) {
          Navigator.pushNamedAndRemoveUntil(context, BottomBar.bottomBarRoute, (route) => false);
        } else {
          if(onBording){
            Navigator.pushNamedAndRemoveUntil(context, OnBoardingScreen.onBoardingScreenRoute, (route) => false);
          }else{
            Navigator.pushNamedAndRemoveUntil(context, AuthScreen.authScreenRoute, (route) => false);
          }

          await GoogleSignIn().signOut();
          await FacebookAuth.instance.logOut();
        }
      });
    });
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
