class AppletDetailSubBean {
  Page page;
  List<Data> data;

  AppletDetailSubBean({this.page, this.data});

  AppletDetailSubBean.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String encodeId;
  String title;
  String shareTitle;
  String thumb;

  Data({this.id, this.encodeId, this.title, this.shareTitle, this.thumb});

  Data.fromJson(Map<String, dynamic> json) {
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