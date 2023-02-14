import 'package:idou/bean/mine/base_model.dart';

class InvitePostModel extends BaseModel {
  int id;
  String title;
  String bgImg;
  String encodeId;

  InvitePostModel({this.id, this.title, this.bgImg, this.encodeId});

  InvitePostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bgImg = json['bg_img'];
    encodeId = json['encode_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['bg_img'] = this.bgImg;
    data['encode_id'] = this.encodeId;
    return data;
  }
}
