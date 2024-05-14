// // // To parse this JSON data, do
// // //
// // //     final homeModel = homeModelFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));
// //
// // String homeModelToJson(HomeModel data) => json.encode(data.toJson());
// //
// // class HomeModel {
// //   String? responseCode;
// //   String? result;
// //   String? responseMsg;
// //   List<Profilelist>? profilelist;
// //   String? currency;
// //   List<Profilelist>? totalliked;
// //   String? directChat;
// //   String? likeMenu;
// //   String? audioVideo;
// //   String? filterInclude;
// //   String? planName;
// //   String? planId;
// //   String? planDescription;
// //   String? isSubscribe;
// //   Plandata? plandata;
// //   String? chat;
// //
// //   HomeModel({
// //     this.responseCode,
// //     this.result,
// //     this.responseMsg,
// //     this.profilelist,
// //     this.currency,
// //     this.totalliked,
// //     this.directChat,
// //     this.likeMenu,
// //     this.audioVideo,
// //     this.filterInclude,
// //     this.planName,
// //     this.planId,
// //     this.planDescription,
// //     this.isSubscribe,
// //     this.plandata,
// //     this.chat,
// //   });
// //
// //   factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
// //     responseCode: json["ResponseCode"],
// //     result: json["Result"],
// //     responseMsg: json["ResponseMsg"],
// //     profilelist: json["profilelist"] == null ? [] : List<Profilelist>.from(json["profilelist"]!.map((x) => Profilelist.fromJson(x))),
// //     currency: json["currency"],
// //     totalliked: json["totalliked"] == null ? [] : List<Profilelist>.from(json["totalliked"]!.map((x) => Profilelist.fromJson(x))),
// //     directChat: json["direct_chat"],
// //     likeMenu: json["Like_menu"],
// //     audioVideo: json["audio_video"],
// //     filterInclude: json["filter_include"],
// //     planName: json["plan_name"],
// //     planId: json["plan_id"],
// //     planDescription: json["plan_description"],
// //     isSubscribe: json["is_subscribe"],
// //     plandata: json["plandata"] == null ? null : Plandata.fromJson(json["plandata"]),
// //     chat: json["chat"],
// //
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "ResponseCode": responseCode,
// //     "Result": result,
// //     "ResponseMsg": responseMsg,
// //     "profilelist": profilelist == null ? [] : List<dynamic>.from(profilelist!.map((x) => x.toJson())),
// //     "currency": currency,
// //     "totalliked": totalliked == null ? [] : List<dynamic>.from(totalliked!.map((x) => x.toJson())),
// //     "direct_chat": directChat,
// //     "Like_menu": likeMenu,
// //     "audio_video": audioVideo,
// //     "filter_include": filterInclude,
// //     "plan_name": planName,
// //     "plan_id": planId,
// //     "plan_description": planDescription,
// //     "is_subscribe": isSubscribe,
// //     "plandata": plandata?.toJson(),
// //     "chat": chat,
// //   };
// // }
// // class Plandata {
// //   String? planTitle;
// //   String? planStartDate;
// //   String? planEndDate;
// //   String? transId;
// //   String? pName;
// //   String? amount;
// //   String? planDescription;
// //
// //   Plandata({
// //     this.planTitle,
// //     this.planStartDate,
// //     this.planEndDate,
// //     this.transId,
// //     this.pName,
// //     this.amount,
// //     this.planDescription,
// //   });
// //
// //   factory Plandata.fromJson(Map<String, dynamic> json) => Plandata(
// //     planTitle: json["plan_title"],
// //     planStartDate: json["plan_start_date"],
// //     planEndDate: json["plan_end_date"],
// //     transId: json["trans_id"],
// //     pName: json["p_name"],
// //     amount: json["amount"],
// //     planDescription: json["plan_description"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "plan_title": planTitle,
// //     "plan_start_date": planStartDate,
// //     "plan_end_date": planEndDate,
// //     "trans_id": transId,
// //     "p_name": pName,
// //     "amount": amount,
// //     "plan_description": planDescription,
// //   };
// // }
// //
// // class Profilelist {
// //   String? profileId;
// //   String? profileName;
// //   String? profileBio;
// //   int? profileAge;
// //   String? isSubscribe;
// //   String? profileDistance;
// //   List<String>? profileImages;
// //   double? matchRatio;
// //
// //   Profilelist({
// //     this.profileId,
// //     this.profileName,
// //     this.profileBio,
// //     this.profileAge,
// //     this.isSubscribe,
// //     this.profileDistance,
// //     this.profileImages,
// //     this.matchRatio,
// //   });
// //
// //   factory Profilelist.fromJson(Map<String, dynamic> json) => Profilelist(
// //     profileId: json["profile_id"],
// //     profileName: json["profile_name"],
// //     profileBio: json["profile_bio"],
// //     profileAge: json["profile_age"],
// //     isSubscribe: json["is_subscribe"],
// //     profileDistance: json["profile_distance"],
// //     profileImages: json["profile_images"] == null ? [] : List<String>.from(json["profile_images"]!.map((x) => x)),
// //     matchRatio: json["match_ratio"]?.toDouble(),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "profile_id": profileId,
// //     "profile_name": profileName,
// //     "profile_bio": profileBio,
// //     "profile_age": profileAge,
// //     "is_subscribe": isSubscribe,
// //     "profile_distance": profileDistance,
// //     "profile_images": profileImages == null ? [] : List<dynamic>.from(profileImages!.map((x) => x)),
// //     "match_ratio": matchRatio,
// //   };
// // }
//
//
//
//
//
//
//
//
//
//
//
//
//
// // To parse this JSON data, do
// //
// //     final homeModel = homeModelFromJson(jsonString);
//
// import 'dart:convert';
//
// HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));
//
// String homeModelToJson(HomeModel data) => json.encode(data.toJson());
//
// class HomeModel {
//   String? responseCode;
//   String? result;
//   String? responseMsg;
//   List<Profilelist>? profilelist;
//   String? currency;
//   List<dynamic>? totalliked;
//   String? directChat;
//   String? likeMenu;
//   String? audioVideo;
//   String? filterInclude;
//   String? planName;
//   String? planId;
//   String? planDescription;
//   String? isSubscribe;
//   Plandata? plandata;
//   String? chat;
//   String? isVerify;
//
//   HomeModel({
//     this.responseCode,
//     this.result,
//     this.responseMsg,
//     this.profilelist,
//     this.currency,
//     this.totalliked,
//     this.directChat,
//     this.likeMenu,
//     this.audioVideo,
//     this.filterInclude,
//     this.planName,
//     this.planId,
//     this.planDescription,
//     this.isSubscribe,
//     this.plandata,
//     this.chat,
//     this.isVerify,
//   });
//
//   factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
//     responseCode: json["ResponseCode"],
//     result: json["Result"],
//     responseMsg: json["ResponseMsg"],
//     profilelist: json["profilelist"] == null ? [] : List<Profilelist>.from(json["profilelist"]!.map((x) => Profilelist.fromJson(x))),
//     currency: json["currency"],
//     totalliked: json["totalliked"] == null ? [] : List<dynamic>.from(json["totalliked"]!.map((x) => x)),
//     directChat: json["direct_chat"],
//     likeMenu: json["Like_menu"],
//     audioVideo: json["audio_video"],
//     filterInclude: json["filter_include"],
//     planName: json["plan_name"],
//     planId: json["plan_id"],
//     planDescription: json["plan_description"],
//     isSubscribe: json["is_subscribe"],
//     plandata: json["plandata"] == null ? null : Plandata.fromJson(json["plandata"]),
//     chat: json["chat"],
//     isVerify: json["is_verify"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ResponseCode": responseCode,
//     "Result": result,
//     "ResponseMsg": responseMsg,
//     "profilelist": profilelist == null ? [] : List<dynamic>.from(profilelist!.map((x) => x.toJson())),
//     "currency": currency,
//     "totalliked": totalliked == null ? [] : List<dynamic>.from(totalliked!.map((x) => x)),
//     "direct_chat": directChat,
//     "Like_menu": likeMenu,
//     "audio_video": audioVideo,
//     "filter_include": filterInclude,
//     "plan_name": planName,
//     "plan_id": planId,
//     "plan_description": planDescription,
//     "is_subscribe": isSubscribe,
//     "plandata": plandata?.toJson(),
//     "chat": chat,
//     "is_verify": isVerify,
//   };
// }
//
// class Plandata {
//   String? planTitle;
//   DateTime? planStartDate;
//   DateTime? planEndDate;
//   String? transId;
//   String? pName;
//   String? amount;
//   String? planDescription;
//
//   Plandata({
//     this.planTitle,
//     this.planStartDate,
//     this.planEndDate,
//     this.transId,
//     this.pName,
//     this.amount,
//     this.planDescription,
//   });
//
//   factory Plandata.fromJson(Map<String, dynamic> json) => Plandata(
//     planTitle: json["plan_title"],
//     planStartDate: json["plan_start_date"] == null ? null : DateTime.parse(json["plan_start_date"]),
//     planEndDate: json["plan_end_date"] == null ? null : DateTime.parse(json["plan_end_date"]),
//     transId: json["trans_id"],
//     pName: json["p_name"],
//     amount: json["amount"],
//     planDescription: json["plan_description"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "plan_title": planTitle,
//     "plan_start_date": "${planStartDate!.year.toString().padLeft(4, '0')}-${planStartDate!.month.toString().padLeft(2, '0')}-${planStartDate!.day.toString().padLeft(2, '0')}",
//     "plan_end_date": "${planEndDate!.year.toString().padLeft(4, '0')}-${planEndDate!.month.toString().padLeft(2, '0')}-${planEndDate!.day.toString().padLeft(2, '0')}",
//     "trans_id": transId,
//     "p_name": pName,
//     "amount": amount,
//     "plan_description": planDescription,
//   };
// }
//
// class Profilelist {
//   String? profileId;
//   String? profileName;
//   String? isSubscribe;
//   String? profileBio;
//   String? isVerify;
//   int? profileAge;
//   String? profileDistance;
//   List<String>? profileImages;
//   double? matchRatio;
//
//   Profilelist({
//     this.profileId,
//     this.profileName,
//     this.isSubscribe,
//     this.profileBio,
//     this.isVerify,
//     this.profileAge,
//     this.profileDistance,
//     this.profileImages,
//     this.matchRatio,
//   });
//
//   factory Profilelist.fromJson(Map<String, dynamic> json) => Profilelist(
//     profileId: json["profile_id"],
//     profileName: json["profile_name"],
//     isSubscribe: json["is_subscribe"],
//     profileBio: json["profile_bio"],
//     isVerify: json["is_verify"],
//     profileAge: json["profile_age"],
//     profileDistance: json["profile_distance"],
//     profileImages: json["profile_images"] == null ? [] : List<String>.from(json["profile_images"]!.map((x) => x)),
//     matchRatio: json["match_ratio"]?.toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "profile_id": profileId,
//     "profile_name": profileName,
//     "is_subscribe": isSubscribe,
//     "profile_bio": profileBio,
//     "is_verify": isVerify,
//     "profile_age": profileAge,
//     "profile_distance": profileDistance,
//     "profile_images": profileImages == null ? [] : List<dynamic>.from(profileImages!.map((x) => x)),
//     "match_ratio": matchRatio,
//   };
// }
//
//
//
//
//
//
//



// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String? responseCode;
  String? result;
  String? responseMsg;
  List<Profilelist>? profilelist;
  String? currency;
  List<Profilelist>? totalliked;
  String? directChat;
  String? likeMenu;
  String? audioVideo;
  String? filterInclude;
  String? planName;
  String? planId;
  String? planDescription;
  String? isSubscribe;
  Plandata? plandata;
  String? chat;
  String? isVerify;

  HomeModel({
    this.responseCode,
    this.result,
    this.responseMsg,
    this.profilelist,
    this.currency,
    this.totalliked,
    this.directChat,
    this.likeMenu,
    this.audioVideo,
    this.filterInclude,
    this.planName,
    this.planId,
    this.planDescription,
    this.isSubscribe,
    this.plandata,
    this.chat,
    this.isVerify,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
    profilelist: json["profilelist"] == null ? [] : List<Profilelist>.from(json["profilelist"]!.map((x) => Profilelist.fromJson(x))),
    currency: json["currency"],
    totalliked: json["totalliked"] == null ? [] : List<Profilelist>.from(json["totalliked"]!.map((x) => Profilelist.fromJson(x))),
    directChat: json["direct_chat"],
    likeMenu: json["Like_menu"],
    audioVideo: json["audio_video"],
    filterInclude: json["filter_include"],
    planName: json["plan_name"],
    planId: json["plan_id"],
    planDescription: json["plan_description"],
    isSubscribe: json["is_subscribe"],
    plandata: json["plandata"] == null ? null : Plandata.fromJson(json["plandata"]),
    chat: json["chat"],
    isVerify: json["is_verify"],

  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
    "profilelist": profilelist == null ? [] : List<dynamic>.from(profilelist!.map((x) => x.toJson())),
    "currency": currency,
    "totalliked": totalliked == null ? [] : List<dynamic>.from(totalliked!.map((x) => x.toJson())),
    "direct_chat": directChat,
    "Like_menu": likeMenu,
    "audio_video": audioVideo,
    "filter_include": filterInclude,
    "plan_name": planName,
    "plan_id": planId,
    "plan_description": planDescription,
    "is_subscribe": isSubscribe,
    "plandata": plandata?.toJson(),
    "chat": chat,
    "is_verify": isVerify,
  };
}
class Plandata {
  String? planTitle;
  String? planStartDate;
  String? planEndDate;
  String? transId;
  String? pName;
  String? amount;
  String? planDescription;

