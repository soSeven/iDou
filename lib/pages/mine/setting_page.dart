import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/extension/assetImage_extension.dart';
import 'package:idou/extension/color_extension.dart';

class SettingPage extends StatelessWidget {

  // 事件

  // 服务协议
  void onClickServiceProtocol() {
    print('111');
  }

  // 隐私政策
  void onClickPrivacyProtocol() {
    print('222');
  }

  // 推广规范
  void onClickRule() {
    print('333');
  }

  // 清理缓存
  void onClickCache() {
    print('444');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '系统设置',
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
            _getListItem(name: '服务协议', onPress: onClickServiceProtocol),
            _getListItem(name: '隐私政策', onPress: onClickPrivacyProtocol),
            _getListItem(name: '推广规范', onPress: onClickRule),
            _getListItem(name: '清理缓存', onPress: onClickCache),
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

}