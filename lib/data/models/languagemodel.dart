// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel languageModelFromJson(String str) =>
    LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  List<Languagelist>? languagelist;
  String? responseCode;
  String? result;
  String? responseMsg;

  LanguageModel({
    this.languagelist,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        languagelist: json["languagelist"] == null
            ? []
            : List<Languagelist>.from(
                json["languagelist"]!.map((x) => Languagelist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "languagelist": languagelist == null
            ? []
            : List<dynamic>.from(languagelist!.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Languagelist {
  String? id;
  String? title;
  String? img;

  Languagelist({
    this.id,
    this.title,
    this.img,
  });

  factory Languagelist.fromJson(Map<String, dynamic> json) => Languagelist(
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
