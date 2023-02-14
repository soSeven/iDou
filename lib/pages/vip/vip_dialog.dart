import 'package:flutter/material.dart';
import 'package:idou/routes/data_route.dart';
import 'package:idou/utils/utils.dart';

var _tips = {
  "vip_tip_icon_four": "小程序的推广权限",
  "vip_tip_icon_five": "短视频高级人脉资源联系方式",
  "vip_tip_icon_six": "商学院推广课程免费学习",
  "vip_tip_icon_seven": "低成本 零基础 无压货 推广就能拿分成",
  "vip_tip_icon_eight": "抓住小程序先机 多种变现产品任你选",
};

class VipDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage(
                Utils.getImgPath('vip_tip_bg'),
              ),
            ),
          ),
          width: 300,
          height: 510,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(50, 115, 50, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.asset(
                              Utils.getImgPath("vip_tip_icon_one"),
                              width: 40,
                            ),
                          ),
                          Text(
                            "推广方案",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xff78482f)),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.asset(
                              Utils.getImgPath("vip_tip_icon_two"),
                              width: 40,
                            ),
                          ),
                          Text(
                            "内部社群",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xff78482f)),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.asset(
                              Utils.getImgPath("vip_tip_icon_three"),
                              width: 40,
                            ),
                          ),
                          Text(
                            "对接资源",
                            style: TextStyle(
                                fontSize: 13, color: Color(0xff78482f)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 15,
                  children: _tips.keys
                      .map((k) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        Utils.getImgPath(k),
                        width: 28,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        _tips[k],
                        style: TextStyle(
                            fontSize: 13, color: Color(0xfff1c892)),
                      ),
                    ],
                  ))
                      .toList(),
                ),
                Expanded(
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(DataRoute.routeVipPage);
                      },
                      child: Container(
                        width: 265,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffeec690)),
                        child: Center(
                          child: Text(
                            "开通权限",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff793510),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
