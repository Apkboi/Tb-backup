import 'user_dto.dart';

/// msg : "User retrieved successfully"
/// data : {"id":4,"first_name":"Tamun","middle_name":"Tas","last_name":"das","email":"f@mailinator.com","phone_no":null,"gender":"Male","username":"tamund","ref_code":"hmHlyQiT","email_verification":false,"selfie_verification":false,"dob":null,"profession":null,"relationship_status":null,"intent":null,"home_address":null,"origin_city_id":null,"origin_state_id":null,"origin_country_id":null,"residence_country_id":null,"tribes":null,"education":null,"family_status":null,"other_languages":null,"bio":null,"interests":null,"religion":null,"have_kids":null,"instagram_link":null,"tiktok_link":null,"linkedin_link":null,"profile_image":null,"email_verified":null,"status":"Active","latitude":"0","longitude":"0"}
/// success : true
/// code : 200

class GetProfile {
  GetProfile({
    this.msg,
    this.data,
    this.success,
    this.code,
  });

  GetProfile.fromJson(dynamic json) {
    msg = json['msg'];
    data = json['data'] != null ? UserDto.fromJson(json['data']) : null;
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  UserDto? data;
  bool? success;
  num? code;
  GetProfile copyWith({
    String? msg,
    UserDto? data,
    bool? success,
    num? code,
  }) =>
      GetProfile(
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
