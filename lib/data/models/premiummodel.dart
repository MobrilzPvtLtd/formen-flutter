// To parse this JSON data, do
//
//     final premiumModel = premiumModelFromJson(jsonString);

import 'dart:convert';

PremiumModel premiumModelFromJson(String str) => PremiumModel.fromJson(json.decode(str));

String premiumModelToJson(PremiumModel data) => json.encode(data.toJson());

class PremiumModel {
  List<PlanDatum>? planData;
  String? responseCode;
  String? result;
  String? responseMsg;

  PremiumModel({
    this.planData,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory PremiumModel.fromJson(Map<String, dynamic> json) => PremiumModel(
    planData: json["PlanData"] == null ? [] : List<PlanDatum>.from(json["PlanData"]!.map((x) => PlanDatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "PlanData": planData == null ? [] : List<dynamic>.from(planData!.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class PlanDatum {
  String? id;
  String? title;
  String? amt;
  String? description;
  String? filterInclude;
  String? dayLimit;
  String? directChat;
  String? audioVideo;
  String? status;

  PlanDatum({
    this.id,
    this.title,
    this.amt,
    this.description,
    this.filterInclude,
    this.dayLimit,
    this.directChat,
    this.audioVideo,
    this.status,
  });

  factory PlanDatum.fromJson(Map<String, dynamic> json) => PlanDatum(
    id: json["id"],
    title: json["title"],
    amt: json["amt"],
    description: json["description"],
    filterInclude: json["filter_include"],
    dayLimit: json["day_limit"],
    directChat: json["direct_chat"],
    audioVideo: json["audio_video"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "amt": amt,
    "description": description,
    "filter_include": filterInclude,
    "day_limit": dayLimit,
    "direct_chat": directChat,
    "audio_video": audioVideo,
    "status": status,
  };
}
