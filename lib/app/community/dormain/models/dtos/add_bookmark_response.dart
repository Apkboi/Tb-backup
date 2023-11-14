// To parse this JSON data, do
//
//     final addBookmarkResponse = addBookmarkResponseFromJson(jsonString);

import 'dart:convert';

AddBookmarkResponse addBookmarkResponseFromJson(String str) => AddBookmarkResponse.fromJson(json.decode(str));

String addBookmarkResponseToJson(AddBookmarkResponse data) => json.encode(data.toJson());

class AddBookmarkResponse {
  final String msg;
  final Data data;
  final bool success;
  final int code;

  AddBookmarkResponse({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  AddBookmarkResponse copyWith({
    String? msg,
    Data? data,
    bool? success,
    int? code,
  }) =>
      AddBookmarkResponse(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory AddBookmarkResponse.fromJson(Map<String, dynamic> json) => AddBookmarkResponse(
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
    success: json["success"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": data.toJson(),
    "success": success,
    "code": code,
  };
}

class Data {
  final BookmarkedUser bookmarkedUser;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.bookmarkedUser,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    BookmarkedUser? bookmarkedUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        bookmarkedUser: bookmarkedUser ?? this.bookmarkedUser,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookmarkedUser: BookmarkedUser.fromJson(json["bookmarked_user"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "bookmarked_user": bookmarkedUser.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class BookmarkedUser {
  final int id;
  final dynamic firstName;
  final dynamic middleName;
  final String lastName;
  final String email;
  final dynamic phoneNo;
  final String gender;
  final String username;

  BookmarkedUser({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.gender,
    required this.username,
  });

  BookmarkedUser copyWith({
    int? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    dynamic phoneNo,
    String? gender,
    String? username,
  }) =>
      BookmarkedUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        gender: gender ?? this.gender,
        username: username ?? this.username,
      );

  factory BookmarkedUser.fromJson(Map<String, dynamic> json) => BookmarkedUser(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    gender: json["gender"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "phone_no": phoneNo,
    "gender": gender,
    "username": username,
  };
}