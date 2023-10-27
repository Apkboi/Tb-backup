/// intent : "friendship"
/// connect_with : "anyone"
/// languagues : "english"
/// tribes : "ighala"
/// origin_country_id : 160
/// residence_country_id : 160
/// from_age : 25
/// to_age : 40
/// with_lat_long : true

class SearchConnectionsReqDto {
  SearchConnectionsReqDto({
    this.intent,
    this.connectWith,
    this.languagues,
    this.tribes,
    this.originCountryId,
    this.residenceCountryId,
    this.fromAge,
    this.toAge,
    this.withLatLong,
    this.faith,
  });

  SearchConnectionsReqDto.fromJson(dynamic json) {
    intent = json['intent'];
    connectWith = json['connect_with'];
    languagues = json['languagues'];
    tribes = json['tribes'];
    originCountryId = json['origin_country_id'];
    residenceCountryId = json['residence_country_id'];
    fromAge = json['from_age'];
    toAge = json['to_age'];
    withLatLong = json['with_lat_long'];
    faith = json['faith'];
  }
  String? intent;
  String? connectWith;
  String? languagues;
  String? tribes;
  String? faith;
  num? originCountryId;
  num? residenceCountryId;
  num? fromAge;
  num? toAge;
  bool? withLatLong;
  SearchConnectionsReqDto copyWith({
    String? intent,
    String? connectWith,
    String? languagues,
    String? faith,
    String? tribes,
    num? originCountryId,
    num? residenceCountryId,
    num? fromAge,
    num? toAge,
    bool? withLatLong,
  }) =>
      SearchConnectionsReqDto(
        intent: intent ?? this.intent,
        faith: faith ?? this.faith,
        connectWith: connectWith ?? this.connectWith,
        languagues: languagues ?? this.languagues,
        tribes: tribes ?? this.tribes,
        originCountryId: originCountryId ?? this.originCountryId,
        residenceCountryId: residenceCountryId ?? this.residenceCountryId,
        fromAge: fromAge ?? this.fromAge,
        toAge: toAge ?? this.toAge,
        withLatLong: withLatLong ?? this.withLatLong,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (intent != null) map['intent'] = intent;
    if (faith != null && faith!.isNotEmpty) map['faith'] = faith;
    if (connectWith != null && connectWith!.isNotEmpty) {
      map['connect_with'] = connectWith;
    }
    if (languagues != null) map['languagues'] = languagues;
    if (tribes != null) map['tribes'] = tribes;
    if (originCountryId != null) map['origin_country_id'] = originCountryId;
    if (residenceCountryId != null) {
      map['residence_country_id'] = residenceCountryId;
    }
    if (fromAge != null) map['from_age'] = fromAge;
    if (toAge != null) map['to_age'] = toAge;
    if (withLatLong != null) map['with_lat_long'] = withLatLong;
    return map;
  }
}
