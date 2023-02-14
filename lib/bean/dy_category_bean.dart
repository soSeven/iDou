/// id : 1
/// encode_id : "dd61nwl7ts/7X2N339eGLPNsIwt+ejwZLA2L406Y"
/// name : "情感"

class DyCategoryBean {
  int _id;
  String _encodeId;
  String _name;

  int get id => _id;
  String get encodeId => _encodeId;
  String get name => _name;

  DyCategoryBean({
      int id, 
      String encodeId, 
      String name}){
    _id = id;
    _encodeId = encodeId;
    _name = name;
}

  DyCategoryBean.fromJson(dynamic json) {
    _id = json["id"];
    _encodeId = json["encode_id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["encode_id"] = _encodeId;
    map["name"] = _name;
    return map;
  }

}