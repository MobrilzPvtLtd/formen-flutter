import 'package:dating/data/models/homemodel.dart';

class HomePageStates {}

class HomeInitState extends HomePageStates {}

class HomeLoadingState extends HomePageStates {}

class HomeErrorState extends HomePageStates {
  String error;
  HomeErrorState(this.error);
}

class HomeCompleteState extends HomePageStates {
  HomeModel homeData;
  HomeCompleteState(this.homeData);
}
