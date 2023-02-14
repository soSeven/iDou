
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/extension/assetImage_extension.dart';
import 'package:idou/extension/color_extension.dart';
import 'package:idou/extension/import_extension.dart';

class CashBagPage extends StatelessWidget {

  // 事件

  // 申请提现
  void onClickGetCrash() {
    print('111');
  }

  // 提现记录
  void onClickRecord() {
    print('333');
  }

  // 银行卡
  void onClickCard() {
    print('444');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的钱包',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.scale(),
            fontWeight: FontWeight.bold,
            fontFamily: MineUtil.fontFamily,
          ),
        ),
        centerTitle: true,
        backgroundColor: HexColor.fromHex('#181824'),
        elevation: 0,
        leading: FlatButton(
          child: ConstrainedBox(
            child: Image(
              image: LoadImage.localImage('icon_back'),
            ),
            constraints: BoxConstraints.tightFor(width: 9.scale(), height: 16.scale()),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          child: ListView(
            children: <Widget>[
              _getTopVIew(),
              _getListItem(
                  name: 'CPM收益记录',
                  onPress: () => Navigator.pushNamed(context, 'mine_cash_cpm')
              ),
              _getListItem(name: '提现记录', onPress: onClickRecord),
              _getListItem(name: '银行卡', onPress: onClickCard),
            ],
          )
      ),
      backgroundColor: HexColor.fromHex('#181824'),
    );
  }

  Widget _getListItem({@required String name, @required VoidCallback onPress}) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 15.scale()),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: HexColor.fromHex('#20232C'),
                  width: 0.5
              )
          ),
        ),
        height: 55.scale(),
        child: Row(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.scale(),
                fontWeight: FontWeight.normal,
                fontFamily: MineUtil.fontFamily,
              ),
            ),
            Padding(
              child: ConstrainedBox(
                child: Image(
                  image: LoadImage.localImage('arrow_light'),
                ),
                constraints: BoxConstraints.tightFor(width: 7.scale(), height: 12.scale()),
              ),
              padding: EdgeInsets.only(right: 15.scale()),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
      onTap: onPress,
    );
  }

  Widget _getTopVIew() {

    Widget _getTop() {

      return Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 22.scale(), bottom: 28.scale()),
            child: Column(
              children: <Widget>[
                NormalText.normal(
                    text: '可提现余额(元)',
                    fontSize: 13,
                    color: HexColor.fromHex('#8B8C91')
                ),
                SizedBox(height: 12.scale(),),
                NormalText.normal(
                    text: '68.66',
                    fontSize: 26,
                    color: HexColor.fromHex('#FFFFFF')
                ),
                SizedBox(height: 20.scale(),),
                NormalText.normal(
                    text: '月提现金额超过5000元，平台代收取信息服务费6%，具体详见《爱抖家族结算规则》',
                    fontSize: 12,
                    color: HexColor.fromHex('#F3CF4A')
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Positioned(
            child: FlatButton(
              child: Text(
                '申请提现',
                style: TextStyle(
                    color: HexColor.fromHex('#FFFFFF'),
                    fontWeight: FontWeight.normal,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 15.scale()
                ),
              ),
              onPressed: onClickGetCrash,
              color: HexColor.fromHex('#FF324D'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.scale())),
            ),
            right: 14.scale(),
            top: 34.scale(),
          )
        ],
      );
    }

    Widget _getBottom() {

      Widget _getItem(String title, String price) {
        return Column(
          children: <Widget>[
            SizedBox(height: 22.scale(),),
            NormalText.normal(
              text: price,
              fontSize: 21,
            ),
            NormalText.normal(
                text: title,
                fontSize: 13,
                color: HexColor.fromHex('#8B8C91')
            ),
            SizedBox(height: 27.scale(),)
          ],
        );
      }

      return Container(
        child: Row(
          children: <Widget>[
            _getItem('总收益(元)', '0.00'),
            _getItem('CPM收益(待发放)', '0.00'),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      );
    }

    return Center(
        child: Container(
          margin: EdgeInsets.only(top: 15.scale()),
          child: Column(
            children: <Widget>[
              _getTop(),
              Divider(
                indent: 15.scale(),
                endIndent: 15.scale(),
                thickness: 0.5,
                color: HexColor.fromHex('#3A3A44'),
              ),
              _getBottom(),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          color: HexColor.fromHex('#23252F'),
        )
//        height: 90.scale(),
    );
  }

}