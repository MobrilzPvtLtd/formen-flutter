// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  List<NotificationDatum>? notificationData;
  String? responseCode;
  String? result;
  String? responseMsg;

  NotificationModel({
    this.notificationData,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notificationData: json["NotificationData"] == null ? [] : List<NotificationDatum>.from(json["NotificationData"]!.map((x) => NotificationDatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "NotificationData": notificationData == null ? [] : List<dynamic>.from(notificationData!.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class NotificationDatum {
  String? id;
  String? uid;
  DateTime? datetime;
  String? title;
  String? description;

  NotificationDatum({
    this.id,
    this.uid,
    this.datetime,
    this.title,
    this.description,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) => NotificationDatum(
    id: json["id"],
    uid: json["uid"],
    datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "datetime": datetime?.toIso8601String(),
    "title": title,
    "description": description,
  };
}
