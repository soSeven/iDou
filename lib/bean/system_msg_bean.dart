class SystemMsgBean {
  int id;
  String title;
  String create_time;
  String encode_id;
  String h5_url;

  SystemMsgBean.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        create_time = json['create_time'],
        h5_url = json['h5_url'],
        encode_id = json['encode_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'create_time': create_time,
        'encode_id': encode_id,
        'h5_url': h5_url
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"id\":$id");
    sb.write(",\"create_time\":\"$create_time\"");
    sb.write(",\"encode_id\":\"$encode_id\"");
    sb.write(",\"h5_url\":\"$h5_url\"");
    sb.write('}');
    return sb.toString();
  }
}
