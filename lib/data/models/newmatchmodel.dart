// To parse this JSON data, do
//
//     final newMatchModel = newMatchModelFromJson(jsonString);

import 'dart:convert';

NewMatchModel newMatchModelFromJson(String str) => NewMatchModel.fromJson(json.decode(str));

String newMatchModelToJson(NewMatchModel data) => json.encode(data.toJson());

class NewMatchModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Profilelist>? profilelist;

  NewMatchModel({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.profilelist,
  });

  factory NewMatchModel.fromJson(Map<String, dynamic> json) => NewMatchModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    profilelist: json["profilelist"] == null ? [] : List<Profilelist>.from(json["profilelist"]!.map((x) => Profilelist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "profilelist": profilelist == null ? [] : List<dynamic>.from(profilelist!.map((x) => x.toJson())),
  };
}

class Profilelist {
  String? profileId;
  String? profileName;
  String? profileBio;
  int? profileAge;
  String? profileDistance;
  List<String>? profileImages;
  double? matchRatio;

  Profilelist({
    this.profileId,
    this.profileName,
    this.profileBio,
    this.profileAge,
    this.profileDistance,
    this.profileImages,
    this.matchRatio,
  });

  factory Profilelist.fromJson(Map<String, dynamic> json) => Profilelist(
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
