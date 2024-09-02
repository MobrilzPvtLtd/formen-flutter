import 'dart:async';
import 'package:dating/Logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:dating/Logic/cubits/auth_cubit/auth_state.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/splash_bording/creat_steps.dart';
import 'package:dating/presentation/screens/auth/login_screen.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/widgets/loginwith_button.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../language/localization/app_localization.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String authScreenRoute = "/authScreen";
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late OnBordingProvider onBordingProvider;
  @override
  void initState() {
    super.initState();
    setOnbordingFalse();
  }

  setOnbordingFalse() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("Onbording", false);
  }
  @override
  Widget build(BuildContext context) {
    onBordingProvider = Provider.of<OnBordingProvider>(context);
    return Scaffold(
      body: Stack(
        children: [

          const ImageSlider(
            imageUrls: [
            //   'https://images.pexels.com/photos/16355930/pexels-photo-16355930/free-photo-of-woman-with-a-bunch-of-red-roses-and-a-man-walking-holding-hands.jpeg',
            //   'https://images.pexels.com/photos/16355931/pexels-photo-16355931/free-photo-of-woman-with-a-bunch-of-red-roses-and-a-man-walking-holding-hands.jpeg',
            //   'https://images.pexels.com/photos/16355932/pexels-photo-16355932/free-photo-of-woman-with-a-bunch-of-red-roses-and-a-man-walking-holding-hands.jpeg',
             "assets/Image/mainHomeBackground.jpg",
             "assets/Image/mainMembrosBackground.jpg"
             
             ],
          ),

          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.1, 1, 1.3],
                  colors: [
                    Colors.white10, 
                    AppColors.appColor.withOpacity(0.3),
                    AppColors.appColor,
                  ],
                ),
              ),
            ),
          ),
          // SvgPicture.asset(
          //   "assets/Image/Blur.svg",
          //   fit: BoxFit.cover,
          //   colorFilter: ColorFilter.mode(AppColors.appColor.withOpacity(0.5), BlendMode.srcIn),
          // ),

          Stack(
            children: [

              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizBoxH(size: 0.02),
                        
                        const Spacer(flex: 6),
                        // Text("Let's dive in into your account!".tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.appColor),),
                        Text(AppLocalizations.of(context)?.translate("Let's dive in into your account!") ?? "Let's dive in into your account!",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),),


                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     ElevatedButton(
                        //       onPressed: () => themeBloc.add(ThemeEvent.toggleDark),
                        //       child: const Text('Dark'),
                        //     ),
                        //     const SizedBox(width: 10),
                        //     ElevatedButton(
                        //       onPressed: () =>
                        //           themeBloc.add(ThemeEvent.toggleLight),
                        //       child: const Text('Light'),
                        //     ),
                        //   ],
                        // ),

                        // const Spacer(flex: 4),
                        const SizedBox(height: 10,),
                        LoginWithButton(
                            bgColor: Colors.white,
                            // title: "Connect with Google".tr,
                            title: AppLocalizations.of(context)?.translate("Connect with Google") ?? "Connect with Google",
                            iconpath: "assets/icons/google.svg",
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context).signInWithGoogle(context);
                            }),

                        const SizBoxH(size: 0.018),
                        LoginWithButton(
                          bgColor: Colors.white,
                          // title: "Connect with Facebook".tr,
                          title: AppLocalizations.of(context)?.translate("Connect with Facebook") ?? "Connect with Facebook",
                          iconpath: "assets/icons/facebook.svg",
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context).signInWithFacebook(context);
                          },
                        ),
                        // Platform.isIOS? const SizBoxH(size: 0.018) : SizedBox(),
                        // Platform.isIOS? LoginWithButton(
                        //   bgColor: Colors.white,
                        //   // title: "Connect with Apple".tr,
                        //   title: AppLocalizations.of(context)?.translate("Connect with Apple") ?? "Connect with Apple",
                        //   iconpath: "assets/icons/applelogo.svg",
                        //   onTap: () {
                        //     BlocProvider.of<AuthCubit>(context).signInWithApple(context);
                        //   },
                        // ) : const SizedBox(),
                        const SizBoxH(size: 0.018),
                        LoginWithButton(
                          bgColor: Colors.white,
                          // title: "Connect with Apple".tr,
                          title: AppLocalizations.of(context)?.translate("Connect with Apple") ?? "Connect with Apple",
                          iconpath: "assets/icons/applelogo.svg",
                          onTap: () {
                            BlocProvider.of<AuthCubit>(context).signInWithApple(context);
                          },
                        ),


                        const SizBoxH(size: 0.018),
                        Row(
                          children: [
                          // Expanded(child: MainButton(title: "Continue with Email/Mobile Number".tr,onTap: () {
                          Expanded(child: MainButton(title: AppLocalizations.of(context)?.translate("Continue with Email/Mobile Number") ?? "Continue with Email/Mobile Number",onTap: () {
                           Navigator.pushNamed(context, CreatSteps.creatStepsRoute);
                          },)),
                        ],),
                        const Spacer(),

                        // const SizBoxH(size: 0.018),
                        // LoginWithButton(
                        //   title: "Connect with Twitter",
                        //   iconpath: "assets/icons/twitter.svg",
                        //   onTap: () {
                        //     BlocProvider.of<AuthCubit>(context)
                        //         .signInWithTwitter();
                        //   },
                        // ),


                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              // text: "I have an account? ".tr,
                              text: AppLocalizations.of(context)?.translate("I have an account? ") ?? "I have an account? ",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white)),
                          TextSpan(
                              text: "Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, LoginScreen.loginRoute);
                                },
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white,fontWeight: FontWeight.bold)),
                        ])),

                        // InkWell(
                        //   onTap: () {
                        //     Navigator.of(context)
                        //         .pushNamed(RecoverEmail.recoverEmailRoute);
                        //   },
                        //   child: Text(
                        //     "Connection problems?",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .bodySmall!
                        //         .copyWith(fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        const SizedBox(height: 10,),

                      ])),

              BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, state)  {

                if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                }

                if (state is AuthLoggedInState) {
                  Navigator.pushNamed(context, CreatSteps.creatStepsRoute);
                  onBordingProvider.setDataInFildes(state.firebaseuser);
                }

                if (state is AuthUserHomeState) {
                  Navigator.pushNamedAndRemoveUntil(context, BottomBar.bottomBarRoute, (route) => false);
                }

              }, builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator(color: AppColors.appColor));
                } else {
                  return const SizedBox();
                }
              })

            ],
          ),

        ],
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ImageSlider({super.key, required this.imageUrls});

  @override
  ImageSliderState createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider> {
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % widget.imageUrls.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedSwitcher(
      duration: const Duration(seconds: 5),

      child: Image.asset(
        widget.imageUrls[_currentPage],
        key: ValueKey<int>(_currentPage),
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),

      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },

    );
  }
}
