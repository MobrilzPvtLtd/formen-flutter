import 'package:firebase_auth/firebase_auth.dart';

class AuthStates {}

class AuthInitState extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthLogOut extends AuthStates {}

class AuthLoggedInState extends AuthStates {
  final User firebaseuser;
  AuthLoggedInState(this.firebaseuser);
}

class AuthUserHomeState extends AuthStates {
  String userLoginData;
  AuthUserHomeState(this.userLoginData);
}

class AuthErrorState extends AuthStates {
  String errorMessage;
  AuthErrorState(this.errorMessage);
}
