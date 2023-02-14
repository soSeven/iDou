class StarHotBean {
  String followerStr;
  String nickName;
  int rank;
  dynamic score;
  List<String> tags;
  String uniqueId;

  StarHotBean(
      {this.followerStr,
      this.nickName,
      this.rank,
      this.score,
      this.tags,
      this.uniqueId});

  StarHotBean.fromJson(Map<String, dynamic> json) {
    followerStr = json['follower_str'];
    nickName = json['nick_name'];
    rank = json['rank'];
    score = json['score'];
    tags = json['tags'].cast<String>();
    uniqueId = json['unique_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['follower_str'] = this.followerStr;
    data['nick_name'] = this.nickName;
    data['rank'] = this.rank;
    data['score'] = this.score;
    data['tags'] = this.tags;
    data['unique_id'] = this.uniqueId;
    return data;
  }
}
