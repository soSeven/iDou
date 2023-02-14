import 'package:idou/bean/mine/base_model.dart';

class TeamSubModel extends BaseModel {
  TeamSubPageModel page;
  List<TeamSubDataModel> data;

  TeamSubModel({this.page, this.data});

  TeamSubModel.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new TeamSubPageModel.fromJson(json['page']) : null;
    if (json['data'] != null) {
      data = new List<TeamSubDataModel>();
      json['data'].forEach((v) {
        data.add(new TeamSubDataModel.fromJson(v));
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

class TeamSubPageModel {
  int total;
  int page;
  int count;

  TeamSubPageModel({this.total, this.page, this.count});

  TeamSubPageModel.fromJson(Map<String, dynamic> json) {
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

class TeamSubDataModel {
  int id;
  String encodeId;
  String nickname;
  String avatar;
  String wechat;
  String createTime;

  TeamSubDataModel(
      {this.id,
        this.encodeId,
        this.nickname,
        this.avatar,
        this.wechat,
        this.createTime});

  TeamSubDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encodeId = json['encode_id'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    wechat = json['wechat'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encode_id'] = this.encodeId;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['wechat'] = this.wechat;
    data['create_time'] = this.createTime;
    return data;
  }
}
