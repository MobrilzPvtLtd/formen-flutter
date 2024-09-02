import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:dating/Logic/cubits/Home_cubit/home_cubit.dart';
import 'package:dating/Logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:dating/Logic/cubits/editProfile_cubit/editprofile_cubit.dart';
import 'package:dating/Logic/cubits/language_cubit/language_bloc.dart';
import 'package:dating/Logic/cubits/match_cubit/match_cubit.dart';
import 'package:dating/Logic/cubits/onBording_cubit/onbording_cubit.dart';
import 'package:dating/Logic/cubits/litedark/lite_dark_cubit.dart';
import 'package:dating/core/config.dart';
import 'package:dating/core/routes.dart';
import 'package:dating/firebase_options.dart';
import 'package:dating/language/localization/app_localization_setup.dart';
import 'package:dating/presentation/firebase/auth_firebase.dart';
import 'package:dating/presentation/firebase/chatting_provider.dart';
import 'package:dating/presentation/firebase/pickup_callpage.dart';
import 'package:dating/presentation/firebase/vc_provider.dart';
import 'package:dating/presentation/screens/AudioCall/audiocall_provider.dart';
import 'package:dating/presentation/screens/BottomNavBar/chats.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/screens/BottomNavBar/match/matchprovider.dart';
import 'package:dating/presentation/screens/other/editProfile/editprofile_provider.dart';
import 'package:dating/presentation/screens/other/likeMatch/likematch_provider.dart';
import 'package:dating/presentation/screens/other/premium/premium_provider.dart';
import 'package:dating/presentation/screens/other/profileAbout/detailprovider.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_page.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_provider.dart';
import 'package:dating/presentation/screens/splash_bording/onBordingProvider/onbording_provider.dart';
import 'package:dating/presentation/screens/splash_bording/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'Logic/cubits/litedark/lite_dark_state.dart';
import 'Logic/cubits/premium_cubit/premium_bloc.dart';


Future<void> main() async {

  log(Config.baseUrlApi+Config.getInterestList);
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  await Firebase.initializeApp(
    name: "For-Men",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {

    if(event.data["vcId"] != null) {

      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => PickUpCall(userData: event.data,isAudio: false,)));

    }else if(event.data["Audio"] != null){

      navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => PickUpCall(userData: event.data,isAudio: true,)));

    }

  });
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose);
  runApp(const MyApp());
  initializeNotifications();
  listenFCM();
  loadFCM();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => OnbordingCubit()),
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => EditProfileCubit()),
        BlocProvider(create: (context) => MatchCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => PremiumBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
             builder: (context, theme) {
      return BlocBuilder<LanguageCubit,LanguageState>(
             buildWhen: (previous, current) => previous != current,
             builder: (context, languageState){
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => OnBordingProvider()),
                ChangeNotifierProvider(create: (context) => DetailProvider()),
                ChangeNotifierProvider(create: (context) => HomeProvider()),
                ChangeNotifierProvider(create: (context) => ProfileProvider()),
                ChangeNotifierProvider(create: (context) => EditProfileProvider()),
                ChangeNotifierProvider(create: (context) => MatchProvider()),
                ChangeNotifierProvider(create: (context) => LikeMatchProvider()),
                ChangeNotifierProvider(create: (context) => FirebaseAuthService()),
                ChangeNotifierProvider(create: (context) => ChattingProvider()),
                ChangeNotifierProvider(create: (context) => VcProvider()),
                ChangeNotifierProvider(create: (context) => AudioCallProvider()),
                ChangeNotifierProvider(create: (context) => PremiumProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: SplashScreen.splashScreenRoute,
                theme: theme.themeData,
                navigatorKey: navigatorKey,
                onGenerateRoute: Routes.onGenerateRoute,
                supportedLocales: AppLocalizationSetup.supportedLanguage,
                localizationsDelegates: AppLocalizationSetup.localizationsDelegates,
                localeResolutionCallback: AppLocalizationSetup.localeResolutionCallback,
                locale: languageState.locale,
              )
            );
          }
        );
      }),
    );
  }
}


Future<void>  _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
}


// class AppTranslationsapp extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//     'en_US': {
//       'enter_mail': 'Enter your email',
//     },
//     'ur_PK': {
//       'enter_mail': 'اپنا ای میل درج کریں۔',
//     }
//   };
// }

