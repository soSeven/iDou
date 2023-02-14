
import 'base_model.dart';

// ignore: must_be_immutable
class MessageModel extends BaseModel {

  int id;
  String title;
  String content;
  String createTime;
  String h5Url;
  String encodeId;

  MessageModel(
      {this.id,
        this.title,
        this.content,
        this.createTime,
        this.h5Url,
        this.encodeId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createTime = json['create_time'];
    h5Url = json['h5_url'];
    encodeId = json['encode_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['create_time'] = this.createTime;
    data['h5_url'] = this.h5Url;
    data['encode_id'] = this.encodeId;
    return data;
  }

//  @override
//  List<Object> get props => [id, title, content, createTime, h5Url, encodeId];

}



