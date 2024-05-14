import 'dart:io';

import 'package:dating/Logic/cubits/onBording_cubit/onbording_cubit.dart';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_state.dart';
import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/splash_bording/creat_steps.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:dating/presentation/widgets/textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../../Logic/cubits/auth_cubit/auth_cubit.dart';
import '../../../Logic/cubits/auth_cubit/auth_state.dart';
import '../../../core/ui.dart';
import '../../../language/localization/app_localization.dart';
import '../../widgets/loginwith_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String loginRoute = "/loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late OnBordingProvider onBordingProvider;
  @override
  void initState() {
    super.initState();
    onBordingProvider = Provider.of<OnBordingProvider>(context,listen: false);
    onBordingProvider.mobileNumber.text = '';
  }
  @override
  Widget build(BuildContext context) {
    onBordingProvider = Provider.of<OnBordingProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BackButtons(),
                      ],
                    ),
                    const SizBoxH(size: 0.04),
                    Text(
                      // "Sign in".tr,
                      AppLocalizations.of(context)?.translate("Sign in") ?? "Sign in",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizBoxH(size: 0.01),
                    Text(
                      // "Welcome back! Please enter your details.".tr,
                      AppLocalizations.of(context)?.translate("Welcome back! Please enter your details.") ?? "Welcome back! Please enter your details.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizBoxH(size: 0.04),
                    TextFieldPro(
                        textalingn: TextAlign.start,
                        prefixIconIconPath: "assets/icons/envelope.svg",
                        controller: onBordingProvider.emailLogin,
                        // hintText: "Email or MobileNumber".tr
                        hintText: AppLocalizations.of(context)?.translate("Email or MobileNumber") ?? "Email or MobileNumber"
                    ),
                    const SizBoxH(size: 0.02),
                    TextFieldPro(
                        surfixOntap: () {
                          onBordingProvider.updatebloginPass();
                        },
                        obscureText: onBordingProvider.loginpassObs,
                        textalingn: TextAlign.start,
                        prefixIconIconPath: "assets/icons/unlock.svg",
                        suffixIconPath: onBordingProvider.loginpassObs
                            ? "assets/icons/eye-slash.svg"
                            : "assets/icons/eye.svg",
                        controller: onBordingProvider.passwordLogin,
                        // hintText: "Password".tr
                        hintText: AppLocalizations.of(context)?.translate("Password") ?? "Password"
                    ),
                    const SizBoxH(size: 0.02),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          // text: "Forgot password? ".tr,
                          text: AppLocalizations.of(context)?.translate("Forgot password? ") ?? "Forgot password? ",
                          style: Theme.of(context).textTheme.bodySmall!),
                      TextSpan(
                          // text: "Reset it".tr,
                          text: AppLocalizations.of(context)?.translate("Reset it") ?? "Reset it",
                          recognizer: TapGestureRecognizer()..onTap = () {
                              showModalBottomSheet(
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
                                        Text(
                                          // "Enter Number".tr,
                                          AppLocalizations.of(context)?.translate("Enter Number") ?? "Enter Number",
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10,),
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
                                          style: Theme.of(context).textTheme.bodyMedium!,
                                          onCountryChanged: (value) {
                                            onBordingProvider.ccode = onBordingProvider.updateVeriable(value.dialCode);
                                          },
                                          onChanged: (value) {
                                            onBordingProvider.updateNameFiled(controller: onBordingProvider.mobileNumber, value: value.number);

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
                                        const SizedBox(height: 10,),
                                         Row(
                                          children: [
                                         // Expanded(child: MainButton(title: "Continue".tr,onTap: () {
                                         Expanded(child: MainButton(title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue",onTap: () {


                                           if(onBordingProvider.mobileNumber.text.isEmpty){
                                             Fluttertoast.showToast(msg: "Please Enter Your Mobile Number");
                                           }else{
                                             BlocProvider.of<OnbordingCubit>(context).mobileCheckApi(number: onBordingProvider.mobileNumber.text, ccode: onBordingProvider.ccode).then((value) {
                                               if (value == "false") {
                                                 BlocProvider.of<OnbordingCubit>(context).sendOtpFunction(number: "+${onBordingProvider.ccode} ${onBordingProvider.mobileNumber.text}", context: context,isForgot: true);
                                               }else{
                                                 Navigator.pop(context);
                                                 // Fluttertoast.showToast(msg: "Number Not Exist".tr);
                                                 Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Number Not Exist") ?? "Number Not Exist");
                                               }
                                             });
                                           }





                                         },))

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },);
                            },
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.appColor)),
                    ])),
                    const SizBoxH(size: 0.04),
                    MainButton(
                      // title: "Sign In".tr,
                      title: AppLocalizations.of(context)?.translate("Sign In") ?? "Sign In",
                      titleColor: Colors.white,
                      bgColor: AppColors.appColor,
                      onTap: () {

                        if(onBordingProvider.emailLogin.text.isEmpty || onBordingProvider.passwordLogin.text.isEmpty){
                          Fluttertoast.showToast(msg: "Please Enter All Input");
                        }else {
                          BlocProvider.of<OnbordingCubit>(context).loginWithEmailPass(context: context, mobile: onBordingProvider.emailLogin.text, password: onBordingProvider.passwordLogin.text, ccode: "+91");
                        }

                        },
                    ),
                    const SizBoxH(size: 0.04),
                    LoginWithButton(
                        bgColor: Colors.transparent,
                        // title: "Connect with Google".tr,
                        title: AppLocalizations.of(context)?.translate("Connect with Google") ?? "Connect with Google",
                        iconpath: "assets/icons/google.svg",textColor: Theme.of(context).indicatorColor,
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context)
                              .signInWithGoogle(context);
                        }),
                    const SizBoxH(size: 0.018),
                    LoginWithButton(
                      bgColor: Colors.transparent,
                      // title: "Connect with Facebook".tr,
                      title: AppLocalizations.of(context)?.translate("Connect with Facebook") ?? "Connect with Facebook",
                      iconpath: "assets/icons/facebook.svg",
                        textColor: Theme.of(context).indicatorColor,
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context)
                            .signInWithFacebook(context);
                      },
                    ),
                    // Platform.isIOS? const SizBoxH(size: 0.018) : const SizedBox(),
                    // Platform.isIOS? LoginWithButton(
                    //   bgColor: Colors.transparent,
                    //   // title: "Connect with Apple".tr,
                    //   title: AppLocalizations.of(context)?.translate("Connect with Apple") ?? "Connect with Apple",
                    //   iconpath: "assets/icons/applelogo.svg",
                    //   textColor: Theme.of(context).indicatorColor,
                    //   onTap: () {
                    //     BlocProvider.of<AuthCubit>(context).signInWithApple(context);
                    //   },
                    // ) : const SizedBox(),
                    const SizBoxH(size: 0.018),
                    LoginWithButton(
                      bgColor: Colors.transparent,
                      // title: "Connect with Apple".tr,
                      title: AppLocalizations.of(context)?.translate("Connect with Apple") ?? "Connect with Apple",
                      iconpath: "assets/icons/applelogo.svg",
                      textColor: Theme.of(context).indicatorColor,
                      onTap: () {
                        BlocProvider.of<AuthCubit>(context).signInWithApple(context);
                      },
                    ) ,
                  ],
                ),
              ),
            ),
            BlocConsumer<OnbordingCubit, OnbordingState>(
                listener: (context, state) {
              if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
              }
              if (state is CompletSteps) {
                // Navigator.pushNamed(context, BottomBar.bottomBarRoute);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
              }
            }, builder: (context, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator(color: AppColors.appColor));
              } else {
                return const SizedBox();
              }
            }),
            BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {

              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }

              if (state is AuthLoggedInState) {
                Navigator.pushNamed(context, CreatSteps.creatStepsRoute);
                onBordingProvider.setDataInFildes(state.firebaseuser);
              }

              if (state is AuthUserHomeState) {
                Navigator.pushNamedAndRemoveUntil(context, BottomBar.bottomBarRoute,(route) => false,);
              }

              },
              builder: (context, state) {

              if(state is AuthLoading) {

                return Center(child: CircularProgressIndicator(color: AppColors.appColor));

              } else {

                return const SizedBox();

              }
            })
          ],
        ),
      ),
    );
  }
}
