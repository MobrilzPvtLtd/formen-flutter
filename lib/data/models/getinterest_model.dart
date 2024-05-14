// To parse this JSON data, do
//
//     final interestModel = interestModelFromJson(jsonString);

import 'dart:convert';

InterestModel interestModelFromJson(String str) =>
    InterestModel.fromJson(json.decode(str));

String interestModelToJson(InterestModel data) => json.encode(data.toJson());

class InterestModel {
  List<Interestlist>? interestlist;
  String? responseCode;
  String? result;
  String? responseMsg;

  InterestModel({
    this.interestlist,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) => InterestModel(
        interestlist: json["interestlist"] == null
            ? []
            : List<Interestlist>.from(
                json["interestlist"]!.map((x) => Interestlist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "interestlist": interestlist == null
            ? []
            : List<dynamic>.from(interestlist!.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Interestlist {
  String? id;
  String? title;
  String? img;

  Interestlist({
    this.id,
    this.title,
    this.img,
  });

  factory Interestlist.fromJson(Map<String, dynamic> json) => Interestlist(
        id: json["id"],
        title: json["title"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "img": img,
      };
}
