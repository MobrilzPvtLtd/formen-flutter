import 'dart:convert';

RelationGoalModel relationGoalModelFromJson(String str) =>
    RelationGoalModel.fromJson(json.decode(str));

String relationGoalModelToJson(RelationGoalModel data) =>
    json.encode(data.toJson());

class RelationGoalModel {
  List<Goallist>? goallist;
  String? responseCode;
  String? result;
  String? responseMsg;

  RelationGoalModel({
    this.goallist,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory RelationGoalModel.fromJson(Map<String, dynamic> json) =>
      RelationGoalModel(
        goallist: json["goallist"] == null
            ? []
            : List<Goallist>.from(
                json["goallist"]!.map((x) => Goallist.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "goallist": goallist == null
            ? []
            : List<dynamic>.from(goallist!.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Goallist {
  String? id;
  String? title;
  String? subtitle;

  Goallist({
    this.id,
    this.title,
    this.subtitle,
  });

  factory Goallist.fromJson(Map<String, dynamic> json) => Goallist(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
      };
}
