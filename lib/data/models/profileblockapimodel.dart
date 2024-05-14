// To parse this JSON data, do
//
//     final profileblockuser = profileblockuserFromJson(jsonString);

import 'dart:convert';

Profileblockuser profileblockuserFromJson(String str) => Profileblockuser.fromJson(json.decode(str));

String profileblockuserToJson(Profileblockuser data) => json.encode(data.toJson());

class Profileblockuser {
  String? responseCode;
  String? result;
  String? responseMsg;

  Profileblockuser({
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory Profileblockuser.fromJson(Map<String, dynamic> json) => Profileblockuser(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}
