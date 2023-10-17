/// email : "stark@gmail.com"
/// phone_number : "09041123030"

class ForgotPasswordReqDto {
  ForgotPasswordReqDto({
    this.email,
    this.phoneNumber,
  });

  ForgotPasswordReqDto.fromJson(dynamic json) {
    email = json['email'];
    phoneNumber = json['phone_number'];
  }
  String? email;
  String? phoneNumber;
  ForgotPasswordReqDto copyWith({
    String? email,
    String? phoneNumber,
  }) =>
      ForgotPasswordReqDto(
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (email != null) map['email'] = email;
    if (phoneNumber != null) map['phone_number'] = phoneNumber;
    return map;
  }
}