  Plandata({
    this.planTitle,
    this.planStartDate,
    this.planEndDate,
    this.transId,
    this.pName,
    this.amount,
    this.planDescription,
  });

  factory Plandata.fromJson(Map<String, dynamic> json) => Plandata(
    planTitle: json["plan_title"],
    planStartDate: json["plan_start_date"],
    planEndDate: json["plan_end_date"],
    transId: json["trans_id"],
    pName: json["p_name"],
    amount: json["amount"],
    planDescription: json["plan_description"],
  );

  Map<String, dynamic> toJson() => {
    "plan_title": planTitle,
    "plan_start_date": planStartDate,
    "plan_end_date": planEndDate,
    "trans_id": transId,
    "p_name": pName,
    "amount": amount,
    "plan_description": planDescription,
  };
}

class Profilelist {
  String? profileId;
  String? profileName;
  String? profileBio;
  int? profileAge;
  String? isSubscribe;
  String? profileDistance;
  String? isVerify;
  List<String>? profileImages;
  double? matchRatio;

  Profilelist({
    this.profileId,
    this.profileName,
    this.profileBio,
    this.profileAge,
    this.isSubscribe,
    this.isVerify,
    this.profileDistance,
    this.profileImages,
    this.matchRatio,
  });

  factory Profilelist.fromJson(Map<String, dynamic> json) => Profilelist(
    profileId: json["profile_id"],
    profileName: json["profile_name"],
    profileBio: json["profile_bio"],
    profileAge: json["profile_age"],
    isSubscribe: json["is_subscribe"],
    isVerify: json["is_verify"],
    profileDistance: json["profile_distance"],
    profileImages: json["profile_images"] == null ? [] : List<String>.from(json["profile_images"]!.map((x) => x)),
    matchRatio: json["match_ratio"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "profile_id": profileId,
    "profile_name": profileName,
    "profile_bio": profileBio,
    "profile_age": profileAge,
    "is_subscribe": isSubscribe,
    "profile_distance": profileDistance,
    "is_verify": isVerify,
    "profile_images": profileImages == null ? [] : List<dynamic>.from(profileImages!.map((x) => x)),
    "match_ratio": matchRatio,
  };
}
