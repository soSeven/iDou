class BannerBean {
  String title;
  int id;
  String url;
  String source_url;
  String encode_id;

  BannerBean.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'],
        url = json['url'],
        encode_id = json['encode_id'],
        source_url = json['source_url'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'url': url,
        'source_url': source_url,
        'encode_id': encode_id,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"id\":$id");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"source_url\":\"$source_url\"");
    sb.write(",\"encode_id\":\"$encode_id\"");
    sb.write('}');
    return sb.toString();
  }
}
