class PlayIntroSearchBean {
  int id;
  int questionType;
  int questionNo;
  String questionTitle;
  String questionAnswer;
  int isShow;
  String createTime;
  String updateTime;
  Null deleteTime;
  String encodeId;

  PlayIntroSearchBean(
      {this.id,
        this.questionType,
        this.questionNo,
        this.questionTitle,
        this.questionAnswer,
        this.isShow,
        this.createTime,
        this.updateTime,
        this.deleteTime,
        this.encodeId});

  PlayIntroSearchBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionType = json['question_type'];
    questionNo = json['question_no'];
    questionTitle = json['question_title'];
    questionAnswer = json['question_answer'];
    isShow = json['is_show'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    deleteTime = json['delete_time'];
    encodeId = json['encode_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_type'] = this.questionType;
    data['question_no'] = this.questionNo;
    data['question_title'] = this.questionTitle;
    data['question_answer'] = this.questionAnswer;
    data['is_show'] = this.isShow;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['delete_time'] = this.deleteTime;
    data['encode_id'] = this.encodeId;
    return data;
  }
}