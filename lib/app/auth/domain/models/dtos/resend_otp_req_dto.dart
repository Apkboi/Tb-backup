/// email : "stark@gmail.com"
/// type : "password_reset"

class ResendOtpReqDto {
  ResendOtpReqDto({
      this.email, 
      this.type,});

  ResendOtpReqDto.fromJson(dynamic json) {
    email = json['email'];
    type = json['type'];
  }
  String? email;
  String? type;
ResendOtpReqDto copyWith({  String? email,
  String? type,
}) => ResendOtpReqDto(  email: email ?? this.email,
  type: type ?? this.type,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['type'] = type;
    return map;
  }

}