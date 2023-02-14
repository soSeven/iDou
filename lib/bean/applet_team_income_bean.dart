class AppletTeamIncomeBean {
  Page page;
  String income;
  String yesterdayIncome;
  int todayFinishPlayingNum;

  AppletTeamIncomeBean(
      {this.page,
        this.income,
        this.yesterdayIncome,
        this.todayFinishPlayingNum});

  AppletTeamIncomeBean.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
    income = json['income'];
    yesterdayIncome = json['yesterday_income'];
    todayFinishPlayingNum = json['today_finish_playing_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page != null) {
      data['page'] = this.page.toJson();
    }
    data['income'] = this.income;
    data['yesterday_income'] = this.yesterdayIncome;
    data['today_finish_playing_num'] = this.todayFinishPlayingNum;
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
