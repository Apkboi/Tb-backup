import 'package:triberly/app/auth/domain/models/dtos/user_dto.dart';
import 'package:triberly/app/chat/domain/models/dtos/message_model_dto.dart';

/// msg : "Chats retrieved successfully"
/// data : {"pagination_meta":{"current_page":1,"first_page_url":"http://127.0.0.1:8000/api/v1/chats/list?page=1","from":1,"last_page":1,"last_page_url":"http://127.0.0.1:8000/api/v1/chats/list?page=1","next_page_url":null,"path":"http://127.0.0.1:8000/api/v1/chats/list","per_page":15,"prev_page_url":null,"to":1,"total":1,"can_load_more":false},"data":[{"id":1,"participants":[{"id":2,"user":{"id":2,"first_name":"brimly","middle_name":"GreyJoy","last_name":"Stark","email":"greyjoy@gmail.com","phone_no":null,"gender":"Male","username":"brimlys","ref_code":"PtX79jUK","email_verification":false,"selfie_verification":false}}]}]}
/// success : true
/// code : 200

class GetChatsResDto {
  GetChatsResDto({
    this.msg,
    this.callData,
    this.success,
    this.code,
  });

  GetChatsResDto.fromJson(dynamic json) {
    msg = json['msg'];
    callData = json['data'] != null ? CallData.fromJson(json['data']) : null;
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  CallData? callData;
  bool? success;
  num? code;
  GetChatsResDto copyWith({
    String? msg,
    CallData? callData,
    bool? success,
    num? code,
  }) =>
      GetChatsResDto(
        msg: msg ?? this.msg,
        callData: callData ?? this.callData,
        success: success ?? this.success,
        code: code ?? this.code,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    if (callData != null) {
      map['data'] = callData?.toJson();
    }
    map['success'] = success;
    map['code'] = code;
    return map;
  }
}

/// pagination_meta : {"current_page":1,"first_page_url":"http://127.0.0.1:8000/api/v1/chats/list?page=1","from":1,"last_page":1,"last_page_url":"http://127.0.0.1:8000/api/v1/chats/list?page=1","next_page_url":null,"path":"http://127.0.0.1:8000/api/v1/chats/list","per_page":15,"prev_page_url":null,"to":1,"total":1,"can_load_more":false}
/// data : [{"id":1,"participants":[{"id":2,"user":{"id":2,"first_name":"brimly","middle_name":"GreyJoy","last_name":"Stark","email":"greyjoy@gmail.com","phone_no":null,"gender":"Male","username":"brimlys","ref_code":"PtX79jUK","email_verification":false,"selfie_verification":false}}]}]

class CallData {
  CallData({
    this.paginationMeta,
    this.data,
  });

  CallData.fromJson(dynamic json) {
    paginationMeta = json['pagination_meta'] != null
        ? PaginationMeta.fromJson(json['pagination_meta'])
        : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatData.fromJson(v));
      });
    }
  }
  PaginationMeta? paginationMeta;
  List<ChatData>? data;
  CallData copyWith({
    PaginationMeta? paginationMeta,
    List<ChatData>? data,
  }) =>
      CallData(
        paginationMeta: paginationMeta ?? this.paginationMeta,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paginationMeta != null) {
      map['pagination_meta'] = paginationMeta?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// participants : [{"id":2,"user":{"id":2,"first_name":"brimly","middle_name":"GreyJoy","last_name":"Stark","email":"greyjoy@gmail.com","phone_no":null,"gender":"Male","username":"brimlys","ref_code":"PtX79jUK","email_verification":false,"selfie_verification":false}}]

class ChatData {
  ChatData({
    this.id,
    this.participants,
    this.lastMessage,
    this.timestamp,
  });

  ChatData.fromJson(dynamic json) {
    id = json['id'];
    lastMessage = json['lastMessage'];
    timestamp = json['timestamp'];
    if (json['participants'] != null) {
      participants = [];
      json['participants'].forEach((v) {
        participants?.add(Participants.fromJson(v));
      });
    }
  }
  num? id;
  String? lastMessage;
  String? timestamp;
  List<Participants>? participants;
  ChatData copyWith({
    num? id,
    String? lastMessage,
    String? timestamp,
    List<Participants>? participants,
  }) =>
      ChatData(
        id: id ?? this.id,
        lastMessage: lastMessage ?? this.lastMessage,
        timestamp: timestamp ?? this.timestamp,
        participants: participants ?? this.participants,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['lastMessage'] = lastMessage;
    map['timestamp'] = timestamp;
    if (participants != null) {
      map['participants'] = participants?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'ChatData{id: $id, lastMessage: $lastMessage, participants: $participants}';
  }
}

/// id : 2
/// user : {"id":2,"first_name":"brimly","middle_name":"GreyJoy","last_name":"Stark","email":"greyjoy@gmail.com","phone_no":null,"gender":"Male","username":"brimlys","ref_code":"PtX79jUK","email_verification":false,"selfie_verification":false}

class Participants {
  Participants({
    this.id,
    this.user,
  });

  Participants.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
  }
  num? id;
  UserDto? user;
  Participants copyWith({
    num? id,
    UserDto? user,
  }) =>
      Participants(
        id: id ?? this.id,
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

/// id : 2
/// first_name : "brimly"
/// middle_name : "GreyJoy"
/// last_name : "Stark"
/// email : "greyjoy@gmail.com"
/// phone_no : null
/// gender : "Male"
/// username : "brimlys"
/// ref_code : "PtX79jUK"
/// email_verification : false
/// selfie_verification : false

/// current_page : 1
/// first_page_url : "http://127.0.0.1:8000/api/v1/chats/list?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "http://127.0.0.1:8000/api/v1/chats/list?page=1"
/// next_page_url : null
/// path : "http://127.0.0.1:8000/api/v1/chats/list"
/// per_page : 15
/// prev_page_url : null
/// to : 1
/// total : 1
/// can_load_more : false

class PaginationMeta {
  PaginationMeta({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
    this.canLoadMore,
  });

  PaginationMeta.fromJson(dynamic json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    canLoadMore = json['can_load_more'];
  }
  num? currentPage;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  num? perPage;
  dynamic prevPageUrl;
  num? to;
  num? total;
  bool? canLoadMore;
  PaginationMeta copyWith({
    num? currentPage,
    String? firstPageUrl,
    num? from,
    num? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    num? perPage,
    dynamic prevPageUrl,
    num? to,
    num? total,
    bool? canLoadMore,
  }) =>
      PaginationMeta(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    map['can_load_more'] = canLoadMore;
    return map;
  }
}
