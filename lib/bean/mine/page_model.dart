
class PageModel {
  int total;
  int page;
  int count;

  PageModel({this.total, this.page, this.count});

  PageModel.fromJson(Map<String, dynamic> json) {
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