// To parse this JSON data, do
//
//     final identiDoc = identiDocFromJson(jsonString);

import 'dart:convert';

IdentiDoc identiDocFromJson(String str) => IdentiDoc.fromJson(json.decode(str));

String identiDocToJson(IdentiDoc data) => json.encode(data.toJson());

class IdentiDoc {
  UserLogin? userLogin;
  String? responseCode;
  String? result;
  String? responseMsg;

  IdentiDoc({
    this.userLogin,
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory IdentiDoc.fromJson(Map<String, dynamic> json) => IdentiDoc(
    userLogin: json["UserLogin"] == null ? null : UserLogin.fromJson(json["UserLogin"]),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "UserLogin": userLogin?.toJson(),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class UserLogin {
  String? id;
  String? name;
  String? mobile;
  String? password;
  DateTime? rdate;
  String? status;
  String? ccode;
  String? code;
  dynamic refercode;
  String? wallet;
  String? email;
  String? gender;
  String? lats;
  String? longs;
  String? profileBio;
  dynamic profilePic;
  DateTime? birthDate;
  String? searchPreference;
  String? radiusSearch;
  String? relationGoal;
  String? interest;
  String? language;
  String? religion;
  String? otherPic;
  String? planId;
  dynamic planStartDate;
  dynamic planEndDate;
  String? isSubscribe;
  String? historyId;
  dynamic height;
  String? identityPicture;
  String? isVerify;

  UserLogin({
    this.id,
    this.name,
    this.mobile,
    this.password,
    this.rdate,
    this.status,
    this.ccode,
    this.code,
    this.refercode,
    this.wallet,
    this.email,
    this.gender,
    this.lats,
    this.longs,
    this.profileBio,
    this.profilePic,
    this.birthDate,
    this.searchPreference,
    this.radiusSearch,
    this.relationGoal,
    this.interest,
    this.language,
    this.religion,
    this.otherPic,
    this.planId,
    this.planStartDate,
    this.planEndDate,
    this.isSubscribe,
    this.historyId,
    this.height,
    this.identityPicture,
    this.isVerify,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    password: json["password"],
    rdate: json["rdate"] == null ? null : DateTime.parse(json["rdate"]),
    status: json["status"],
    ccode: json["ccode"],
    code: json["code"],
    refercode: json["refercode"],
    wallet: json["wallet"],
    email: json["email"],
    gender: json["gender"],
    lats: json["lats"],
    longs: json["longs"],
    profileBio: json["profile_bio"],
    profilePic: json["profile_pic"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    searchPreference: json["search_preference"],
    radiusSearch: json["radius_search"],
    relationGoal: json["relation_goal"],
    interest: json["interest"],
    language: json["language"],
    religion: json["religion"],
    otherPic: json["other_pic"],
    planId: json["plan_id"],
    planStartDate: json["plan_start_date"],
    planEndDate: json["plan_end_date"],
    isSubscribe: json["is_subscribe"],
    historyId: json["history_id"],
    height: json["height"],
    identityPicture: json["identity_picture"],
    isVerify: json["is_verify"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "password": password,
    "rdate": rdate?.toIso8601String(),
    "status": status,
    "ccode": ccode,
    "code": code,
    "refercode": refercode,
    "wallet": wallet,
    "email": email,
    "gender": gender,
    "lats": lats,
    "longs": longs,
    "profile_bio": profileBio,
    "profile_pic": profilePic,
    "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "search_preference": searchPreference,
    "radius_search": radiusSearch,
    "relation_goal": relationGoal,
    "interest": interest,
    "language": language,
    "religion": religion,
    "other_pic": otherPic,
    "plan_id": planId,
    "plan_start_date": planStartDate,
    "plan_end_date": planEndDate,
    "is_subscribe": isSubscribe,
    "history_id": historyId,
    "height": height,
    "identity_picture": identityPicture,
    "is_verify": isVerify,
  };
}
