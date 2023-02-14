class DouyinAccountBean {
  Page page;
  List<DouyinAccount> data;

  DouyinAccountBean({this.page, this.data});

  DouyinAccountBean.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
    if (json['data'] != null) {
      data = new List<DouyinAccount>();
      json['data'].forEach((v) {
        data.add(new DouyinAccount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page != null) {
      data['page'] = this.page.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Page {
  int total;
  int page;
  int count;

  Page({this.total, this.page, this.count});

  Page.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['count'] = this.count;
    return data;
  }
}

class DouyinAccount {
  int id;
  String encodeId;
  String avatar;
  String nickname;
  int fansCount;
  int expiresDay;

  DouyinAccount(
      {this.id,
        this.encodeId,
        this.avatar,
        this.nickname,
        this.fansCount,
        this.expiresDay});

  DouyinAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encodeId = json['encode_id'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    fansCount = json['fans_count'];
    expiresDay = json['expires_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encode_id'] = this.encodeId;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['fans_count'] = this.fansCount;
    data['expires_day'] = this.expiresDay;
    return data;
  }
}