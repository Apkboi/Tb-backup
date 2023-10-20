/// msg : "Images uploaded successfully"
/// data : [{"id":1,"url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU","type":"Photo"},{"id":2,"url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU","type":"Photo"},{"id":3,"url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU","type":"Photo"}]
/// success : true
/// code : 200

class UpdateOtherPhotosResDto {
  UpdateOtherPhotosResDto({
      this.msg, 
      this.data, 
      this.success, 
      this.code,});

  UpdateOtherPhotosResDto.fromJson(dynamic json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  List<Data>? data;
  bool? success;
  num? code;
UpdateOtherPhotosResDto copyWith({  String? msg,
  List<Data>? data,
  bool? success,
  num? code,
}) => UpdateOtherPhotosResDto(  msg: msg ?? this.msg,
  data: data ?? this.data,
  success: success ?? this.success,
  code: code ?? this.code,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['success'] = success;
    map['code'] = code;
    return map;
  }

}

/// id : 1
/// url : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU"
/// type : "Photo"

class Data {
  Data({
      this.id, 
      this.url, 
      this.type,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    type = json['type'];
  }
  num? id;
  String? url;
  String? type;
Data copyWith({  num? id,
  String? url,
  String? type,
}) => Data(  id: id ?? this.id,
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