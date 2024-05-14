// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  List<FaqDatum>? faqData;
  String? responseCode;
  String? result;
  String? responseMsg;

  FaqModel({
    this.faqData,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    faqData: json["FaqData"] == null ? [] : List<FaqDatum>.from(json["FaqData"]!.map((x) => FaqDatum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "FaqData": faqData == null ? [] : List<dynamic>.from(faqData!.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class FaqDatum {
  String? id;
  String? question;
  String? answer;
  String? status;

  FaqDatum({
    this.id,
    this.question,
    this.answer,
    this.status,
  });

  factory FaqDatum.fromJson(Map<String, dynamic> json) => FaqDatum(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "status": status,
  };
}
