// To parse this JSON data, do
//
//     final planmodel = planmodelFromJson(jsonString);

import 'dart:convert';

Planmodel planmodelFromJson(String str) => Planmodel.fromJson(json.decode(str));

String planmodelToJson(Planmodel data) => json.encode(data.toJson());

class Planmodel {
  String? responseCode;
  String? result;
  String? responseMsg;
  String? directChat;
  String? likeMenu;
  String? audioVideo;
  String? filterInclude;
  String? planName;
  String? planId;
  String? planDescription;
  String? isSubscribe;

  Planmodel({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.directChat,
    this.likeMenu,
    this.audioVideo,
    this.filterInclude,
    this.planName,
    this.planId,
    this.planDescription,
    this.isSubscribe,
  });

  factory Planmodel.fromJson(Map<String, dynamic> json) => Planmodel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    directChat: json["direct_chat"],
    likeMenu: json["Like_menu"],
    audioVideo: json["audio_video"],
    filterInclude: json["filter_include"],
    planName: json["plan_name"],
    planId: json["plan_id"],
    planDescription: json["plan_description"],
    isSubscribe: json["is_subscribe"],
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "direct_chat": directChat,
    "Like_menu": likeMenu,
    "audio_video": audioVideo,
    "filter_include": filterInclude,
    "plan_name": planName,
    "plan_id": planId,
    "plan_description": planDescription,
    "is_subscribe": isSubscribe,
  };
}
