class LanguageBean {
  String titleId;
  String languageCode;
  String countryCode;
  bool isSelected;

  LanguageBean(this.titleId, this.languageCode, this.countryCode,
      {this.isSelected: false});

  LanguageBean.fromJson(Map<String, dynamic> json)
      : titleId = json['titleId'],
        languageCode = json['languageCode'],
        countryCode = json['countryCode'],
        isSelected = json['isSelected'];

  Map<String, dynamic> toJson() => {
        'titleId': titleId,
        'languageCode': languageCode,
        'countryCode': countryCode,
        'isSelected': isSelected
  };

}
