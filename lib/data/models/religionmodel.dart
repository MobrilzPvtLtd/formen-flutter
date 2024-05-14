// To parse this JSON data, do
//
//     final religionModel = religionModelFromJson(jsonString);

import 'dart:convert';

ReligionModel religionModelFromJson(String str) =>
    ReligionModel.fromJson(json.decode(str));

String religionModelToJson(ReligionModel data) => json.encode(data.toJson());

class ReligionModel {
  List<Religionlist>? religionlist;
  String? responseCode;
  String? result;
  String? responseMsg;

  ReligionModel({
    this.religionlist,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory ReligionModel.fromJson(Map<String, dynamic> json) => ReligionModel(
        religionlist: json["religionlist"] == null
            ? []
            : List<Religionlist>.from(
                json["religionlist"]!.map((x) => Religionlist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "religionlist": religionlist == null
            ? []
            : List<dynamic>.from(religionlist!.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Religionlist {
  String? id;
  String? title;

  Religionlist({
    this.id,
    this.title,
  });

  factory Religionlist.fromJson(Map<String, dynamic> json) => Religionlist(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
