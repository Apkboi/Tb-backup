/// email : "f@mailinator.com"
/// password : "password"

class SignInReqDto {
  SignInReqDto({
    this.email,
    this.password,
  });

  SignInReqDto.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }
  String? email;
  String? password;
  SignInReqDto copyWith({
    String? email,
    String? password,
  }) =>
      SignInReqDto(
        email: email ?? this.email,
        password: password ?? this.password,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;

    if (password != null) map['password'] = password;
    return map;
  }
}
