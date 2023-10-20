/// verification_image : ""
/// first_name : "Ned"
/// middle_name : ""
/// last_name : "Stark"
/// phone : ""
/// profile_image : ""
/// origin_city_id : 0
/// origin_state_id : 0
/// origin_country_id : 0
/// residence_country_id : 160
/// tribes : ""
/// bio : ""
/// profession : ""
/// family_status : ""
/// intent : ""
/// interests : ""
/// mother_tongue : ""
/// other_languages : ""
/// education : ""
/// instagram_link : ""
/// tiktok_link : ""
/// linkedin_link : ""
/// latitude : 6.5244
/// longitude : 3.3792

class UpdateProfileReqDto {
  UpdateProfileReqDto({
    this.verificationImage,
    this.firstName,
    this.middleName,
    this.lastName,
    this.phone,
    this.profileImage,
    this.originCityId,
    this.originStateId,
    this.originCountryId,
    this.residenceCountryId,
    this.tribes,
    this.bio,
    this.dob,
    this.profession,
    this.familyStatus,
    this.intent,
    this.interests,
    this.motherTongue,
    this.otherLanguages,
    this.education,
    this.instagramLink,
    this.tiktokLink,
    this.linkedinLink,
    this.latitude,
    this.longitude,
  });

  UpdateProfileReqDto.fromJson(dynamic json) {
    verificationImage = json['verification_image'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    profileImage = json['profile_image'];
    originCityId = json['origin_city_id'];
    originStateId = json['origin_state_id'];
    originCountryId = json['origin_country_id'];
    residenceCountryId = json['residence_country_id'];
    tribes = json['tribes'];
    bio = json['bio'];
    profession = json['profession'];
    familyStatus = json['family_status'];
    dob = json['dob'];
    intent = json['intent'];
    interests = json['interests'];
    motherTongue = json['mother_tongue'];
    otherLanguages = json['other_languages'];
    education = json['education'];
    instagramLink = json['instagram_link'];
    tiktokLink = json['tiktok_link'];
    linkedinLink = json['linkedin_link'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? verificationImage;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phone;
  String? profileImage;
  String? dob;
  num? originCityId;
  num? originStateId;
  num? originCountryId;
  num? residenceCountryId;
  String? tribes;
  String? bio;
  String? profession;
  String? familyStatus;
  String? intent;
  String? interests;
  String? motherTongue;
  String? otherLanguages;
  String? education;
  String? instagramLink;
  String? tiktokLink;
  String? linkedinLink;
  num? latitude;
  num? longitude;
  UpdateProfileReqDto copyWith({
    String? verificationImage,
    String? firstName,
    String? middleName,
    String? lastName,
    String? phone,
    String? profileImage,
    String? dob,
    num? originCityId,
    num? originStateId,
    num? originCountryId,
    num? residenceCountryId,
    String? tribes,
    String? bio,
    String? profession,
    String? familyStatus,
    String? intent,
    String? interests,
    String? motherTongue,
    String? otherLanguages,
    String? education,
    String? instagramLink,
    String? tiktokLink,
    String? linkedinLink,
    num? latitude,
    num? longitude,
  }) =>
      UpdateProfileReqDto(
        verificationImage: verificationImage ?? this.verificationImage,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        dob: dob ?? this.dob,
        phone: phone ?? this.phone,
        profileImage: profileImage ?? this.profileImage,
        originCityId: originCityId ?? this.originCityId,
        originStateId: originStateId ?? this.originStateId,
        originCountryId: originCountryId ?? this.originCountryId,
        residenceCountryId: residenceCountryId ?? this.residenceCountryId,
        tribes: tribes ?? this.tribes,
        bio: bio ?? this.bio,
        profession: profession ?? this.profession,
        familyStatus: familyStatus ?? this.familyStatus,
        intent: intent ?? this.intent,
        interests: interests ?? this.interests,
        motherTongue: motherTongue ?? this.motherTongue,
        otherLanguages: otherLanguages ?? this.otherLanguages,
        education: education ?? this.education,
        instagramLink: instagramLink ?? this.instagramLink,
        tiktokLink: tiktokLink ?? this.tiktokLink,
        linkedinLink: linkedinLink ?? this.linkedinLink,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (verificationImage != null) {
      map['verification_image'] = verificationImage;
    }
    if (firstName != null) map['first_name'] = firstName;
    if (middleName != null) map['middle_name'] = middleName;
    if (lastName != null) map['last_name'] = lastName;
    if (dob != null) map['dob'] = dob;
    if (phone != null) map['phone'] = phone;
    if (profileImage != null) map['profile_image'] = profileImage;
    if (originCityId != null) map['origin_city_id'] = originCityId;
    if (originStateId != null) map['origin_state_id'] = originStateId;
    if (originCountryId != null) map['origin_country_id'] = originCountryId;
    if (residenceCountryId != null) {
      map['residence_country_id'] = residenceCountryId;
    }
    if (tribes != null) map['tribes'] = tribes;
    if (bio != null) map['bio'] = bio;
    if (profession != null) map['profession'] = profession;
    if (familyStatus != null) map['family_status'] = familyStatus;
    if (intent != null) map['intent'] = intent;
    if (interests != null) map['interests'] = interests;
    if (motherTongue != null) map['mother_tongue'] = motherTongue;
    if (otherLanguages != null) map['other_languages'] = otherLanguages;
    if (education != null) map['education'] = education;
    if (instagramLink != null) map['instagram_link'] = instagramLink;
    if (tiktokLink != null) map['tiktok_link'] = tiktokLink;
    if (linkedinLink != null) map['linkedin_link'] = linkedinLink;
    if (latitude != null) map['latitude'] = latitude;
    if (longitude != null) map['longitude'] = longitude;

    return map;
  }
}
