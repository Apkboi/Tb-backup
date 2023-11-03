import 'package:triberly/app/auth/domain/models/dtos/update_profile_res_dto.dart';

class UserDto {
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
  }
  dynamic? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? gender;
  String? username;
  String? refCode;
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
  String? emailVerified;
  String? status;
  num? latitude;
  num? longitude;
  UserDto copyWith({
    num? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneNo,
    String? gender,
    String? username,
    String? refCode,
    bool? emailVerification,
    bool? selfieVerification,
    dynamic dob,
    dynamic profession,
    dynamic relationshipStatus,
    dynamic intent,
    dynamic homeAddress,
    dynamic originCityId,
    dynamic originStateId,
    dynamic originCountryId,
    dynamic residenceCountryId,
    dynamic tribes,
    dynamic education,
    dynamic familyStatus,
    dynamic otherLanguages,
    dynamic bio,
    dynamic interests,
    dynamic religion,
    dynamic haveKids,
    dynamic instagramLink,
    dynamic tiktokLink,
    dynamic linkedinLink,
    dynamic profileImage,
    List<OtherImages>? otherImages,
    String? emailVerified,
    String? status,
    num? latitude,
    num? longitude,
  }) =>
      UserDto(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        gender: gender ?? this.gender,
        username: username ?? this.username,
        refCode: refCode ?? this.refCode,
        emailVerification: emailVerification ?? this.emailVerification,
        selfieVerification: selfieVerification ?? this.selfieVerification,
        dob: dob ?? this.dob,
        profession: profession ?? this.profession,
        relationshipStatus: relationshipStatus ?? this.relationshipStatus,
        intent: intent ?? this.intent,
        homeAddress: homeAddress ?? this.homeAddress,
        originCityId: originCityId ?? this.originCityId,
        originStateId: originStateId ?? this.originStateId,
        originCountryId: originCountryId ?? this.originCountryId,
        residenceCountryId: residenceCountryId ?? this.residenceCountryId,
        tribes: tribes ?? this.tribes,
        education: education ?? this.education,
        familyStatus: familyStatus ?? this.familyStatus,
        otherLanguages: otherLanguages ?? this.otherLanguages,
        bio: bio ?? this.bio,
        interests: interests ?? this.interests,
        religion: religion ?? this.religion,
        haveKids: haveKids ?? this.haveKids,
        instagramLink: instagramLink ?? this.instagramLink,
        tiktokLink: tiktokLink ?? this.tiktokLink,
        linkedinLink: linkedinLink ?? this.linkedinLink,
        profileImage: profileImage ?? this.profileImage,
        otherImages: otherImages ?? this.otherImages,
        emailVerified: emailVerified ?? this.emailVerified,
        status: status ?? this.status,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
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
    map['residence_country_id'] = residenceCountryId;
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
    return map;
  }

  @override
  String toString() {
    return 'UserDto{id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, email: $email, phoneNo: $phoneNo, gender: $gender, username: $username, refCode: $refCode, emailVerification: $emailVerification, selfieVerification: $selfieVerification, dob: $dob, profession: $profession, relationshipStatus: $relationshipStatus, intent: $intent, homeAddress: $homeAddress, originCityId: $originCityId, originStateId: $originStateId, originCountryId: $originCountryId, residenceCountryId: $residenceCountryId, tribes: $tribes, education: $education, familyStatus: $familyStatus, otherLanguages: $otherLanguages, bio: $bio, interests: $interests, religion: $religion, haveKids: $haveKids, instagramLink: $instagramLink, tiktokLink: $tiktokLink, linkedinLink: $linkedinLink, profileImage: $profileImage, otherImages: $otherImages, emailVerified: $emailVerified, status: $status, latitude: $latitude, longitude: $longitude}';
  }
}

/// id : 1
/// url : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU"
/// type : "Photo"

class OtherImages {
  OtherImages({
    this.id,
    this.url,
    this.type,
  });

  OtherImages.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    type = json['type'];
  }
  num? id;
  String? url;
  String? type;
  OtherImages copyWith({
    num? id,
    String? url,
    String? type,
  }) =>
      OtherImages(
        id: id ?? this.id,
        url: url ?? this.url,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['type'] = type;
    return map;
  }
}
