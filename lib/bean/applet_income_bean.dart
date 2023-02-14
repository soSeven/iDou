class AppletIncomeBean {
  String monthRealIncome;
  String monthRoundIncome;
  List<FinishPlayingList> finishPlayingList;
  String predictIncome;
  int visitNum;
  int finishPlayingNum;
  String ecpm;
  String yesterdayEcpm;

  AppletIncomeBean(
      {this.monthRealIncome,
        this.monthRoundIncome,
        this.finishPlayingList,
        this.predictIncome,
        this.visitNum,
        this.finishPlayingNum,
        this.ecpm,
        this.yesterdayEcpm});

  AppletIncomeBean.fromJson(Map<String, dynamic> json) {
    monthRealIncome = json['month_real_income'];
    monthRoundIncome = json['month_round_income'];
    if (json['finish_playing_list'] != null) {
      finishPlayingList = new List<FinishPlayingList>();
      json['finish_playing_list'].forEach((v) {
        finishPlayingList.add(new FinishPlayingList.fromJson(v));
      });
    }
    predictIncome = json['predict_income'];
    visitNum = json['visit_num'];
    finishPlayingNum = json['finish_playing_num'];
    ecpm = json['ecpm'];
    yesterdayEcpm = json['yesterday_ecpm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month_real_income'] = this.monthRealIncome;
    data['month_round_income'] = this.monthRoundIncome;
    if (this.finishPlayingList != null) {
      data['finish_playing_list'] =
          this.finishPlayingList.map((v) => v.toJson()).toList();
    }
    data['predict_income'] = this.predictIncome;
    data['visit_num'] = this.visitNum;
    data['finish_playing_num'] = this.finishPlayingNum;
    data['ecpm'] = this.ecpm;
    data['yesterday_ecpm'] = this.yesterdayEcpm;
    return data;
  }
}

class FinishPlayingList {
  String nickname;
  String avatar;
  int finishPlayingNum;

  FinishPlayingList({this.nickname, this.avatar, this.finishPlayingNum});

  FinishPlayingList.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    avatar = json['avatar'];
    finishPlayingNum = json['finish_playing_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['finish_playing_num'] = this.finishPlayingNum;
    return data;
  }
}