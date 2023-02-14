class HotVideoBean {
  String itemId;
  String title;
  String cover;
  String shareUrl;
  int hotLevel;
  dynamic hotLevelStr;

  HotVideoBean(
      {this.itemId,
      this.title,
      this.cover,
      this.shareUrl,
      this.hotLevel,
      this.hotLevelStr});

  HotVideoBean.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    title = json['title'];
    cover = json['cover'];
    shareUrl = json['share_url'];
    hotLevel = json['hot_level'];
    hotLevelStr = json['hot_level_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['share_url'] = this.shareUrl;
    data['hot_level'] = this.hotLevel;
    data['hot_level_str'] = this.hotLevelStr;
    return data;
  }
}
