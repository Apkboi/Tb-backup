// To parse this JSON data, do
//
//     final getConnectionsResDto = getConnectionsResDtoFromJson(jsonString);

import 'dart:convert';

GetConnectionsResDto getConnectionsResDtoFromJson(String str) => GetConnectionsResDto.fromJson(json.decode(str));

String getConnectionsResDtoToJson(GetConnectionsResDto data) => json.encode(data.toJson());

class GetConnectionsResDto {
  final String msg;
  final UserConnectionsData data;
  final bool success;
  final int code;

  GetConnectionsResDto({
    required this.msg,
    required this.data,
    required this.success,
    required this.code,
  });

  GetConnectionsResDto copyWith({
    String? msg,
    UserConnectionsData? data,
    bool? success,
    int? code,
  }) =>
      GetConnectionsResDto(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );

  factory GetConnectionsResDto.fromJson(Map<String, dynamic> json) => GetConnectionsResDto(
    msg: json["msg"],
    data: UserConnectionsData.fromJson(json["data"]),
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

class UserConnectionsData {
  final PaginationMeta paginationMeta;
  final List<UserConnection> data;

  UserConnectionsData({
    required this.paginationMeta,
    required this.data,
  });

  UserConnectionsData copyWith({
    PaginationMeta? paginationMeta,
    List<UserConnection>? data,
  }) =>
      UserConnectionsData(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );

  factory UserConnectionsData.fromJson(Map<String, dynamic> json) => UserConnectionsData(
    paginationMeta: PaginationMeta.fromJson(json["pagination_meta"]),
    data: List<UserConnection>.from(json["data"].map((x) => UserConnection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination_meta": paginationMeta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserConnection {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final dynamic phoneNo;
  final String gender;
  final String username;
  final String refCode;
  final bool emailVerification;
  final bool selfieVerification;

  UserConnection({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.gender,
    required this.username,
    required this.refCode,
    required this.emailVerification,
    required this.selfieVerification,
  });

  UserConnection copyWith({
    int? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    dynamic phoneNo,
    String? gender,
    String? username,
    String? refCode,
    bool? emailVerification,
    bool? selfieVerification,
  }) =>
      UserConnection(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        gender: gender ?? this.gender,
        username: username ?? this.username,
        refCode: refCode ?? this.refCode,
        emailVerification: emailVerification ?? this.emailVerification,
        selfieVerification: selfieVerification ?? this.selfieVerification,
      );

  factory UserConnection.fromJson(Map<String, dynamic> json) => UserConnection(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    gender: json["gender"],
    username: json["username"],
    refCode: json["ref_code"],
    emailVerification: json["email_verification"],
    selfieVerification: json["selfie_verification"],
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
    "ref_code": refCode,
    "email_verification": emailVerification,
    "selfie_verification": selfieVerification,
  };
}

class PaginationMeta {
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;
  final bool canLoadMore;

  PaginationMeta({
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.canLoadMore,
  });

  PaginationMeta copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
    bool? canLoadMore,
  }) =>
      PaginationMeta(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  factory PaginationMeta.fromJson(Map<String, dynamic> json) => PaginationMeta(
    currentPage: json["current_page"],
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
    canLoadMore: json["can_load_more"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
    "can_load_more": canLoadMore,
  };
}
