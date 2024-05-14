// To parse this JSON data, do
//
//     final reportapi = reportapiFromJson(jsonString);

import 'dart:convert';

Reportapi reportapiFromJson(String str) => Reportapi.fromJson(json.decode(str));

String reportapiToJson(Reportapi data) => json.encode(data.toJson());

class Reportapi {
  String? responseCode;
  String? result;
  String? responseMsg;

  Reportapi({
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory Reportapi.fromJson(Map<String, dynamic> json) => Reportapi(
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
