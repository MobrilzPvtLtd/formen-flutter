// To parse this JSON data, do
//
//     final favlistModel = favlistModelFromJson(jsonString);

import 'dart:convert';

FavlistModel favlistModelFromJson(String str) => FavlistModel.fromJson(json.decode(str));

String favlistModelToJson(FavlistModel data) => json.encode(data.toJson());

class FavlistModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Favlist>? favlist;

  FavlistModel({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.favlist,
  });

  factory FavlistModel.fromJson(Map<String, dynamic> json) => FavlistModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    favlist: json["favlist"] == null ? [] : List<Favlist>.from(json["favlist"]!.map((x) => Favlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "favlist": favlist == null ? [] : List<dynamic>.from(favlist!.map((x) => x.toJson())),
  };
}

class Favlist {
  String? profileId;
  String? profileName;
  String? profileBio;
  int? profileAge;
  String? profileDistance;
  List<String>? profileImages;
  double? matchRatio;

  Favlist({
    this.profileId,
    this.profileName,
    this.profileBio,
    this.profileAge,
    this.profileDistance,
    this.profileImages,
    this.matchRatio,
  });

  factory Favlist.fromJson(Map<String, dynamic> json) => Favlist(
    profileId: json["profile_id"],
    profileName: json["profile_name"],
    profileBio: json["profile_bio"],
    profileAge: json["profile_age"],
    profileDistance: json["profile_distance"],
    profileImages: json["profile_images"] == null ? [] : List<String>.from(json["profile_images"]!.map((x) => x)),
    matchRatio: json["match_ratio"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "profile_name": profileName,
    "profile_bio": profileBio,
    "profile_age": profileAge,
    "profile_distance": profileDistance,
    "profile_images": profileImages == null ? [] : List<dynamic>.from(profileImages!.map((x) => x)),
    "match_ratio": matchRatio,
  };
}
