import 'package:idou/bean/mine/base_model.dart';
import 'package:idou/bean/mine/page_model.dart';

class CpmIncomeModel extends BaseModel {
  PageModel page;
  List<CpmIncomeDataModel> data;

  CpmIncomeModel({this.page, this.data});

  CpmIncomeModel.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new PageModel.fromJson(json['page']) : null;
    if (json['data'] != null) {
      data = new List<CpmIncomeDataModel>();
      json['data'].forEach((v) {
        data.add(new CpmIncomeDataModel.fromJson(v));
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

class CpmIncomeDataModel extends BaseModel {
  int id;
  String encodeId;
  String title;
  String thumb;
  int todayVisitNum;
  String income;
  String yesterdayIncome;
  String todayPredictIncome;

  CpmIncomeDataModel(
      {this.id,
        this.encodeId,
        this.title,
        this.thumb,
        this.todayVisitNum,
        this.income,
        this.yesterdayIncome,
        this.todayPredictIncome});

  CpmIncomeDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    encodeId = json['encode_id'];
    title = json['title'];
    thumb = json['thumb'];
    todayVisitNum = json['today_visit_num'];
    income = json['income'];
    yesterdayIncome = json['yesterday_income'];
    todayPredictIncome = json['today_predict_income'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['encode_id'] = this.encodeId;
    data['title'] = this.title;
    data['thumb'] = this.thumb;
    data['today_visit_num'] = this.todayVisitNum;
    data['income'] = this.income;
    data['yesterday_income'] = this.yesterdayIncome;
    data['today_predict_income'] = this.todayPredictIncome;
    return data;
  }
}
