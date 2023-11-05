// To parse this JSON data, do
//
//     final saveConnectionResDto = saveConnectionResDtoFromJson(jsonString);

import 'dart:convert';

SaveConnectionResDto saveConnectionResDtoFromJson(String str) => SaveConnectionResDto.fromJson(json.decode(str));

String saveConnectionResDtoToJson(SaveConnectionResDto data) => json.encode(data.toJson());

class SaveConnectionResDto {
  final String msg;
  final Data data;
  final bool success;
  final int code;

  SaveConnectionResDto({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  SaveConnectionResDto copyWith({
    String? msg,
    Data? data,
    bool? success,
    int? code,
  }) =>
      SaveConnectionResDto(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory SaveConnectionResDto.fromJson(Map<String, dynamic> json) => SaveConnectionResDto(
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
  final int id;
  final _User user;
  final _User connectedUser;

  Data({
    required this.id,
    required this.user,
    required this.connectedUser,
  });

  Data copyWith({
    int? id,
    _User? user,
    _User? connectedUser,
  }) =>
      Data(
        id: id ?? this.id,
        user: user ?? this.user,
        connectedUser: connectedUser ?? this.connectedUser,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    user: _User.fromJson(json["user"]),
    connectedUser: _User.fromJson(json["connected_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "connected_user": connectedUser.toJson(),
  };
}

class _User {
  final int id;
  final String firstName;
  final String lastName;

  _User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  _User copyWith({
    int? id,
    String? firstName,
    String? lastName,
  }) =>
      _User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory _User.fromJson(Map<String, dynamic> json) => _User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}
