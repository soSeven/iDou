/// page : {"total":4,"page":1,"count":4}
/// data : [{"id":27,"encode_id":"63f2We+kPe9Zz9W6Obemdu5PUfcqGSfQVPmYVZXu3Q","avatar":"https://p9-dy-ipv6.byteimg.com/aweme/100x100/bdc7000f94ceed99ba3c.jpeg?from=4010531038","nickname":"tidy123","fans_count":10000,"expires_day":9}]

class DyCategoryDataResponse {
  List<DyCategoryDataBean> _data;

  List<DyCategoryDataBean> get data => _data;

  DyCategoryDataResponse({
      List<DyCategoryDataBean> data}){
    _data = data;
}

  DyCategoryDataResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(DyCategoryDataBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 27
/// encode_id : "63f2We+kPe9Zz9W6Obemdu5PUfcqGSfQVPmYVZXu3Q"
/// avatar : "https://p9-dy-ipv6.byteimg.com/aweme/100x100/bdc7000f94ceed99ba3c.jpeg?from=4010531038"
/// nickname : "tidy123"
/// fans_count : 10000
/// expires_day : 9

class DyCategoryDataBean {
  int _id;
  String _encodeId;
  String _avatar;
  String _nickname;
  int _fansCount;
  int _expiresDay;

  int get id => _id;
  String get encodeId => _encodeId;
  String get avatar => _avatar;
  String get nickname => _nickname;
  int get fansCount => _fansCount;
  int get expiresDay => _expiresDay;

  Data({
      int id, 
      String encodeId, 
      String avatar, 
      String nickname, 
      int fansCount, 
      int expiresDay}){
    _id = id;
    _encodeId = encodeId;
    _avatar = avatar;
    _nickname = nickname;
    _fansCount = fansCount;
    _expiresDay = expiresDay;
}

  DyCategoryDataBean.fromJson(dynamic json) {
    _id = json["id"];
    _encodeId = json["encode_id"];
    _avatar = json["avatar"];
    _nickname = json["nickname"];
    _fansCount = json["fans_count"];
    _expiresDay = json["expires_day"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["encode_id"] = _encodeId;
    map["avatar"] = _avatar;
    map["nickname"] = _nickname;
    map["fans_count"] = _fansCount;
    map["expires_day"] = _expiresDay;
    return map;
  }

}

