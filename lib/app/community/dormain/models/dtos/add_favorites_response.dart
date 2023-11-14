// To parse this JSON data, do
//
//     final addFavoriteResponse = addFavoriteResponseFromJson(jsonString);

import 'dart:convert';

AddFavoriteResponse addFavoriteResponseFromJson(String str) => AddFavoriteResponse.fromJson(json.decode(str));

String addFavoriteResponseToJson(AddFavoriteResponse data) => json.encode(data.toJson());

class AddFavoriteResponse {
  final String msg;
  final Data data;
  final bool success;
  final int code;

  AddFavoriteResponse({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  AddFavoriteResponse copyWith({
    String? msg,
    Data? data,
    bool? success,
    int? code,
  }) =>
      AddFavoriteResponse(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory AddFavoriteResponse.fromJson(Map<String, dynamic> json) => AddFavoriteResponse(
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
  final LikedUser likedUser;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.likedUser,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    LikedUser? likedUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        likedUser: likedUser ?? this.likedUser,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    likedUser: LikedUser.fromJson(json["liked_user"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "liked_user": likedUser.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class LikedUser {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final dynamic phoneNo;
  final String gender;
  final String username;

  LikedUser({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.gender,
    required this.username,
  });

  LikedUser copyWith({
    int? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    dynamic phoneNo,
    String? gender,
    String? username,
  }) =>
      LikedUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        gender: gender ?? this.gender,
        username: username ?? this.username,
      );

  factory LikedUser.fromJson(Map<String, dynamic> json) => LikedUser(
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