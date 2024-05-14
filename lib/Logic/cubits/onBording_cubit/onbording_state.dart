class OnbordingState {}

class InitState extends OnbordingState {}

class LoadingState extends OnbordingState {}

class CompletSteps extends OnbordingState {

}

class otpComplete extends OnbordingState {}

class ErrorState extends OnbordingState {
  String error;
  ErrorState(this.error);
}
