// To parse this JSON data, do
//
//     final unBlockApi = unBlockApiFromJson(jsonString);

import 'dart:convert';

UnBlockApi unBlockApiFromJson(String str) => UnBlockApi.fromJson(json.decode(str));

String unBlockApiToJson(UnBlockApi data) => json.encode(data.toJson());

class UnBlockApi {
  String? responseCode;
  String? result;
  String? responseMsg;

  UnBlockApi({
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory UnBlockApi.fromJson(Map<String, dynamic> json) => UnBlockApi(
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
