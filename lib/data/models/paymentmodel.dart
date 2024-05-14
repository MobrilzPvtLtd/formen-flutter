// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  List<Paymentdatum>? paymentdata;
  String? responseCode;
  String? result;
  String? responseMsg;

  PaymentModel({
    this.paymentdata,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    paymentdata: json["paymentdata"] == null ? [] : List<Paymentdatum>.from(json["paymentdata"]!.map((x) => Paymentdatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "paymentdata": paymentdata == null ? [] : List<dynamic>.from(paymentdata!.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class Paymentdatum {
  String? id;
  String? title;
  String? img;
  String? attributes;
  String? status;
  String? subtitle;
  String? pShow;

  Paymentdatum({
    this.id,
    this.title,
    this.img,
    this.attributes,
    this.status,
    this.subtitle,
    this.pShow,
  });

  factory Paymentdatum.fromJson(Map<String, dynamic> json) => Paymentdatum(
    id: json["id"],
    title: json["title"],
    img: json["img"],
    attributes: json["attributes"],
    status: json["status"],
    subtitle: json["subtitle"],
    pShow: json["p_show"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "img": img,
    "attributes": attributes,
    "status": status,
    "subtitle": subtitle,
    "p_show": pShow,
  };
}
