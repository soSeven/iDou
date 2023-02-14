class DyRankUserBean {
  int id;
  String encodeId;
  String avatar;
  String nickname;
  int fansCount;
  int expiresDay;

  DyRankUserBean(
      {this.id,
        this.encodeId,
        this.avatar,
        this.nickname,
        this.fansCount,
        this.expiresDay});

  DyRankUserBean.fromJson(Map<String, dynamic> json) {
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