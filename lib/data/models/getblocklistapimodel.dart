// To parse this JSON data, do
//
//     final getblockListApi = getblockListApiFromJson(jsonString);

import 'dart:convert';

GetblockListApi getblockListApiFromJson(String str) => GetblockListApi.fromJson(json.decode(str));

String getblockListApiToJson(GetblockListApi data) => json.encode(data.toJson());

class GetblockListApi {
  List<String>? blockByMe;
  List<dynamic>? blockByOther;
  String? responseCode;
  String? result;
  String? responseMsg;

  GetblockListApi({
    this.blockByMe,
    this.blockByOther,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory GetblockListApi.fromJson(Map<String, dynamic> json) => GetblockListApi(
    blockByMe: json["block_by_me"] == null ? [] : List<String>.from(json["block_by_me"]!.map((x) => x)),
    blockByOther: json["block_by_other"] == null ? [] : List<dynamic>.from(json["block_by_other"]!.map((x) => x)),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "block_by_me": blockByMe == null ? [] : List<dynamic>.from(blockByMe!.map((x) => x)),
    "block_by_other": blockByOther == null ? [] : List<dynamic>.from(blockByOther!.map((x) => x)),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}
