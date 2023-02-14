class AppletClassfyBean {
  String name;
  int id;
  String encode_id;
  bool tag = false;

  AppletClassfyBean.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        encode_id = json['encode_id'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'encode_id': encode_id,
  };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"name\":\"$name\"");
    sb.write(",\"id\":$id");
    sb.write(",\"encode_id\":\"$encode_id\"");
    sb.write('}');
    return sb.toString();
  }
}