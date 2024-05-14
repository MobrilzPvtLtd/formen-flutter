// To parse this JSON data, do
//
//     final mapModel = mapModelFromJson(jsonString);

import 'dart:convert';

MapModel mapModelFromJson(String str) => MapModel.fromJson(json.decode(str));

String mapModelToJson(MapModel data) => json.encode(data.toJson());

class MapModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Profilelist>? profilelist;

  MapModel({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.profilelist,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
        profilelist: json["profilelist"] == null
            ? []
            : List<Profilelist>.from(
                json["profilelist"]!.map((x) => Profilelist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
        "profilelist": profilelist == null
            ? []
            : List<dynamic>.from(profilelist!.map((x) => x.toJson())),
      };
}

class Profilelist {
  String? profileId;
  String? profileName;
  String? profileBio;
  int? profileAge;
  String? profileLat;
  String? profileLongs;
  String? profileDistance;
  List<String>? profileImages;
  num? matchRatio;

  Profilelist({
    this.profileId,
    this.profileName,
    this.profileBio,
    this.profileAge,
    this.profileLat,
    this.profileLongs,
    this.profileDistance,
    this.profileImages,
    this.matchRatio,
  });

  factory Profilelist.fromJson(Map<String, dynamic> json) => Profilelist(
        profileId: json["profile_id"],
        profileName: json["profile_name"],
        profileBio: json["profile_bio"],
        profileAge: json["profile_age"],
        profileLat: json["profile_lat"],
        profileLongs: json["profile_longs"],
        profileDistance: json["profile_distance"],
        profileImages: json["profile_images"] == null
            ? []
            : List<String>.from(json["profile_images"]!.map((x) => x)),
        matchRatio: json["match_ratio"],
      );

  Map<String, dynamic> toJson() => {
        "profile_id": profileId,
        "profile_name": profileName,
        "profile_bio": profileBio,
        "profile_age": profileAge,
        "profile_lat": profileLat,
        "profile_longs": profileLongs,
        "profile_distance": profileDistance,
        "profile_images": profileImages == null
            ? []
            : List<dynamic>.from(profileImages!.map((x) => x)),
        "match_ratio": matchRatio,
      };
}
