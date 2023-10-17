import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';

/// msg : "User registered successfully"
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3RyaWJlcmx5LnByb2RldnMuaW8vYXBpL3YxL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE2OTc0Mjg0MDUsImV4cCI6MTY5NzQzMjAwNSwibmJmIjoxNjk3NDI4NDA1LCJqdGkiOiI5U3BJMHJnUVc4NWo1T2tJIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.V1XJYOT8YR6oiiSY-rIrOF6AcAW6X5j1zujWicH9JtM","token_type":"bearer","expires_in":3600000,"user":{"id":4,"first_name":"Tamun","middle_name":"Tas","last_name":"das","email":"f@mailinator.com","phone_no":null,"gender":"Male","username":"tamund","ref_code":"hmHlyQiT","email_verification":false,"selfie_verification":false,"dob":null,"profession":null,"relationship_status":null,"intent":null,"home_address":null,"origin_city_id":null,"origin_state_id":null,"origin_country_id":null,"residence_country_id":null,"tribes":null,"education":null,"family_status":null,"other_languages":null,"bio":null,"interests":null,"religion":null,"have_kids":null,"instagram_link":null,"tiktok_link":null,"linkedin_link":null,"profile_image":null,"email_verified":null,"status":"Active","latitude":0,"longitude":0}}
/// success : true
/// code : 200

class SignUpResDto {
  SignUpResDto({
    this.msg,
    this.data,
    this.success,
    this.code,
  });

  SignUpResDto.fromJson(dynamic json) {
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  Data? data;
  bool? success;
  num? code;
  SignUpResDto copyWith({
    String? msg,
    Data? data,
    bool? success,
    num? code,
  }) =>
      SignUpResDto(
        msg: msg ?? this.msg,
        data: data ?? this.data,
        success: success ?? this.success,
        code: code ?? this.code,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['success'] = success;
    map['code'] = code;
    return map;
  }
}

/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3RyaWJlcmx5LnByb2RldnMuaW8vYXBpL3YxL2F1dGgvcmVnaXN0ZXIiLCJpYXQiOjE2OTc0Mjg0MDUsImV4cCI6MTY5NzQzMjAwNSwibmJmIjoxNjk3NDI4NDA1LCJqdGkiOiI5U3BJMHJnUVc4NWo1T2tJIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.V1XJYOT8YR6oiiSY-rIrOF6AcAW6X5j1zujWicH9JtM"
/// token_type : "bearer"
/// expires_in : 3600000
/// user : {"id":4,"first_name":"Tamun","middle_name":"Tas","last_name":"das","email":"f@mailinator.com","phone_no":null,"gender":"Male","username":"tamund","ref_code":"hmHlyQiT","email_verification":false,"selfie_verification":false,"dob":null,"profession":null,"relationship_status":null,"intent":null,"home_address":null,"origin_city_id":null,"origin_state_id":null,"origin_country_id":null,"residence_country_id":null,"tribes":null,"education":null,"family_status":null,"other_languages":null,"bio":null,"interests":null,"religion":null,"have_kids":null,"instagram_link":null,"tiktok_link":null,"linkedin_link":null,"profile_image":null,"email_verified":null,"status":"Active","latitude":0,"longitude":0}

class Data {
  Data({
    this.token,
    this.tokenType,
    this.expiresIn,
    this.user,
  });

  Data.fromJson(dynamic json) {
    token = json['token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? token;
  String? tokenType;
  num? expiresIn;
  User? user;
  Data copyWith({
    String? token,
    String? tokenType,
    num? expiresIn,
    User? user,
  }) =>
      Data(
        token: token ?? this.token,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
