/// code : "3726"
/// type : "account_setup"

class VerifyOtpReqDto {
  VerifyOtpReqDto({
    this.code,
    this.type,
  });

  VerifyOtpReqDto.fromJson(dynamic json) {
    code = json['code'];
    type = json['type'];
  }
  String? code;
  String? type;
  VerifyOtpReqDto copyWith({
    String? code,
    String? type,
  }) =>
      VerifyOtpReqDto(
        code: code ?? this.code,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['type'] = type;
    return map;
  }
}
