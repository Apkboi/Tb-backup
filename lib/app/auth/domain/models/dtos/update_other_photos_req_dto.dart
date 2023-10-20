/// images : ["https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDWj9w21gJI5mcQ4yTwg6cG1fgI9YGmMqSKA&usqp=CAU"]

class UpdateOtherPhotosReqDto {
  UpdateOtherPhotosReqDto({
      this.images,});

  UpdateOtherPhotosReqDto.fromJson(dynamic json) {
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  List<String>? images;
UpdateOtherPhotosReqDto copyWith({  List<String>? images,
}) => UpdateOtherPhotosReqDto(  images: images ?? this.images,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['images'] = images;
    return map;
  }

}