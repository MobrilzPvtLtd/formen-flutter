// To parse this JSON data, do
//
//     final blocklistApi = blocklistApiFromJson(jsonString);

import 'dart:convert';

BlocklistApi blocklistApiFromJson(String str) => BlocklistApi.fromJson(json.decode(str));

String blocklistApiToJson(BlocklistApi data) => json.encode(data.toJson());

class BlocklistApi {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Blocklist>? blocklist;

  BlocklistApi({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.blocklist,
  });

  factory BlocklistApi.fromJson(Map<String, dynamic> json) => BlocklistApi(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    blocklist: json["blocklist"] == null ? [] : List<Blocklist>.from(json["blocklist"]!.map((x) => Blocklist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "blocklist": blocklist == null ? [] : List<dynamic>.from(blocklist!.map((x) => x.toJson())),
  };
}

class Blocklist {
  String? profileId;
  String? profileName;
  String? profileBio;
  int? profileAge;
  String? profileDistance;
  List<String>? profileImages;
  double? matchRatio;

  Blocklist({
    this.profileId,
    this.profileName,
    this.profileBio,
    this.profileAge,
    this.profileDistance,
    this.profileImages,
    this.matchRatio,
  });

  factory Blocklist.fromJson(Map<String, dynamic> json) => Blocklist(
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
