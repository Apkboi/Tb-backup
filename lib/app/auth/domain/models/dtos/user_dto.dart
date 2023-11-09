class UserDto {
  dynamic id;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  String? phoneNo;
  dynamic gender;
  dynamic username;
  dynamic refCode;
  bool? emailVerification;
  bool? selfieVerification;
  String? dob;
  dynamic profession;
  dynamic relationshipStatus;
  dynamic intent;
  dynamic homeAddress;
  dynamic originCityId;
  dynamic originStateId;
  dynamic originCountryId;
  ResidenceCountryId? residenceCountryId;
  dynamic town;
  dynamic tribes;
  dynamic education;
  dynamic familyStatus;
  dynamic otherLanguages;
  dynamic bio;
  dynamic interests;
  dynamic religion;
  dynamic haveKids;
  dynamic instagramLink;
  dynamic tiktokLink;
  dynamic linkedinLink;
  dynamic profileImage;
  List<OtherImages>? otherImages;
  dynamic emailVerified;
  String? status;
  num? latitude;
  num? longitude;
  dynamic profileCompletion;

  UserDto({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNo,
    this.gender,
    this.username,
    this.refCode,
    this.emailVerification,
    this.selfieVerification,
    this.dob,
    this.profession,
    this.relationshipStatus,
    this.intent,
    this.homeAddress,
    this.originCityId,
    this.originStateId,
    this.originCountryId,
    this.residenceCountryId,
    this.town,
    this.tribes,
    this.education,
    this.familyStatus,
    this.otherLanguages,
    this.bio,
    this.interests,
    this.religion,
    this.haveKids,
    this.instagramLink,
    this.tiktokLink,
    this.linkedinLink,
    this.profileImage,
    this.otherImages,
    this.emailVerified,
    this.status,
    this.latitude,
    this.longitude,
    this.profileCompletion,
  });

  UserDto.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    gender = json['gender'];
    username = json['username'];
    refCode = json['ref_code'];
    emailVerification = json['email_verification'];
    selfieVerification = json['selfie_verification'];
    dob = json['dob'];
    profession = json['profession'];
    relationshipStatus = json['relationship_status'];
    intent = json['intent'];
    homeAddress = json['home_address'];
    originCityId = json['origin_city_id'];
    originStateId = json['origin_state_id'];
    originCountryId = json['origin_country_id'];
    residenceCountryId = json['residence_country_id'] != null
        ? ResidenceCountryId.fromJson(json['residence_country_id'])
        : null;
    town = json['town'];
    tribes = json['tribes'];
    education = json['education'];
    familyStatus = json['family_status'];
    otherLanguages = json['other_languages'];
    bio = json['bio'];
    interests = json['interests'];
    religion = json['religion'];
    haveKids = json['have_kids'];
    instagramLink = json['instagram_link'];
    tiktokLink = json['tiktok_link'];
    linkedinLink = json['linkedin_link'];
    profileImage = json['profile_image'];
    if (json['other_images'] != null) {
      otherImages = [];
      json['other_images'].forEach((v) {
        otherImages?.add(OtherImages.fromJson(v));
      });
    }
    emailVerified = json['email_verified'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    profileCompletion = json['profile_completion'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['middle_name'] = middleName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['gender'] = gender;
    map['username'] = username;
    map['ref_code'] = refCode;
    map['email_verification'] = emailVerification;
    map['selfie_verification'] = selfieVerification;
    map['dob'] = dob;
    map['profession'] = profession;
    map['relationship_status'] = relationshipStatus;
    map['intent'] = intent;
    map['home_address'] = homeAddress;
    map['origin_city_id'] = originCityId;
    map['origin_state_id'] = originStateId;
    map['origin_country_id'] = originCountryId;
    map['residence_country_id'] = residenceCountryId?.toJson();
    map['town'] = town;
    map['tribes'] = tribes;
    map['education'] = education;
    map['family_status'] = familyStatus;
    map['other_languages'] = otherLanguages;
    map['bio'] = bio;
    map['interests'] = interests;
    map['religion'] = religion;
    map['have_kids'] = haveKids;
    map['instagram_link'] = instagramLink;
    map['tiktok_link'] = tiktokLink;
    map['linkedin_link'] = linkedinLink;
    map['profile_image'] = profileImage;
    if (otherImages != null) {
      map['other_images'] = otherImages?.map((v) => v.toJson()).toList();
    }
    map['email_verified'] = emailVerified;
    map['status'] = status;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['profile_completion'] = profileCompletion;
    return map;
  }

  int profilePercentage() {
    var allFields = toJson().values;
    int totalFields = allFields.length;
    int nonNullCount = allFields.where((value) => value != null).length;

    double percentage = (nonNullCount / totalFields) * 100.0;

    return percentage.round();
  }
}

class MotherTongue {
  final num? id;
  final String? name;

  MotherTongue({
    this.id,
    this.name,
  });

  factory MotherTongue.fromJson(dynamic json) {
    return MotherTongue(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class ResidenceCountryId {
  final num? id;
  final String? name;

  ResidenceCountryId({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;

    return map;
  }

  factory ResidenceCountryId.fromJson(dynamic json) {
    return ResidenceCountryId(
      id: json['id'],
      name: json['name'],
    );
  }
}

class OtherImages {
  final num? id;
  final String? url;
  final String? type;

  OtherImages({
    this.id,
    this.url,
    this.type,
  });

  factory OtherImages.fromJson(dynamic json) {
    return OtherImages(
      id: json['id'],
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['type'] = type;
    return map;
  }
}
