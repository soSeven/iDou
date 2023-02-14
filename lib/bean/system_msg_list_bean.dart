import 'package:idou/bean/system_msg_bean.dart';

class MsgListBean {
  List<SystemMsgBean> list;

  MsgListBean.fromJson(Map<String, dynamic> json)
      : list = (json['list'] as List)
            ?.map((e) => e == null
                ? null
                : new SystemMsgBean.fromJson(e as Map<String, dynamic>))
            ?.toList();

  Map<String, dynamic> toJson() => {
        'children': list,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"children\":$list");
    sb.write('}');
    return sb.toString();
  }
}
