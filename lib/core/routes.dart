import 'package:dating/presentation/screens/BottomNavBar/bottombar.dart';
import 'package:dating/presentation/screens/BottomNavBar/match/browes.dart';
import 'package:dating/presentation/screens/BottomNavBar/mapscreen.dart';
import 'package:dating/presentation/screens/BottomNavBar/notification_page.dart';
import 'package:dating/presentation/screens/Splash_Bording/auth_screen.dart';
import 'package:dating/presentation/screens/other/editProfile/editprofile.dart';
import 'package:dating/presentation/screens/other/likeMatch/like_match.dart';
import 'package:dating/presentation/screens/other/premium/plandetials.dart';
import 'package:dating/presentation/screens/other/premium/premium.dart';
import 'package:dating/presentation/screens/other/profileAbout/detailscreen.dart';
import 'package:dating/presentation/screens/other/profileScreen/faqpage.dart';
import 'package:dating/presentation/screens/other/profileScreen/profile_page.dart';
import 'package:dating/presentation/screens/splash_bording/creat_steps.dart';
import 'package:dating/presentation/screens/auth/login_screen.dart';
import 'package:dating/presentation/screens/splash_bording/onbording_screens.dart';
import 'package:dating/presentation/screens/splash_bording/recover_email.dart';
import 'package:dating/presentation/screens/splash_bording/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import '../presentation/screens/BottomNavBar/home_screen.dart';


class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.splashScreenRoute:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
        case OnBoardingScreen.onBoardingScreenRoute:
        return CupertinoPageRoute(builder: (context) => const OnBoardingScreen());

      case AuthScreen.authScreenRoute:
        return CupertinoPageRoute(builder: (context) => const AuthScreen());

      case RecoverEmail.recoverEmailRoute:
        return CupertinoPageRoute(builder: (context) => const RecoverEmail());

      case CreatSteps.creatStepsRoute:
        return CupertinoPageRoute(builder: (context) => const CreatSteps());

      case BottomBar.bottomBarRoute:
        return CupertinoPageRoute(builder: (context) => const BottomBar());

      case HomeScreen.homeScrennRoute:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());

      case BrowesPage.browsPageRoute:
        return CupertinoPageRoute(builder: (context) => const BrowesPage());

      case MapScreen.mapScreenRoute:
        return CupertinoPageRoute(builder: (context) => const MapScreen());

      case ProfilePage.profilePageRoute:
        return CupertinoPageRoute(builder: (context) => const ProfilePage());

      case PremiumScreen.premiumScreenRoute:
        return CupertinoPageRoute(builder: (context) => const PremiumScreen());

      case EditProfile.editProfileRoute:
        return CupertinoPageRoute(builder: (context) => const EditProfile());

      case DetailScreen.detailScreenRoute:
        return CupertinoPageRoute(builder: (context) => const DetailScreen());

      case LoginScreen.loginRoute:
        return CupertinoPageRoute(builder: (context) => const LoginScreen());

        case NotificationPage.notificationRoute:
        return CupertinoPageRoute(builder: (context) => const NotificationPage());

        case LikeMatchScreen.likeMatchScreenRoute:
          return CupertinoPageRoute(builder: (context) => const LikeMatchScreen());
          case FaqPage.faqRoute:
          return CupertinoPageRoute(builder: (context) => const FaqPage());
          case PlanDetils.planRoutes:
          return CupertinoPageRoute(builder: (context) => const PlanDetils());

      default:
        return null;
    }
  }
}
