/// time_used : 473
/// confidence : 96.46
/// thresholds : {"1e-3":65.3,"1e-5":76.5,"1e-4":71.8}
/// request_id : "1469761507,07174361-027c-46e1-811f-ba0909760b18"

class FaceCompareRes {
  FaceCompareRes({
      this.timeUsed, 
      this.confidence, 
      this.thresholds, 
      this.requestId,});

  FaceCompareRes.fromJson(dynamic json) {
    timeUsed = json['time_used'];
    confidence = json['confidence'];
    thresholds = json['thresholds'] != null ? Thresholds.fromJson(json['thresholds']) : null;
    requestId = json['request_id'];
  }
  num? timeUsed;
  num? confidence;
  Thresholds? thresholds;
  String? requestId;
FaceCompareRes copyWith({  num? timeUsed,
  num? confidence,
  Thresholds? thresholds,
  String? requestId,
}) => FaceCompareRes(  timeUsed: timeUsed ?? this.timeUsed,
  confidence: confidence ?? this.confidence,
  thresholds: thresholds ?? this.thresholds,
  requestId: requestId ?? this.requestId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time_used'] = timeUsed;
    map['confidence'] = confidence;
    if (thresholds != null) {
      map['thresholds'] = thresholds?.toJson();
    }
    map['request_id'] = requestId;
    return map;
  }

}

/// 1e-3 : 65.3
/// 1e-5 : 76.5
/// 1e-4 : 71.8

class Thresholds {
  Thresholds({
      this.e3, 
      this.e5, 
      this.e4,});

  Thresholds.fromJson(dynamic json) {
    e3 = json['1e-3'];
    e5 = json['1e-5'];
    e4 = json['1e-4'];
  }
  num? e3;
  num? e5;
  num? e4;
Thresholds copyWith({  num? e3,
  num? e5,
  num? e4,
}) => Thresholds(  e3: e3 ?? this.e3,
  e5: e5 ?? this.e5,
  e4: e4 ?? this.e4,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['1e-3'] = e3;
    map['1e-5'] = e5;
    map['1e-4'] = e4;
    return map;
  }

}