/// first_name : "Tamun"
/// middle_name : "Tas"
/// last_name : "das"
/// phone : "080851249688"
/// email : "f@mailinator.com"
/// gender : "Male"
/// status : "Active"
/// password : "password"
/// password_confirmation : "password"
/// longitude : 0.00
/// latitude : 0.00

class SignUpReqDto {
  SignUpReqDto({
    this.firstName,
    this.middleName,
    this.lastName,
    this.phone,
    this.email,
    this.gender,
    this.status,
    this.password,
    this.passwordConfirmation,
    this.longitude,
    this.latitude,
  });

  @override
  String toString() {
    return 'SignUpReqDto{firstName: $firstName, middleName: $middleName, lastName: $lastName, phone: $phone, email: $email, gender: $gender, status: $status, password: $password, passwordConfirmation: $passwordConfirmation, longitude: $longitude, latitude: $latitude}';
  }

  SignUpReqDto.fromJson(dynamic json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    status = json['status'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  String? firstName;
  String? middleName;
  String? lastName;
  String? phone;
  String? email;
  String? gender;
  String? status;
  String? password;
  String? passwordConfirmation;
  num? longitude;
  num? latitude;
  SignUpReqDto copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? phone,
    String? email,
    String? gender,
    String? status,
    String? password,
    String? passwordConfirmation,
    num? longitude,
    num? latitude,
  }) =>
      SignUpReqDto(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        status: status ?? this.status,
        password: password ?? this.password,
        passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['middle_name'] = middleName;
    map['last_name'] = lastName;
    map['phone'] = phone;
    map['email'] = email;
    map['gender'] = gender;
    map['status'] = status ?? "Active";
    map['password'] = password;
    map['password_confirmation'] = passwordConfirmation;
    map['longitude'] = longitude ?? 0;
    map['latitude'] = latitude ?? 0;
    return map;
  }
}
