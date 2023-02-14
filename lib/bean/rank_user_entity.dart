/// date : "2020-07-08"
/// list : [{"id":26,"nickname":"zouying","avatar":"http://api-duoduo.com/static/index/image/default.png","income":"317.90","rank":1,"encode_id":"c542lsT22938R1nLcq5k+yvuIH2/GbyTUWwGIqOQ/g"},{"id":27,"nickname":"俊成","avatar":"http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKicn54kls9iao4548VqicNCicibFia75rKQZmq1x0T0PfTBjh4zicZR0Nhor6ZjjNyUOeiaIWb5v83aK6Z0w/132","income":"442.57","rank":2,"encode_id":"60c62jElcsvyjRXkequIwntyus3JFjDrbp01TzGM/A"}]

class UserRankBean {
  String _date;
  List<RankUserEntity> _list;

  String get date => _date;
  List<RankUserEntity> get list => _list;

  UserRankBean({
      String date,
    List<RankUserEntity> list}){
    _date = date;
    _list = list;
}

  UserRankBean.fromJson(dynamic json) {
    _date = json["date"];
    if (json["list"] != null) {
      _list = [];
      json["list"].forEach((v) {
        _list.add(RankUserEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["date"] = _date;
    if (_list != null) {
      map["list"] = _list.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 26
/// nickname : "zouying"
/// avatar : "http://api-duoduo.com/static/index/image/default.png"
/// income : "317.90"
/// rank : 1
/// encode_id : "c542lsT22938R1nLcq5k+yvuIH2/GbyTUWwGIqOQ/g"

class RankUserEntity {
  int _id;
  String _nickname;
  String _avatar;
  String _income;
  int _rank;
  String _encodeId;

  int get id => _id;
  String get nickname => _nickname;
  String get avatar => _avatar;
  String get income => _income;
  int get rank => _rank;
  String get encodeId => _encodeId;

  RankUserEntity({
      int id, 
      String nickname, 
      String avatar, 
      String income, 
      int rank, 
      String encodeId}){
    _id = id;
    _nickname = nickname;
    _avatar = avatar;
    _income = income;
    _rank = rank;
    _encodeId = encodeId;
}

  RankUserEntity.fromJson(dynamic json) {
    _id = json["id"];
    _nickname = json["nickname"];
    _avatar = json["avatar"];
    _income = json["income"];
    _rank = json["rank"];
    _encodeId = json["encodeId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["nickname"] = _nickname;
    map["avatar"] = _avatar;
    map["income"] = _income;
    map["rank"] = _rank;
    map["encodeId"] = _encodeId;
    return map;
  }

}