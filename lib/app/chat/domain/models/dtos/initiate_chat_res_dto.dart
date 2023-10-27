import 'package:triberly/app/chat/domain/models/dtos/get_chats_res_dto.dart';

/// msg : "Chat initiated successfully"
/// data : {"id":1,"participants":[{"id":2,"user":{"id":2,"first_name":"brimly","middle_name":"GreyJoy","last_name":"Stark","email":"greyjoy@gmail.com","phone_no":null,"gender":"Male","username":"brimlys","ref_code":"PtX79jUK","email_verification":false,"selfie_verification":false}}]}
/// success : true
/// code : 200

class InitiateChatResDto {
  InitiateChatResDto({
    this.msg,
    this.data,
    this.success,
    this.code,
  });

  InitiateChatResDto.fromJson(dynamic json) {
    msg = json['msg'];
    data = json['data'] != null ? ChatData.fromJson(json['data']) : null;
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  ChatData? data;
  bool? success;
  num? code;
  InitiateChatResDto copyWith({
    String? msg,
    ChatData? data,
    bool? success,
    num? code,
  }) =>
      InitiateChatResDto(
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
