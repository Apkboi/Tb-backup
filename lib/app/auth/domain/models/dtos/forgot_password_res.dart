/// msg : "Password request sent successfully!"
/// data : null
/// success : true
/// code : 200

class ForgotPasswordRes {
  ForgotPasswordRes({
      this.msg, 
      this.data, 
      this.success, 
      this.code,});

  ForgotPasswordRes.fromJson(dynamic json) {
    msg = json['msg'];
    data = json['data'];
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  dynamic data;
  bool? success;
  num? code;
ForgotPasswordRes copyWith({  String? msg,
  dynamic data,
  bool? success,
  num? code,
}) => ForgotPasswordRes(  msg: msg ?? this.msg,
  data: data ?? this.data,
  success: success ?? this.success,
  code: code ?? this.code,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    map['data'] = data;
    map['success'] = success;
    map['code'] = code;
    return map;
  }

}