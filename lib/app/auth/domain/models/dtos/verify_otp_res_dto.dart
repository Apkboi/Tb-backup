/// msg : "OTP verified successfully"
/// data : {"hash":"eyJpdiI6IkJQSW9jbjF2QzdRRDhpK09Eb1Q5UGc9PSIsInZhbHVlIjoiZ0hqNFI5TUNkQVB5ZWhTa1NVdGdkUT09IiwibWFjIjoiYTE3ODY4ZTZlZjg2YmNlZThkODYyYzNjOWFlZDQ3OWNjZjMzNzYzYjU5MWEyNjhmOTE4ODUxMmMwZTI3M2ExOSIsInRhZyI6IiJ9"}
/// success : true
/// code : 200

class VerifyOtpResDto {
  VerifyOtpResDto({
      this.msg, 
      this.data, 
      this.success, 
      this.code,});

  VerifyOtpResDto.fromJson(dynamic json) {
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  Data? data;
  bool? success;
  num? code;
VerifyOtpResDto copyWith({  String? msg,
  Data? data,
  bool? success,
  num? code,
}) => VerifyOtpResDto(  msg: msg ?? this.msg,
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

/// hash : "eyJpdiI6IkJQSW9jbjF2QzdRRDhpK09Eb1Q5UGc9PSIsInZhbHVlIjoiZ0hqNFI5TUNkQVB5ZWhTa1NVdGdkUT09IiwibWFjIjoiYTE3ODY4ZTZlZjg2YmNlZThkODYyYzNjOWFlZDQ3OWNjZjMzNzYzYjU5MWEyNjhmOTE4ODUxMmMwZTI3M2ExOSIsInRhZyI6IiJ9"

class Data {
  Data({
      this.hash,});

  Data.fromJson(dynamic json) {
    hash = json['hash'];
  }
  String? hash;
Data copyWith({  String? hash,
}) => Data(  hash: hash ?? this.hash,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hash'] = hash;
    return map;
  }

}