import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idou/utils/utils.dart';

var _tips = {
  "vip_page_icon_10": "小程序的推广权限",
  "vip_page_icon_9": "短视频高级人脉资源联系方式",
  "vip_page_icon_14": "商学院推广课程免费学习",
  "vip_page_icon_13": "低成本  零基础  无压货  结算快",
  "vip_page_icon_8": "抓住小程序先机 多种变现产品任你选",
};

var _tipsPay = {
  "vip_page_icon_12": ["推广方案", "代理运营策略"],
  "vip_page_icon_2": ["对接资源", "电商产品对接资源"],
  "vip_page_icon_3": ["内部社群", "社群学习交流"],
  "vip_page_icon_11": ["讲师入驻", "可申请为课程讲师"],
};

class VipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '开通会员',
            style: TextStyle(
              fontSize: 18, //设置字体大小
            ),
          ),
          centerTitle: true,
          elevation: 0, //隐藏底部阴影分割线
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: new AssetImage(
                            Utils.getImgPath('vip_page_icon_4'),
                          ),
                        ),
                      ),
                      height: 80,
                      width: 345,
                      child: ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
                              child: CircleAvatar(
//                  backgroundImage: NetworkImage(bean.avatar),
                                  ),
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text("昵称",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white)),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      padding: EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
//                                    fit: BoxFit.scaleDown,
                                          image: new AssetImage(
                                            Utils.getImgPath('vip_page_icon_1'),
                                          ),
                                        ),
                                      ),
                                      child: Text("推荐人",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                                Text("有问题可以联系我",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xffe5e5e5))),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    width: 74,
                                    height: 29,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xfff8e7c9)),
                                    child: Center(
                                      child: Text("联系他",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff793510))),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13.6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff23252f)),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                9.3, 15.7, 23.3, 15.7),
                            child: Image.asset(
                              Utils.getImgPath("vip_page_icon_6"),
                              height: 15.6,
                            ),
                          ),
                          CircleAvatar(
                            child: Image.asset(
                              Utils.getImgPath("vip_page_icon_6"),
                              height: 27,
                            ),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Text("草莓蛋糕 1分钟前",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          Text("已开通",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffffd297)))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 33, bottom: 29),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 23),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.bottomCenter,
                              image: new AssetImage(
                                Utils.getImgPath('vip_page_icon_7'),
                              ),
                            ),
                          ),
                          child: Text("会员专属权益",
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white)),
                        ),
                      ),
                    ),
                    Column(
                      children: _tips.keys
                          .map((e) => _buildTipItem(e, _tips[e]))
                          .toList(),
                    ),
                    Text("倒计时内支付您将获得以下内容",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    Container(
                      margin: EdgeInsets.only(top: 31, bottom: 29),
                      height: 170,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _tipsPay.keys
                            .map((icon) => _buildPayTipItem(
                                icon, _tipsPay[icon][0], _tipsPay[icon][1]))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage(
                    Utils.getImgPath('vip_page_icon_5'),
                  ),
                ),
              ),
              height: 52,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("原价 ¥298",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                color: Color(0xff692f0f))),
                        Row(
                          children: <Widget>[
                            Text("限时优惠 ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4c1f07))),
                            Text("¥",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff692f0f))),
                            Text("198 ",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff692f0f))),
                            Text("/终身",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4c1f07))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text("立即开通",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff1c891))),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildTipItem(String k, String v) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0xff23252f)),
      child: Row(
        children: <Widget>[
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                color: Color(0xff383c48)),
            padding: EdgeInsets.all(14),
            child: Image.asset(
              Utils.getImgPath(k),
              height: 21.5,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 9.5),
              child: Text(v,
                  style: TextStyle(fontSize: 15, color: Color(0xfff1c892))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayTipItem(String icon, String tipsPay, String tipsPay2) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0xff23252f)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(12, 20, 8, 20),
            child: Image.asset(
              Utils.getImgPath(icon),
              height: 40,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(tipsPay,
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              SizedBox(
                height: 3,
              ),
              Text(tipsPay2,
                  style: TextStyle(fontSize: 12, color: Color(0xff696971))),
            ],
          ),
        ],
      ),
    );
  }
}
