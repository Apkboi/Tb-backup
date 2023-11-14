// To parse this JSON data, do
//
//     final removeBookmarkResponse = removeBookmarkResponseFromJson(jsonString);

import 'dart:convert';

CheckBookmarkResponse removeBookmarkResponseFromJson(String str) => CheckBookmarkResponse.fromJson(json.decode(str));

String removeBookmarkResponseToJson(CheckBookmarkResponse data) => json.encode(data.toJson());

class CheckBookmarkResponse {
  final String msg;
  final dynamic data;
  final bool success;
  final int code;

  CheckBookmarkResponse({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  CheckBookmarkResponse copyWith({
    String? msg,
    dynamic data,
    bool? success,
    int? code,
  }) =>
      CheckBookmarkResponse(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory CheckBookmarkResponse.fromJson(Map<String, dynamic> json) => CheckBookmarkResponse(
    msg: json["msg"],
    data: json["data"],
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": data,
    "success": success,
    "code": code,
  };

  bool get isFavourite => msg.toString() != "User is not part of favourites";
  bool get isBookmarked => msg.toString() == "User is bookmarked.";


}
