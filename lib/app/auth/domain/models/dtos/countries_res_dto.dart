/// msg : "Countries retrieved successfully"
/// data : {"pagination_meta":{"current_page":1,"first_page_url":"https://triberly.prodevs.io/api/v1/location/countries?page=1","from":1,"last_page":13,"last_page_url":"https://triberly.prodevs.io/api/v1/location/countries?page=13","next_page_url":"https://triberly.prodevs.io/api/v1/location/countries?page=2","path":"https://triberly.prodevs.io/api/v1/location/countries","per_page":20,"prev_page_url":null,"to":20,"total":246,"can_load_more":true},"data":[{"id":1,"name":"Afghanistan"},{"id":2,"name":"Albania"},{"id":3,"name":"Algeria"},{"id":4,"name":"American Samoa"},{"id":5,"name":"Andorra"},{"id":6,"name":"Angola"},{"id":7,"name":"Anguilla"},{"id":8,"name":"Antarctica"},{"id":9,"name":"Antigua And Barbuda"},{"id":10,"name":"Argentina"},{"id":11,"name":"Armenia"},{"id":12,"name":"Aruba"},{"id":13,"name":"Australia"},{"id":14,"name":"Austria"},{"id":15,"name":"Azerbaijan"},{"id":16,"name":"Bahamas The"},{"id":17,"name":"Bahrain"},{"id":18,"name":"Bangladesh"},{"id":19,"name":"Barbados"},{"id":20,"name":"Belarus"}]}
/// success : true
/// code : 200

class CountriesResDto {
  CountriesResDto({
    this.msg,
    this.callData,
    this.success,
    this.code,
  });

  CountriesResDto.fromJson(dynamic json) {
    msg = json['msg'];
    callData = json['data'] != null ? CallData.fromJson(json['data']) : null;
    success = json['success'];
    code = json['code'];
  }
  String? msg;
  CallData? callData;
  bool? success;
  num? code;
  CountriesResDto copyWith({
    String? msg,
    CallData? callData,
    bool? success,
    num? code,
  }) =>
      CountriesResDto(
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

/// pagination_meta : {"current_page":1,"first_page_url":"https://triberly.prodevs.io/api/v1/location/countries?page=1","from":1,"last_page":13,"last_page_url":"https://triberly.prodevs.io/api/v1/location/countries?page=13","next_page_url":"https://triberly.prodevs.io/api/v1/location/countries?page=2","path":"https://triberly.prodevs.io/api/v1/location/countries","per_page":20,"prev_page_url":null,"to":20,"total":246,"can_load_more":true}
/// data : [{"id":1,"name":"Afghanistan"},{"id":2,"name":"Albania"},{"id":3,"name":"Algeria"},{"id":4,"name":"American Samoa"},{"id":5,"name":"Andorra"},{"id":6,"name":"Angola"},{"id":7,"name":"Anguilla"},{"id":8,"name":"Antarctica"},{"id":9,"name":"Antigua And Barbuda"},{"id":10,"name":"Argentina"},{"id":11,"name":"Armenia"},{"id":12,"name":"Aruba"},{"id":13,"name":"Australia"},{"id":14,"name":"Austria"},{"id":15,"name":"Azerbaijan"},{"id":16,"name":"Bahamas The"},{"id":17,"name":"Bahrain"},{"id":18,"name":"Bangladesh"},{"id":19,"name":"Barbados"},{"id":20,"name":"Belarus"}]

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
        data?.add(CountriesData.fromJson(v));
      });
    }
  }
  PaginationMeta? paginationMeta;
  List<CountriesData>? data;
  CallData copyWith({
    PaginationMeta? paginationMeta,
    List<CountriesData>? data,
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
/// name : "Afghanistan"

class CountriesData {
  CountriesData({
    this.id,
    this.name,
  });

  CountriesData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
  CountriesData copyWith({
    num? id,
    String? name,
  }) =>
      CountriesData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

/// current_page : 1
/// first_page_url : "https://triberly.prodevs.io/api/v1/location/countries?page=1"
/// from : 1
/// last_page : 13
/// last_page_url : "https://triberly.prodevs.io/api/v1/location/countries?page=13"
/// next_page_url : "https://triberly.prodevs.io/api/v1/location/countries?page=2"
/// path : "https://triberly.prodevs.io/api/v1/location/countries"
/// per_page : 20
/// prev_page_url : null
/// to : 20
/// total : 246
/// can_load_more : true

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
  String? nextPageUrl;
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
    String? nextPageUrl,
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
