// To parse this JSON data, do
//
//     final removeBookmarkResponse = removeBookmarkResponseFromJson(jsonString);

import 'dart:convert';

RemoveBookmarkResponse removeBookmarkResponseFromJson(String str) => RemoveBookmarkResponse.fromJson(json.decode(str));

String removeBookmarkResponseToJson(RemoveBookmarkResponse data) => json.encode(data.toJson());

class RemoveBookmarkResponse {
  final String msg;
  final dynamic data;
  final bool success;
  final int code;

  RemoveBookmarkResponse({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  RemoveBookmarkResponse copyWith({
    String? msg,
    dynamic data,
    bool? success,
    int? code,
  }) =>
      RemoveBookmarkResponse(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory RemoveBookmarkResponse.fromJson(Map<String, dynamic> json) => RemoveBookmarkResponse(
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
}
