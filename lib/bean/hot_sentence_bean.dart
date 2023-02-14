class HotSentenceBean {
  int hotLevel;
  String hotLevelStr;
  String sentence;

  HotSentenceBean({this.hotLevel, this.hotLevelStr, this.sentence});

  HotSentenceBean.fromJson(Map<String, dynamic> json) {
    hotLevel = json['hot_level'];
    hotLevelStr = json['hot_level_str'];
    sentence = json['sentence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hot_level'] = this.hotLevel;
    data['hot_level_str'] = this.hotLevelStr;
    data['sentence'] = this.sentence;
    return data;
  }
}
