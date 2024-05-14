// To parse this JSON data, do
//
//     final likeMeModel = likeMeModelFromJson(jsonString);

import 'dart:convert';

LikeMeModel likeMeModelFromJson(String str) => LikeMeModel.fromJson(json.decode(str));

String likeMeModelToJson(LikeMeModel data) => json.encode(data.toJson());

class LikeMeModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Likemelist>? likemelist;

  LikeMeModel({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.likemelist,
  });

  factory LikeMeModel.fromJson(Map<String, dynamic> json) => LikeMeModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    likemelist: json["likemelist"] == null ? [] : List<Likemelist>.from(json["likemelist"]!.map((x) => Likemelist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "likemelist": likemelist == null ? [] : List<dynamic>.from(likemelist!.map((x) => x.toJson())),
  };
}

class Likemelist {
  String? profileId;
  String? profileName;
  String? profileBio;
  int? profileAge;
  String? profileDistance;
  List<String>? profileImages;
  double? matchRatio;

  Likemelist({
    this.profileId,
    this.profileName,
    this.profileBio,
    this.profileAge,
    this.profileDistance,
    this.profileImages,
    this.matchRatio,
  });

  factory Likemelist.fromJson(Map<String, dynamic> json) => Likemelist(
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
