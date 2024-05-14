// To parse this JSON data, do
//
//     final passedModel = passedModelFromJson(jsonString);

import 'dart:convert';

PassedModel passedModelFromJson(String str) => PassedModel.fromJson(json.decode(str));

String passedModelToJson(PassedModel data) => json.encode(data.toJson());

class PassedModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Passedlist>? passedlist;

  PassedModel({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.passedlist,
  });

  factory PassedModel.fromJson(Map<String, dynamic> json) => PassedModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    passedlist: json["passedlist"] == null ? [] : List<Passedlist>.from(json["passedlist"]!.map((x) => Passedlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "passedlist": passedlist == null ? [] : List<dynamic>.from(passedlist!.map((x) => x.toJson())),
  };
}

class Passedlist {
  String? profileId;
  String? profileName;
  String? profileBio;
  int? profileAge;
  String? profileDistance;
  List<String>? profileImages;
  double? matchRatio;

  Passedlist({
    this.profileId,
    this.profileName,
    this.profileBio,
    this.profileAge,
    this.profileDistance,
    this.profileImages,
    this.matchRatio,
  });

  factory Passedlist.fromJson(Map<String, dynamic> json) => Passedlist(
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
