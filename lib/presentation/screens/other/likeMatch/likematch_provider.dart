import 'package:dating/core/api.dart';
import 'package:dating/core/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LikeMatchProvider extends ChangeNotifier {
  List likeMatchData = [];

  bool isHome = false;

  updateIsHome(bool value) {
    isHome = value;
    notifyListeners();
  }

  updateList(value) {
    likeMatchData = value;
    notifyListeners();
  }

  int interIndex = 0;

  upDateinnerindex(int value) {
    interIndex = value;
    notifyListeners();
  }

  final Api _api = Api();

  Future profileViewApi(
      {required String uid, required String profileId}) async {
    Map data = {"uid": uid, "profile_id": profileId};
    try {
      Response response = await _api.sendRequest
          .post("${Config.baseUrlApi}${Config.profileView}", data: data);
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }
}
