import 'dart:io';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_cubit.dart';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_state.dart';
import 'package:dating/core/config.dart';
import 'package:dating/data/models/languagemodel.dart';
import 'package:dating/data/models/relationGoalModel.dart';
import 'package:dating/data/models/religionmodel.dart';
import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:dating/presentation/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../../core/ui.dart';
import '../../../data/models/getinterest_model.dart';
import '../../../language/localization/app_localization.dart';

class CreatSteps extends StatefulWidget {
  static const String creatStepsRoute = "/creatSteps";
  const CreatSteps({super.key});

  @override
  State<CreatSteps> createState() => _CreatStepsState();
}

class _CreatStepsState extends State<CreatSteps> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<OnbordingCubit>(context).relationGoalListApi().then((value) {
      onBordingProvider.setRelationGoalModel(value);
    });

    BlocProvider.of<OnbordingCubit>(context).getInterestApi().then((value) {
      onBordingProvider.setInterestModel(value);
    });

    BlocProvider.of<OnbordingCubit>(context).languagelistApi().then((value) {
      onBordingProvider.setlanguageModel(value);
    });

    BlocProvider.of<OnbordingCubit>(context).religionApi().then((value) {
      onBordingProvider.setreligionModel(value);
    });

  }

  @override
  void dispose() {
    super.dispose();
    onBordingProvider.desposee();
  }

  late OnBordingProvider onBordingProvider;

  @override
  Widget build(BuildContext context) {
    onBordingProvider = Provider.of<OnBordingProvider>(context);
    return PopScope(
      canPop: onBordingProvider.stepsCount == 0 ? true : false,
      onPopInvoked: (b) async {
        if (onBordingProvider.stepsCount == 0) {
          await GoogleSignIn().signOut();
          await FacebookAuth.instance.logOut();


        } else {
          onBordingProvider.updatestepsCount(onBordingProvider.stepsCount - 1);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {

              if (onBordingProvider.name.text.isNotEmpty &&
                  onBordingProvider.email.text.isNotEmpty &&
                  onBordingProvider.password.text.isNotEmpty &&
                  onBordingProvider.stepsCount == 0) {
                onBordingProvider.updatestepsCount(1);
              } else if (onBordingProvider.mobileNumber.text.isNotEmpty &&
                  onBordingProvider.stepsCount == 1) {
                BlocProvider.of<OnbordingCubit>(context).mobileCheckApi(number: onBordingProvider.mobileNumber.text, ccode: onBordingProvider.ccode).then((value) {
                  if (value == "true") {
                    BlocProvider.of<OnbordingCubit>(context).sendOtpFunction(number: "+${onBordingProvider.ccode} ${onBordingProvider.mobileNumber.text}", context: context,isForgot: false);
                  }
                });
              } else if (onBordingProvider.bdatePicker.toString() != "null" &&
                  onBordingProvider.stepsCount == 2) {
                onBordingProvider.updatestepsCount(3);
              } else if (onBordingProvider.select >= 0 &&
                  onBordingProvider.stepsCount == 3) {
                onBordingProvider.updatestepsCount(4);
              } else if (onBordingProvider.relationGoal >= 0 &&
                  onBordingProvider.stepsCount == 4) {
                onBordingProvider.updatestepsCount(5);
              } else if (onBordingProvider.kmCounter >= 10 &&
                  onBordingProvider.stepsCount == 5) {
                onBordingProvider.updatestepsCount(6);
              } else if (onBordingProvider.selectHobi.isNotEmpty &&
                  onBordingProvider.selectHobi.length <= 5 &&
                  onBordingProvider.stepsCount == 6) {
                onBordingProvider.updatestepsCount(7);
              } else if (onBordingProvider.selectedLanguage.isNotEmpty &&
                  onBordingProvider.stepsCount == 7) {
                onBordingProvider.updatestepsCount(8);
              } else if (onBordingProvider.selectReligion >= 0 &&
                  onBordingProvider.stepsCount == 8) {
                onBordingProvider.updatestepsCount(9);
              } else if (onBordingProvider.select1 >= 0 &&
                  onBordingProvider.stepsCount == 9) {
                onBordingProvider.updatestepsCount(10);
              } else if (onBordingProvider.stepsCount == 10 &&
                  onBordingProvider.images.length >= 3) {
                BlocProvider.of<OnbordingCubit>(context)
                    .registerUserApi(
                        name: onBordingProvider.name.text,
                        email: onBordingProvider.email.text,
                        mobile: onBordingProvider.mobileNumber.text,
                        ccode: "+${onBordingProvider.ccode}",
                        bday: onBordingProvider.bdatePicker
                            .toString()
                            .split(" ")
                            .first,
                        searchPreference: onBordingProvider.maleFemaleBoth(onBordingProvider.select1),
                        rediusSearch:
                            onBordingProvider.kmCounter.toStringAsFixed(2),
                        relationGoal: onBordingProvider.relationGoal.toString(),
                        profileBio: onBordingProvider.bio.text,
                        intrest: onBordingProvider.selectHobi.join(","),
                        language: onBordingProvider.selectedLanguage.join(","),
                        password: onBordingProvider.password.text,
                        refCode: onBordingProvider.referelCode.text,
                        gender: onBordingProvider.maleFemaleOther(onBordingProvider.select),
                        lat: onBordingProvider.lat.toString(),
                        long: onBordingProvider.long.toString(),
                        religon: onBordingProvider.selectReligion.toString(),
                        images: onBordingProvider.images,context: context)
                    .then((value) {
                  Fluttertoast.showToast(msg: value.responseMsg.toString());
                });
              } else {
                if ((onBordingProvider.name.text.isEmpty ||
                        onBordingProvider.email.text.isEmpty ||
                        onBordingProvider.password.text.isEmpty) &&
                    onBordingProvider.stepsCount == 0) {
                  if (onBordingProvider.name.text.isEmpty) {
                    // Fluttertoast.showToast(msg: "Please Enter Name".tr);
                    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter Name") ?? "Please Enter Name");
                  } else if (onBordingProvider.email.text.isEmpty) {
                    // Fluttertoast.showToast(msg: "Please Enter Email".tr);
                    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter Email") ?? "Please Enter Email");
                  } else if (onBordingProvider.password.text.isEmpty) {
                    // Fluttertoast.showToast(msg: "Please Enter Password".tr);
                    Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter Password") ?? "Please Enter Password");
                  }
                } else if (onBordingProvider.mobileNumber.text.isEmpty &&
                    onBordingProvider.stepsCount == 1) {
                  // Fluttertoast.showToast(msg: "Please Enter MobileNumber".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter MobileNumber") ?? "Please Enter MobileNumber");
                } else if (onBordingProvider.bdatePicker.toString() == "null" &&
                    onBordingProvider.stepsCount == 2) {
                  // Fluttertoast.showToast(msg: "Please Enter BirthDate".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Enter BirthDate") ?? "Please Enter BirthDate");
                } else if (onBordingProvider.select < 0 &&
                    onBordingProvider.stepsCount == 3) {
                  // Fluttertoast.showToast(msg: "Please Select Gender".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Gender") ?? "Please Select Gender");
                } else if (onBordingProvider.relationGoal < 0 &&
                    onBordingProvider.stepsCount == 4) {
                  Fluttertoast.showToast(
                      // msg: "Please Select Relationship Goals".tr);
                      msg: AppLocalizations.of(context)?.translate("Please Select Relationship Goals") ?? "Please Select Relationship Goals");
                } else if (onBordingProvider.kmCounter < 10 &&
                    onBordingProvider.stepsCount == 5) {
                  // Fluttertoast.showToast(msg: "Please Select Nearby".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Nearby") ?? "Please Select Nearby");
                } else if (onBordingProvider.selectHobi.length <= 5 &&
                    onBordingProvider.stepsCount == 6) {
                  // Fluttertoast.showToast(msg: "Please Select Hobies".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Hobies") ?? "Please Select Hobies");
                } else if (onBordingProvider.selectedLanguage.isNotEmpty &&
                    onBordingProvider.stepsCount == 7) {
                  // Fluttertoast.showToast(msg: "Please Select Language".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Language") ?? "Please Select Language");
                } else if (onBordingProvider.selectReligion < 0 &&
                    onBordingProvider.stepsCount == 8) {
                  // Fluttertoast.showToast(msg: "Please Select Religion".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Religion") ?? "Please Select Religion");
                } else if (onBordingProvider.select1 < 0 &&
                    onBordingProvider.stepsCount == 9) {
                  // Fluttertoast.showToast(msg: "Please Select Gender".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Gender") ?? "Please Select Gender");
                } else if (onBordingProvider.stepsCount == 10 &&
                    onBordingProvider.images.length < 3) {
                  // Fluttertoast.showToast(msg: "Please Select Minimum 3 Images".tr);
                  Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Please Select Minimum 3 Images") ?? "Please Select Minimum 3 Images");
                }
              }
            },
            backgroundColor: AppColors.appColor,
            child: SvgPicture.asset(
              "assets/icons/angle-right-small.svg",
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            )),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    onBordingProvider.stepsCount == 0
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              onBordingProvider.updatestepsCount(onBordingProvider.stepsCount - 1);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/BackIcon.svg",
                              height: 25,
                              width: 25,
                              colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.color ??
                                      Colors.black,
                                  BlendMode.srcIn),
                            ),
                          ),
                    const SizBoxW(size: 0.05),
                    Expanded(
                      child: Stack(
                        children: [

                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                                color: Theme.of(context).dividerTheme.color!,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                                color: AppColors.appColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: onBordingProvider.stepsCount == 0
                                ? 10
                                : (onBordingProvider.stepsCount * 2.6) *
                                    (MediaQuery.of(context).size.width * 0.027),
                          ),
                        ],
                      ),
                    ),
                    const SizBoxW(size: 0.05),
                  ]),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Builder(builder: (context) {
                switch (onBordingProvider.stepsCount) {
                  case 0:
                    return step1();
                  case 1:
                    return step2();
                  case 2:
                    return step3();
                  case 3:
                    return step4();
                  case 4:
                    return step5();
                  case 5:
                    return step6();
                  case 6:
                    return step7();
                  case 7:
                    return step8();
                  case 8:
                    return step9();
                  case 9:
                    return step10();
                  case 10:
                    return step11();
                  default:
                    return step1();
                }
              }),
              BlocConsumer<OnbordingCubit, OnbordingState>(
                  listener: (context, state) {
                if (state is CompletSteps) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, BottomBar.bottomBarRoute, (route) => false);
                }
                if (state is ErrorState) {
                  Fluttertoast.showToast(msg: state.error);
                }
              }, builder: (context, state) {
                if (state is LoadingState) {
                  return CircularProgressIndicator(color: AppColors.appColor);
                } else {
                  return const SizedBox();
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget step1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // "Can you elaborate on your identity? 😎".tr,
              AppLocalizations.of(context)?.translate("Can you elaborate on your identity? 😎") ?? "Can you elaborate on your identity? 😎",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizBoxH(size: 0.012),
            Text(
              // "It will Display on your Profile and you will not able to change it later".tr,
              AppLocalizations.of(context)?.translate("It will Display on your Profile and you will not able to change it later") ?? "It will Display on your Profile and you will not able to change it later",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizBoxH(size: 0.018),
            TextFieldPro(
              controller: onBordingProvider.name,
              // hintText: "Frist Name".tr,
              hintText: AppLocalizations.of(context)?.translate("Frist Name") ?? "Frist Name",
              onChangee: (e) {
                onBordingProvider.updateNameFiled(
                    controller: onBordingProvider.name, value: e);
              },
              textalingn: TextAlign.start,
              suffixIconPath: onBordingProvider.name.text.isEmpty
                  ? ""
                  : "assets/icons/verify.svg",
            ),
            const SizBoxH(size: 0.018),
            TextFieldPro(
              controller: onBordingProvider.email,
              // hintText: "Email".tr,
              hintText: AppLocalizations.of(context)?.translate("Email") ?? "Email",
              readOnly: onBordingProvider.isEmailEdite,
              onChangee: (e) {
                onBordingProvider.updateNameFiled(
                    controller: onBordingProvider.email, value: e);
              },
              textalingn: TextAlign.start,
              suffixIconPath: onBordingProvider.email.text.isEmpty
                  ? ""
                  : "assets/icons/verify.svg",
            ),
            const SizBoxH(size: 0.018),
            TextFieldPro(
              controller: onBordingProvider.password,
              // hintText: "Password".tr,
              hintText: AppLocalizations.of(context)?.translate("Password") ?? "Password",
              onChangee: (e) {
                onBordingProvider.updateNameFiled(
                    controller: onBordingProvider.password, value: e);
              },
              obscureText: onBordingProvider.isLast,
              textalingn: TextAlign.start,
              surfixOntap: () {
                onBordingProvider.updateIsLast();
              },
              suffixIconPath: onBordingProvider.isLast? "assets/icons/eye-slash.svg" : "assets/icons/eye.svg",
            ),
            // const SizBoxH(size: 0.018),
            // TextFieldPro(
            //   controller: onBordingProvider.referelCode,
            //   hintText: "ReferelCode",
            //   onChangee: (e) {
            //     onBordingProvider.updateNameFiled(
            //         controller: onBordingProvider.referelCode, value: e);
            //   },
            //   textalingn: TextAlign.start,
            // ),
            const SizBoxH(size: 0.018),
            TextFieldPro(
              controller: onBordingProvider.bio,
              // hintText: "Bio".tr,
              hintText: AppLocalizations.of(context)?.translate("Bio") ?? "Bio",
              maxline: 10,
              onChangee: (e) {
                onBordingProvider.updateNameFiled(
                    controller: onBordingProvider.bio, value: e);
              },
              textalingn: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  Widget step2() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Your GoMeet identity 😎".tr,
            AppLocalizations.of(context)?.translate("Your GoMeet identity 😎") ?? "Your GoMeet identity 😎",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Add your phone number and your job to tell others what you do for a living.".tr,
            AppLocalizations.of(context)?.translate("Add your phone number and your job to tell others what you do for a living.") ?? "Add your phone number and your job to tell others what you do for a living.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.02),
          IntlPhoneField(
            initialCountryCode: "IN",
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            showCountryFlag: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            disableLengthCheck: true,
            controller: onBordingProvider.mobileNumber,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            dropdownIcon: const Icon(
              Icons.arrow_drop_down,
            ),
            dropdownTextStyle: Theme.of(context).textTheme.bodyMedium,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                ,
            onCountryChanged: (value) {
              onBordingProvider.ccode =
                  onBordingProvider.updateVeriable(value.dialCode);
            },
            onChanged: (value) {
              onBordingProvider.updateNameFiled(
                  controller: onBordingProvider.mobileNumber,
                  value: value.number);
            },
            decoration: InputDecoration(
              helperText: null,
              // hintText: "Mobile Number".tr,
              hintText: AppLocalizations.of(context)?.translate("Mobile Number") ?? "Mobile Number",
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              focusedBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: AppColors.appColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).dividerTheme.color!,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // invalidNumberMessage: "Please enter your mobile number".tr,
            invalidNumberMessage: AppLocalizations.of(context)?.translate("Please enter your mobile number") ?? "Please enter your mobile number",
            // validator: (p0) {
            //   if (p0!.completeNumber.isEmpty) {
            //     return 'Please enter your number';
            //   } else {}
            //   return null;
            // },
          ),
        ],
      ),
    );
  }

  Widget step3() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Let's celebrate you 🎂".tr,
            AppLocalizations.of(context)?.translate("Let's celebrate you 🎂") ?? "Let's celebrate you 🎂",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Tell us your birthdate. Your profile does not display your birthdate, only your age.".tr,
            AppLocalizations.of(context)?.translate("Tell us your birthdate. Your profile does not display your birthdate, only your age.") ?? "Tell us your birthdate. Your profile does not display your birthdate, only your age.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizBoxH(size: 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (c) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime(2000, 1, 1),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  onBordingProvider.updatebdate(newDateTime);
                                },
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                              "${onBordingProvider.bdatePicker}" != "null"
                                  ? onBordingProvider.bdatePicker
                                      .toString()
                                      .split(" ")
                                      .first
                                  : "YYYY - MM - DD",
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget step4() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Be true to yourself 🌟".tr,
            AppLocalizations.of(context)?.translate("Be true to yourself 🌟") ?? "Be true to yourself 🌟",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Choose the gender that best represents you. Authenticity is key to meaningful connections.".tr,
            AppLocalizations.of(context)?.translate("Choose the gender that best represents you. Authenticity is key to meaningful connections.") ?? "Choose the gender that best represents you. Authenticity is key to meaningful connections.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (c, i) {
                return const SizBoxH(size: 0.012);
              },
              shrinkWrap: true,
              itemCount: onBordingProvider.manWoman.length,
              itemBuilder: (c, i) {
                return InkWell(
                  onTap: () {
                    onBordingProvider.updateMaleFemale(i);
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: onBordingProvider.select == i
                                ? AppColors.appColor
                                : Theme.of(context).dividerTheme.color!)),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          onBordingProvider.manWoman[i],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onBordingProvider.select == i
                            ? SvgPicture.asset("assets/icons/verify.svg")
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget step5() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // "Your relationship goals 💘".tr,
              AppLocalizations.of(context)?.translate("Your relationship goals 💘") ?? "Your relationship goals 💘",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizBoxH(size: 0.012),
            Text(
              // "Choose the type of relationship you're seeking on Datify. Love, friendship, or something in between—it's your choice.".tr,
              AppLocalizations.of(context)?.translate("Choose the type of relationship you're seeking on Datify. Love, friendship, or something in between—it's your choice.") ?? "Choose the type of relationship you're seeking on Datify. Love, friendship, or something in between—it's your choice.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizBoxH(size: 0.018),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (c, i) {
                  return const SizBoxH(size: 0.012);
                },
                shrinkWrap: true,
                itemCount:
                    onBordingProvider.relationGoalData?.goallist!.length ?? 0,
                itemBuilder: (c, i) {
                  Goallist? data =
                      onBordingProvider.relationGoalData?.goallist?[i];
                  return InkWell(
                    onTap: () {
                      onBordingProvider
                          .updaterelationGoal(int.parse(data.id.toString()));
                    },
                    child: Container(
                      // height: 55,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              color: onBordingProvider.relationGoal ==
                                      int.parse(data!.id.toString())
                                  ? AppColors.appColor
                                  : Theme.of(context).dividerTheme.color!)),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.title.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizBoxH(size: 0.01),
                          Text(
                            data.subtitle.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget step6() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Find matches nearby📍".tr,
            AppLocalizations.of(context)?.translate("Find matches nearby📍") ?? "Find matches nearby📍",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Select your preferred distance range to discover matches conveniently. We'll help you find love close by.".tr,
            AppLocalizations.of(context)?.translate("Select your preferred distance range to discover matches conveniently. We'll help you find love close by.") ?? "Select your preferred distance range to discover matches conveniently. We'll help you find love close by.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              // "Distance Preference".tr,
              AppLocalizations.of(context)?.translate("Distance Preference") ?? "Distance Preference",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
            Text(
              "${onBordingProvider.kmCounter.toStringAsFixed(2)} km",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.black),
            )
          ]),
          const SizBoxH(size: 0.02),
          SliderTheme(
            data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
              value: onBordingProvider.kmCounter,
              max: 500,
              min: 10,
              // divisions: 10,
              activeColor: AppColors.appColor,
              inactiveColor: Theme.of(context).dividerTheme.color!,
              label: onBordingProvider.kmCounter.abs().toString(),
              onChanged: (double value) {
                onBordingProvider.updatekm(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget step7() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Discover like-minded people 🤗".tr,
            AppLocalizations.of(context)?.translate("Discover like-minded people 🤗") ?? "Discover like-minded people 🤗",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.".tr,
            AppLocalizations.of(context)?.translate("Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.") ?? "Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          TextField(
            controller: onBordingProvider.hobieSearchContoller,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
            ,
            decoration: InputDecoration(
              // isDense: true,
              contentPadding: const EdgeInsets.all(10),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              // hintText: "Search.".tr,
              hintText: AppLocalizations.of(context)?.translate("Search.") ?? "Search.",
              hintStyle: Theme.of(context).textTheme.bodySmall,
              prefixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
                      child: SvgPicture.asset("assets/icons/Search.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),

              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),

              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),

              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appColor),
                  borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (c) {
              onBordingProvider.searchHobie(c);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          onBordingProvider.hobieSearchContoller.text.isEmpty
              ? Wrap(
                  spacing: 13,
                  runSpacing: 13,
                  children: [
                    for (int a = 0;
                        a <
                            onBordingProvider
                                .getInterestModel!.interestlist!.length;
                        a++)
                      Builder(builder: (context) {
                        Interestlist data = onBordingProvider
                            .getInterestModel!.interestlist![a];
                        return InkWell(
                          onTap: () {
                            if (onBordingProvider.selectHobi
                                    .contains(data.id) ==
                                true) {
                              onBordingProvider.removeHobi(data.id);
                            } else {
                              if (onBordingProvider.selectHobi.length < 5) {
                                onBordingProvider.addInHobi(data.id);
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: onBordingProvider.selectHobi
                                        .contains(data.id)
                                    ? AppColors.appColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: onBordingProvider.selectHobi
                                            .contains(data.id)
                                        ? Colors.transparent
                                        : Theme.of(context).dividerTheme.color!)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(data.title.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: onBordingProvider.selectHobi
                                                    .contains(data.id)
                                                ? AppColors.white
                                                : null)),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.network(
                                  "${Config.baseUrl}${data.img}",
                                  height: 24,
                                  width: 24,
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  ],
                )
              : onBordingProvider.searchForHobie.isEmpty
                  ? const SizedBox()
                  : Wrap(
                      spacing: 13,
                      runSpacing: 13,
                      children: [
                        for (int a = 0;
                            a < onBordingProvider.searchForHobie.length;
                            a++)
                          Builder(builder: (context) {
                            var result = onBordingProvider.searchForHobie[a];
                            Interestlist data = onBordingProvider
                                .getInterestModel!.interestlist![result];
                            return InkWell(
                              onTap: () {
                                if (onBordingProvider.selectHobi
                                        .contains(data.id) ==
                                    true) {
                                  onBordingProvider.removeHobi(data.id);
                                } else {
                                  if (onBordingProvider.selectHobi.length < 5) {
                                    onBordingProvider.addInHobi(data.id);
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: onBordingProvider.selectHobi
                                            .contains(data.id)
                                        ? AppColors.appColor
                                        : Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: onBordingProvider.selectHobi
                                                .contains(data.id)
                                            ? Colors.transparent
                                            : Theme.of(context).dividerTheme.color!)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(data.title.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: onBordingProvider
                                                        .selectHobi
                                                        .contains(data.id)
                                                    ? AppColors.white
                                                    : null)),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Image.network(
                                      "${Config.baseUrl}${data.img}",
                                      height: 24,
                                      width: 24,
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      ],
                    )
        ],
      ),
    );
  }

  Widget step8() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // "Do you know which languages? 🗺️".tr,
              AppLocalizations.of(context)?.translate("Do you know which languages? 🗺️") ?? "Do you know which languages? 🗺️",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizBoxH(size: 0.012),
            Text(
              // "Select your country of origin. We will verify your identity in the next step of your residence.".tr,
              AppLocalizations.of(context)?.translate("Select your country of origin. We will verify your identity in the next step of your residence.") ?? "Select your country of origin. We will verify your identity in the next step of your residence.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizBoxH(size: 0.018),
            TextField(
              controller: onBordingProvider.languageContoller,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  ,
              decoration: InputDecoration(
                // isDense: true,
                contentPadding: const EdgeInsets.all(10),
                // hintText: "Search.".tr,
                hintText: AppLocalizations.of(context)?.translate("Search.") ?? "Search.",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                filled: true,
                fillColor: Theme.of(context).cardColor,
                prefixIcon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                        child: SvgPicture.asset("assets/icons/Search.svg",colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appColor),
                    borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (c) {
                onBordingProvider.searchLanguage(c);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            onBordingProvider.languageContoller.text.isEmpty
                ? ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      Languagelist? data =
                          onBordingProvider.languageModel?.languagelist![i];
                      return InkWell(
                        onTap: () {
                          if (onBordingProvider.selectedLanguage
                                  .contains(data.id) ==
                              true) {
                            onBordingProvider.removelanguage(data.id);
                          } else {
                            onBordingProvider.addlanguage(data.id);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color: onBordingProvider.selectedLanguage
                                          .contains(data!.id)
                                      ? AppColors.appColor
                                      : Theme.of(context).dividerTheme.color!)),
                          child: Row(
                            children: [
                              Image.network(
                                "${Config.baseUrl}${data.img}",
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                data.title ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    ,
                              ),
                              const Spacer(),
                              onBordingProvider.selectedLanguage
                                      .contains(data.id)
                                  ? SvgPicture.asset(
                                      "assets/icons/Iconcheck.svg",
                                      height: 25,
                                      width: 25,
                                colorFilter: ColorFilter.mode( Theme.of(context).indicatorColor, BlendMode.srcIn),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (c, i) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemCount:
                        onBordingProvider.languageModel?.languagelist!.length ??
                            0)
                : onBordingProvider.searchForLanguage.isEmpty
                    ? const SizedBox()
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          var result = onBordingProvider.searchForLanguage[i];
                          Languagelist? data = onBordingProvider
                              .languageModel?.languagelist![result];
                          return InkWell(
                            onTap: () {
                              if (onBordingProvider.selectedLanguage
                                      .contains(data.id) ==
                                  true) {
                                onBordingProvider.removelanguage(data.id);
                              } else {
                                onBordingProvider.addlanguage(data.id);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: onBordingProvider.selectedLanguage
                                              .contains(data!.id)
                                          ? AppColors.appColor
                                          : Theme.of(context).dividerTheme.color!)),
                              child: Row(
                                children: [
                                  Image.network(
                                    "${Config.baseUrl}${data.img}",
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data.title ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        ,
                                  ),
                                  const Spacer(),
                                  onBordingProvider.selectedLanguage
                                          .contains(data.id)
                                      ? SvgPicture.asset(
                                          "assets/icons/Iconcheck.svg",
                                          height: 25,
                                          width: 25,
                                    colorFilter: ColorFilter.mode( Theme.of(context).indicatorColor, BlendMode.srcIn),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (c, i) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: onBordingProvider.searchForLanguage.length)
          ],
        ),
      ),
    );
  }

  Widget step9() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Discover religion 🤗".tr,
            AppLocalizations.of(context)?.translate("Discover religion 🤗") ?? "Discover religion 🤗",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.".tr,
            AppLocalizations.of(context)?.translate("Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.") ?? "Share your interests, passions, and hobbies. We'll connect you with people who share your enthusiasm.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          TextField(
            controller: onBordingProvider.religionSearchContoller,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                ,
            decoration: InputDecoration(
              // isDense: true,
              contentPadding: const EdgeInsets.all(10),
              // hintText: "Search.".tr,
              hintText: AppLocalizations.of(context)?.translate("Search.") ?? "Search.",
              hintStyle: Theme.of(context).textTheme.bodySmall,
              prefixIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
                      child: SvgPicture.asset("assets/icons/Search.svg", colorFilter: ColorFilter.mode( Theme.of(context).indicatorColor, BlendMode.srcIn),))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                  borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (c) {
              onBordingProvider.searchReligion(c);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          onBordingProvider.religionSearchContoller.text.isEmpty
              ? Wrap(
                  spacing: 13,
                  runSpacing: 13,
                  children: [
                    for (int a = 0;
                        a <
                            onBordingProvider
                                .religionModel!.religionlist!.length;
                        a++)
                      Builder(builder: (context) {
                        Religionlist data =
                            onBordingProvider.religionModel!.religionlist![a];
                        return InkWell(
                          onTap: () {
                            onBordingProvider
                                .updatereligion(int.parse(data.id.toString()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: onBordingProvider.selectReligion ==
                                        int.parse(data.id.toString())
                                    ? AppColors.appColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: onBordingProvider.selectReligion ==
                                            int.parse(data.id.toString())
                                        ? Colors.transparent
                                        : Theme.of(context).dividerTheme.color!)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(data.title.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: onBordingProvider
                                                        .selectReligion ==
                                                    int.parse(
                                                        data.id.toString())
                                                ? AppColors.white
                                                : null)),
                              ],
                            ),
                          ),
                        );
                      })
                  ],
                )
              : onBordingProvider.searchForReligion.isEmpty
                  ? const SizedBox()
                  : Wrap(
                      spacing: 13,
                      runSpacing: 13,
                      children: [
                        for (int a = 0;
                            a < onBordingProvider.searchForReligion.length;
                            a++)
                          Builder(builder: (context) {
                            var result = onBordingProvider.searchForReligion[a];
                            Religionlist data = onBordingProvider
                                .religionModel!.religionlist![result];
                            return InkWell(
                              onTap: () {
                                onBordingProvider.updatereligion(
                                    int.parse(data.id.toString()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    color: onBordingProvider.selectReligion ==
                                            int.parse(data.id.toString())
                                        ? AppColors.appColor
                                        : Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: onBordingProvider
                                                    .selectReligion ==
                                                int.parse(data.id.toString())
                                            ? Colors.transparent
                                            : Theme.of(context).dividerTheme.color!)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(data.title.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: onBordingProvider
                                                            .selectReligion ==
                                                        int.parse(
                                                            data.id.toString())
                                                    ? AppColors.white
                                                    : null)),
                                  ],
                                ),
                              ),
                            );
                          })
                      ],
                    )
        ],
      ),
    );
  }

  Widget step10() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Search Preference 🌟".tr,
            AppLocalizations.of(context)?.translate("Search Preference 🌟") ?? "Search Preference 🌟",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Choose the gender that best represents you. Authenticity is key to meaningful connections.".tr,
            AppLocalizations.of(context)?.translate("Choose the gender that best represents you. Authenticity is key to meaningful connections.") ?? "Choose the gender that best represents you. Authenticity is key to meaningful connections.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (c, i) {
                return const SizBoxH(size: 0.012);
              },
              shrinkWrap: true,
              itemCount: onBordingProvider.searchPref.length,
              itemBuilder: (c, i) {
                return InkWell(
                  onTap: () {
                    onBordingProvider.updateMaleFemale1(i);
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: onBordingProvider.select1 == i
                                ? AppColors.appColor
                                : Theme.of(context).dividerTheme.color!)),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          onBordingProvider.searchPref[i],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onBordingProvider.select1 == i
                            ? SvgPicture.asset("assets/icons/verify.svg")
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget step11() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Show your best self 📸".tr,
            AppLocalizations.of(context)?.translate("Show your best self 📸") ?? "Show your best self 📸",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizBoxH(size: 0.012),
          Text(
            // "Upload up to six of your best photos or video to make a fantastic first impression. Let your personality shine.".tr,
            AppLocalizations.of(context)?.translate("Upload up to six of your best photos or video to make a fantastic first impression. Let your personality shine.") ?? "Upload up to six of your best photos or video to make a fantastic first impression. Let your personality shine.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizBoxH(size: 0.018),
          Row(children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  onBordingProvider.pickupImage(0);
                  // if (images.isEmpty) {
                  //   final XFile? image =
                  //       await picker.pickImage(source: ImageSource.gallery);
                  //   images.add(image!);
                  //   setState(() {});
                  // }
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: onBordingProvider.images.isEmpty
                                  ? AppColors.appColor
                                  : Theme.of(context).dividerTheme.color!),
                          image: onBordingProvider.images.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(
                                    File(onBordingProvider.images.first.path
                                        .toString()),
                                  ),
                                  fit: BoxFit.cover)
                              : null,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20))),
                      child: onBordingProvider.images.isEmpty
                          ? Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: const Icon(Icons.add),
                              ),
                            )
                          : null,
                    ),
                    onBordingProvider.images.isEmpty
                        ? const SizedBox()
                        : Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                onBordingProvider.removeImages(0);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/times.svg",
                                    height: 20,
                                    width: 20,
                                    colorFilter:  ColorFilter.mode(
                                        Theme.of(context).indicatorColor, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () async {
                          onBordingProvider.pickupImage(1);
                          // if (images.length == 1) {
                          //   final XFile? image = await picker.pickImage(
                          //       source: ImageSource.gallery);

                          //   images.add(image!);

                          //   setState(() {});
                          // }
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: BoxDecoration(

                                border: Border.all(
                                    color: onBordingProvider.images.length == 1
                                        ? AppColors.appColor
                                        : Theme.of(context).dividerTheme.color!),
                                image: onBordingProvider.images.length >= 2
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(onBordingProvider.images[1].path
                                              .toString()),
                                        ),
                                        fit: BoxFit.cover)
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20))),
                            child: onBordingProvider.images.length == 1
                                ? Center(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                    ),
                                  )
                                : null),
                      ),
                      onBordingProvider.images.length >= 2
                          ? Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {
                                  onBordingProvider.removeImages(1);
                                },
                                child: Container(
                                  height: 23,
                                  width: 23,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).dividerTheme.color!,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/times.svg",
                                      height: 12,
                                      width: 12,
                                      colorFilter:  ColorFilter.mode(
                                          Theme.of(context).indicatorColor, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () async {
                          onBordingProvider.pickupImage(2);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: onBordingProvider.images.length == 2
                                    ? AppColors.appColor
                                    : Theme.of(context).dividerTheme.color!),
                            image: onBordingProvider.images.length >= 3
                                ? DecorationImage(
                                    image: FileImage(
                                      File(onBordingProvider.images[2].path
                                          .toString()),
                                    ),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                          child: onBordingProvider.images.length == 2
                              ? Center(
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      onBordingProvider.images.length >= 3
                          ? Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                onTap: () {
                                  onBordingProvider.removeImages(2);
                                },
                                child: Container(
                                  height: 23,
                                  width: 23,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/times.svg",
                                      height: 12,
                                      width: 12,
                                      colorFilter: ColorFilter.mode(
                                          Theme.of(context).indicatorColor, BlendMode.srcIn),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          ]),
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        onBordingProvider.pickupImage(3);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: onBordingProvider.images.length == 3
                                  ? AppColors.appColor
                                  : Theme.of(context).dividerTheme.color!),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20)),
                          image: onBordingProvider.images.length >= 4
                              ? DecorationImage(
                                  image: FileImage(
                                    File(onBordingProvider.images[3].path
                                        .toString()),
                                  ),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: onBordingProvider.images.length == 3
                            ? Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    onBordingProvider.images.length >= 4
                        ? Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                onBordingProvider.removeImages(3);
                              },
                              child: Container(
                                height: 23,
                                width: 23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/times.svg",
                                    height: 12,
                                    width: 12,
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).indicatorColor, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        onBordingProvider.pickupImage(4);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: onBordingProvider.images.length == 4
                                  ? AppColors.appColor
                                  : Theme.of(context).dividerTheme.color!),
                          image: onBordingProvider.images.length >= 5
                              ? DecorationImage(
                                  image: FileImage(
                                    File(onBordingProvider.images[4].path
                                        .toString()),
                                  ),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: onBordingProvider.images.length == 4
                            ? Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:Theme.of(context).cardColor,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    onBordingProvider.images.length >= 5
                        ? Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                onBordingProvider.removeImages(4);
                              },
                              child: Container(
                                height: 23,
                                width: 23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/times.svg",
                                    height: 12,
                                    width: 12,
                                    colorFilter:  ColorFilter.mode(
                                        Theme.of(context).indicatorColor, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () async {
                        onBordingProvider.pickupImage(5);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: onBordingProvider.images.length == 5
                                  ? AppColors.appColor
                                  : Theme.of(context).dividerTheme.color!),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                          image: onBordingProvider.images.length >= 6
                              ? DecorationImage(
                                  image: FileImage(
                                    File(onBordingProvider.images[5].path
                                        .toString()),
                                  ),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: onBordingProvider.images.length == 5
                            ? Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    onBordingProvider.images.length >= 6
                        ? Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                onBordingProvider.removeImages(5);
                              },
                              child: Container(
                                height: 23,
                                width: 23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/times.svg",
                                    height: 12,
                                    width: 12,
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).indicatorColor, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
