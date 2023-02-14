import 'package:idou/bean/home_applet_classfy_bean.dart';

class AppletBean {
  int id;
  String encodeId;
  String title;
  String shareTitle;
  String thumb;
  String description;
  int yesterdayIncome;
  int spreadNum;
  int commissionRatio;
  int stair1;
  int stair2;
  int stair3;
  int isVip;
  Category category;
  List<Sub> sub;
  int subCount;

  AppletBean(
      {this.id,
        this.encodeId,
        this.title,
        this.shareTitle,
        this.thumb,
        this.description,
        this.yesterdayIncome,
        this.spreadNum,
        this.commissionRatio,
        this.stair1,
        this.stair2,
        this.stair3,
        this.isVip,
        this.category,
        this.sub,
        this.subCount});

  AppletBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encodeId = json['encode_id'];
    title = json['title'];
    shareTitle = json['share_title'];
    thumb = json['thumb'];
    description = json['description'];
    yesterdayIncome = json['yesterday_income'];
    spreadNum = json['spread_num'];
    commissionRatio = json['commission_ratio'];
    stair1 = json['stair_1'];
    stair2 = json['stair_2'];
    stair3 = json['stair_3'];
    isVip = json['is_vip'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['sub'] != null) {
      sub = new List<Sub>();
      json['sub'].forEach((v) {
        sub.add(new Sub.fromJson(v));
      });
    }
    subCount = json['sub_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encode_id'] = this.encodeId;
    data['title'] = this.title;
    data['share_title'] = this.shareTitle;
    data['thumb'] = this.thumb;
    data['description'] = this.description;
    data['yesterday_income'] = this.yesterdayIncome;
    data['spread_num'] = this.spreadNum;
    data['commission_ratio'] = this.commissionRatio;
    data['stair_1'] = this.stair1;
    data['stair_2'] = this.stair2;
    data['stair_3'] = this.stair3;
    data['is_vip'] = this.isVip;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.sub != null) {
      data['sub'] = this.sub.map((v) => v.toJson()).toList();
    }
    data['sub_count'] = this.subCount;
    return data;
  }
}

class Category {
  int id;
  String encodeId;
  String name;

  Category({this.id, this.encodeId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encodeId = json['encode_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encode_id'] = this.encodeId;
    data['name'] = this.name;
    return data;
  }
}

class Sub {
  int id;
  String encodeId;
  String title;
  String shareTitle;
  String thumb;

  Sub({this.id, this.encodeId, this.title, this.shareTitle, this.thumb});

  Sub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encodeId = json['encode_id'];
    title = json['title'];
    shareTitle = json['share_title'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encode_id'] = this.encodeId;
    data['title'] = this.title;
    data['share_title'] = this.shareTitle;
    data['thumb'] = this.thumb;
    return data;
  }

}


