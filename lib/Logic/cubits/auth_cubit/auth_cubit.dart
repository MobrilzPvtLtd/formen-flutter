import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dating/Logic/cubits/auth_cubit/auth_state.dart';
import 'package:dating/core/api.dart';
import 'package:dating/core/config.dart';
import 'package:dating/presentation/firebase/auth_firebase.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../data/localdatabase.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());
  final Api _api = Api();

  Future<void> signInWithGoogle(context) async {
    try {
      emit(AuthLoading());

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        checkUserisValide(user: userCredential.user!,context: context);
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> signInWithFacebook(context) async {
    try {
      emit(AuthLoading());

      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      if (userCredential.user != null) {
        checkUserisValide(user: userCredential.user!,context: context);
        // emit(AuthLoggedInState(userCredential.user!));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> signInWithTwitter() async {
    try {
      emit(AuthLoading());


    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future checkUserisValide({required User user,required context}) async {
    try {
      Map body = {"email": user.email};

      Response response = await _api.sendRequest
          .post("${Config.baseUrlApi}${Config.socialLogin}", data: body);

      if (response.statusCode == 200 && response.data["Result"] == "true") {
        emit(AuthUserHomeState(response.data.toString()));
        Preferences.saveUserDetails(response.data);
        Provider.of<FirebaseAuthService>(context,listen: false).singInAndStoreData(email: response.data["UserLogin"]["email"], uid: response.data["UserLogin"]["id"],number: response.data["UserLogin"]["mobile"],name: response.data["UserLogin"]["name"], proPicPath: response.data["UserLogin"]["other_pic"].toString().split("\$;").first);
      } else if (response.data["ResponseCode"] == "201") {
        emit(AuthLoggedInState(user));
      } else {
        await GoogleSignIn().signOut();
        await FacebookAuth.instance.logOut();
        emit(AuthErrorState(response.data["ResponseMsg"]));
      }
    } catch (e) {
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      emit(AuthErrorState(e.toString()));
      rethrow;
    }
  }

  void signOut() async {
    await Preferences.clear();
    emit(AuthLogOut());
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future signInWithApple(context) async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(oauthCredential);

    if (userCredential.user != null) {
      emit(AuthLoggedInState(userCredential.user!));
    }
  }

}
