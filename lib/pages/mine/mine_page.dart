
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:idou/extension/color_extension.dart';
import 'package:idou/pages/mine/bind_phone/bind_phone_page.dart';
import 'package:idou/pages/mine/help_page.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/extension/assetImage_extension.dart';

class MinePage extends StatefulWidget {

  @override
  _MinePageState createState() => _MinePageState();

}

class _MinePageState extends State<MinePage> {

  var isVip = false;
  String phone = '';
  String weChat = '';
  String inviteCode = '';
  String userName = '';
  String avatarUrl = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594982021733&di=ba88251dac08319d03a8b31b628a7a2f&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F-vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2Fd53f8794a4c27d1e8ff07fe61fd5ad6eddc43839.jpg';

  String inviteUserName = '';
  String inviteUserAvatarUrl = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594982021733&di=ba88251dac08319d03a8b31b628a7a2f&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F-vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2Fd53f8794a4c27d1e8ff07fe61fd5ad6eddc43839.jpg';

  String cashOfCurrent = '0';
  String cashOfTotal = '0';
  String cashOfToday = '0';
  String cashOfYesterday = '0';

  // 事件

  // 消息
  void onClickMessage() {
    Navigator.pushNamed(context, 'mine_message');
  }

  // 设置
  void onClickSetting() {
    Navigator.pushNamed(context, 'mine_setting');
  }


  // 修改微信
  void onClickChangeWeChat() {
    Navigator.pushNamed(context, 'mine_message');
  }

  // 复制邀请码
  void onClickCopyInviteCode() {

  }

  // 复制微信
  void onClickCopyWeChat() {
    Navigator.pushNamed(context, 'mine_phone_login');
  }

  // 绑定微信
  void onClickBindWeChat() {
    showModal(
        context: context,
        builder: (BuildContext context) {
          return BindPhonePage();
        }
    );
  }

  // 开通
  void onClickVip() {

  }

  // 我的钱包
  void onClickMyCashBag() {
    Navigator.pushNamed(context, 'mine_cash_bag');
  }

  // 邀请好友
  void onClickInvitePeople() {
    Navigator.pushNamed(context, 'mine_invite');
  }

  // 招募团队
  void onClickInviteTeam() {

  }

  // 团队管理
  void onClickTeamManager() {
    print('ddd');
    Navigator.pushNamed(context, 'mine_team' );
  }

  // 抖音号
  void onClickTikTok() {

  }

  // 收益报表
  void onClickCashTable() {

    Navigator.pushNamed(context, 'mine_income');

  }

  // 在线客服
  void onClickHelp() {
    showModal(
        context: context,
        builder: (BuildContext context) {
          return HelpPage();
        }
    );
  }

  // 意见反馈
  void onClickFeedback() {
    Navigator.pushNamed(context, 'mine_feedback');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.scale(),
            fontWeight: FontWeight.bold,
            fontFamily: MineUtil.fontFamily,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            child: FlatButton(
              onPressed: onClickMessage,
              child: Container(
                child: Image(
                  image: LoadImage.localImage('notice_icon'),
                ),
                width: 17.scale(),
                height: 20.scale(),
              ),
              padding: EdgeInsets.zero,
            ),
            width: 40.scale(),
          ),
          Container(
            child: FlatButton(
              onPressed: onClickSetting,
              child: Container(
                child: Image(
                  image: LoadImage.localImage('set_icon'),
                ),
                width: 17.scale(),
                height: 20.scale(),
              ),
              padding: EdgeInsets.zero,
            ),
            width: 40.scale(),
            margin: EdgeInsets.only(right: 15.scale()),
          ),
        ],
        backgroundColor: HexColor.fromHex('#181824'),
        elevation: 0,

      ),
      body: Center(
          child: ListView(
            children: <Widget>[
              _getHeader(),
              _getToolBar(),
              _getCashCard(),
              _getItemsCard(),
              _getMarkTitle(),
            ],
          )
      ),
      backgroundColor: HexColor.fromHex('#181824'),
    );
  }

  Widget _getHeader() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              width: 55.scale(),
              height: 55.scale(),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(55.scale()/2.0)),
//              color: Colors.white,
                  border: Border.all(color: Colors.white, width: 0.5),
                  image: DecorationImage(
                      image: NetworkImage(avatarUrl),
                      fit: BoxFit.cover
                  )
              )
          ),
          Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      userName.isEmpty ? '未知' : userName,
                      style: TextStyle(
                          fontSize: 17.scale(),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: MineUtil.fontFamily
                      ),
                    ),
                    Text(
                      phone.isEmpty ? '请先绑定手机号' : '手机号：$phone',
                      style: TextStyle(
                        fontSize: 12.scale(),
                        fontWeight: FontWeight.normal,
                        color: HexColor.fromHex('#E5E5E5'),
                        fontFamily: MineUtil.fontFamily,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                ),
                margin: EdgeInsets.only(left: 18.scale()),
              )
          )
        ],
      ),
      height: 90.scale(),
      margin: EdgeInsets.only(left: 15.scale()),

    );
  }

  Widget _getToolBar() {

    Widget _getActionBar([bool isLeft = false, String text, String btnTitle, VoidCallback onPress]) {
      return Expanded(
        child: Container(
            child: Row(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                      color: HexColor.fromHex('#696971'),
                      fontWeight: FontWeight.normal,
                      fontSize: 12.scale()
                  ),
                ),
                Container(
                  child: OutlineButton(
                    onPressed: onPress,
                    child: Text(
                      btnTitle,
                      style: TextStyle(
                          color: HexColor.fromHex('#C6C6C9'),
                          fontSize: 11.scale(),
                          fontWeight: FontWeight.normal
                      ),
                    ),
                    textColor: Colors.white,
                    color: Colors.white,
                    borderSide: BorderSide(
                        color: HexColor.fromHex('#C6C6C9'),
                        width: 0.5
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  width: 35.scale(),
                  height: 16.scale(),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            margin: isLeft ? EdgeInsets.only(right: 10.scale()) : EdgeInsets.only(left: 10.scale())
        ),
      );
    }

    return Container(
      height: 40.scale(),
      margin: EdgeInsets.only(left: 15.scale(), right: 15.scale()),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: HexColor.fromHex('#20232C'), width: 0.5),
          bottom: BorderSide(color: HexColor.fromHex('#20232C'), width: 0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          _getActionBar(
              true,
              weChat.isEmpty ? '微信号：请绑定' : '微信号：$weChat',
              weChat.isEmpty ? '绑定' : '修改',
              weChat.isEmpty ? onClickBindWeChat : onClickChangeWeChat,
          ),
          _getActionBar(
              false,
              isVip ? '邀请码：$inviteCode' : '会员未开通',
              isVip ? '复制' : '开通',
              isVip ? onClickCopyInviteCode : onClickVip,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _getCashCard() {

    Widget _getCurrentCash() {
      return Container(
//        color: Colors.red,
        child: Column(
          children: <Widget>[
            Text(
              '可提现余额(元)',
              style: TextStyle(
                  color: HexColor.fromHex('#5D4E35'),
                  fontWeight: FontWeight.normal,
                  fontFamily: MineUtil.fontFamily,
                  fontSize: 13.scale()
              ),
            ),
            Text(
              cashOfCurrent,
              style: TextStyle(
                  color: HexColor.fromHex('#161922'),
                  fontWeight: FontWeight.bold,
                  fontFamily: MineUtil.fontFamily,
                  fontSize: 24.scale()
              ),
            )
          ],
        ),
      );
    }

    Widget _getCashList() {
      return Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                cashOfTotal,
                style: TextStyle(
                    color: HexColor.fromHex('#161922'),
                    fontWeight: FontWeight.bold,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 18.scale()
                ),
              ),
              Text(
                '总收益(元)',
                style: TextStyle(
                    color: HexColor.fromHex('#5E4F36'),
                    fontWeight: FontWeight.normal,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 13.scale()
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                cashOfToday,
                style: TextStyle(
                    color: HexColor.fromHex('#161922'),
                    fontWeight: FontWeight.bold,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 18.scale()
                ),
              ),
              Text(
                '今日预估收益(元)',
                style: TextStyle(
                    color: HexColor.fromHex('#5E4F36'),
                    fontWeight: FontWeight.normal,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 13.scale()
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                cashOfYesterday,
                style: TextStyle(
                    color: HexColor.fromHex('#161922'),
                    fontWeight: FontWeight.bold,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 18.scale()
                ),
              ),
              Text(
                '昨日收益',
                style: TextStyle(
                    color: HexColor.fromHex('#5E4F36'),
                    fontWeight: FontWeight.normal,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 13.scale()
                ),
              ),
            ],
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      );
    }

    return Container(
      height: 190.scale(),
//
      margin: EdgeInsets.only(left: 15.scale(), top: 26.scale(), right: 15.scale()),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            child: Image(
              image: LoadImage.localImage('user_bg'),
            ),
            top: 0,
            left: 0,
            right: 0,
          ),
          Positioned(
            left: 15.scale(),
            top: 13.scale(),
            child: _getCurrentCash(),
          ),
          Positioned(
            bottom: 50.scale(),
            left: 0,
            right: 0,
            child: _getCashList(),
          ),
          Positioned(
            top: 24.scale(),
            right: 15.scale(),
            child: FlatButton(
              child: Text(
                '我的钱包',
                style: TextStyle(
                    color: HexColor.fromHex('#FFFFFF'),
                    fontWeight: FontWeight.normal,
                    fontFamily: MineUtil.fontFamily,
                    fontSize: 13.scale()
                ),
              ),
              onPressed: onClickMyCashBag,
              color: HexColor.fromHex('#FF324D'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.scale())),
            ),
          )
        ],
      ),
    );
  }

  Widget _getItemsCard() {

    Widget _getBtn(String name, String imgName, VoidCallback onPress) {
      return InkWell(
        child: Column(
          children: <Widget>[
            Image(
              image: LoadImage.localImage(imgName),
              width: 23.scale(),
              height: 20.scale(),
            ),
            SizedBox(height: 12.scale(),),
            Text(
              name,
              style: TextStyle(
                color: HexColor.fromHex('#E5E5E5'),
                fontSize: 12.scale(),
                fontWeight: FontWeight.normal,
                fontFamily: MineUtil.fontFamily,
              ),
            ),
          ],
        ),
        onTap: onPress,
      );
    }

    Widget _getVipBtns() {
      var array = <Widget>[];
      if (isVip) {
        array = <Widget>[
          SizedBox(width: 15.scale(),),
          Expanded(
            child: FlatButton(
              color: HexColor.fromHex('#EABE75'),
              onPressed: onClickInviteTeam,
              child: Text(
                '招募团队',
                style: TextStyle(
                    color: HexColor.fromHex('#793510'),
                    fontSize: 16.scale(),
                    fontWeight: FontWeight.bold,
                    fontFamily: MineUtil.fontFamily
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.scale())
              ),
            ),
          ),
          SizedBox(width: 15.scale(),),
        ];
      } else {
        array = <Widget>[
          SizedBox(width: 15.scale(),),
          Expanded(
            child: FlatButton(
              child: Text(
                '邀请好友',
                style: TextStyle(
                    color: HexColor.fromHex('#FFD297'),
                    fontSize: 16.scale(),
                    fontWeight: FontWeight.bold,
                    fontFamily: MineUtil.fontFamily
                ),
              ),
              onPressed: onClickInvitePeople,
              color: HexColor.fromHex('#363636'),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: HexColor.fromHex('#FFD297')),
                borderRadius: BorderRadius.circular(5.scale()),
              ),
            ),
          ),
          SizedBox(width: 15.scale(),),
          Expanded(
            child: FlatButton(
              color: HexColor.fromHex('#EABE75'),
              onPressed: onClickVip,
              child: Text(
                '开通会员',
                style: TextStyle(
                    color: HexColor.fromHex('#793510'),
                    fontSize: 16.scale(),
                    fontWeight: FontWeight.bold,
                    fontFamily: MineUtil.fontFamily
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.scale())
              ),
            ),
          ),
          SizedBox(width: 15.scale(),),
        ];
      }
      return Container(
        child: Row(
          children: array,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
        height: 45.scale(),
      );
    }

    Widget _getInviteHeader() {
      return Container(
        child: Row(
          children: <Widget>[
            Container(
                width: 44.scale(),
                height: 44.scale(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(55.scale()/2.0)),
                    image: DecorationImage(
                        image: NetworkImage(inviteUserAvatarUrl),
                        fit: BoxFit.cover
                    )
                )
            ),
            Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        inviteUserName,
                        style: TextStyle(
                            fontSize: 15.scale(),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: MineUtil.fontFamily
                        ),
                      ),
                      DecoratedBox(
                        child: Padding(
                          child: Text(
                            '推荐人',
                            style: TextStyle(
                              fontSize: 11.scale(),
                              fontWeight: FontWeight.normal,
                              color: HexColor.fromHex('#FFFFFF'),
                              fontFamily: MineUtil.fontFamily,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 5.scale(), top: 2.scale(), bottom: 2.scale(), right: 5.scale()),
                        ),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('#383C48'),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(6.scale()), bottomRight: Radius.circular(6.scale()))
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                  ),
                  margin: EdgeInsets.only(left: 18.scale()),
                )
            ),
            Container(
              width: 77.scale(),
              height: 31.scale(),
              child: FlatButton(
                child: Text(
                  '复制微信',
                  style: TextStyle(
                      color: HexColor.fromHex('#FFD297'),
                      fontSize: 13.scale(),
                      fontWeight: FontWeight.normal,
                      fontFamily: MineUtil.fontFamily
                  ),
                ),
                onPressed: onClickCopyWeChat,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: HexColor.fromHex('#FFD297')),
                  borderRadius: BorderRadius.circular(5.scale()),
                ),
              ),
            ),
          ],
        ),
//        height: 90.scale(),
        margin: EdgeInsets.only(left: 15.scale(), top: 23.scale(), bottom: 27.scale(), right: 15.scale()),

      );
    }

    return Column(
      children: <Widget>[
        Container(
          child: Text(
            '常用服务',
            style: TextStyle(
              color: HexColor.fromHex('#ffffff'),
              fontSize: 17.scale(),
              fontWeight: FontWeight.bold,
              fontFamily: MineUtil.fontFamily,
            ),
          ),
          margin: EdgeInsets.only(left: 15.scale()),
        ),
        Container(
//      height: 256.scale(),
          margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 20.scale()),
          decoration: ShapeDecoration(
              color: HexColor.fromHex('#23252F'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.scale())
              )
          ),
          child: Column(
            children: <Widget>[
              _getInviteHeader(),
              _getVipBtns(),
              Container(
                color: HexColor.fromHex('#3A3A44'),
                height: 0.5,
                margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 20.scale()),
              ),
              ButtonBar(
                children: <Widget>[
                  _getBtn('团队管理', 'my_icon_account1', onClickTeamManager),
                  _getBtn('抖音号', 'my_icon_account2', onClickTikTok),
                  _getBtn('收益报表', 'my_icon_account3', onClickCashTable),
                  _getBtn('在线客服', 'my_icon_account4', onClickHelp),
                  _getBtn('意见反馈', 'my_icon_account5', onClickFeedback),
                ],
                alignment: MainAxisAlignment.spaceBetween,
                buttonHeight: 96.scale(),
                buttonPadding: EdgeInsets.only(left: 15.scale(), right: 15.scale()),
              ),
            ],
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _getMarkTitle() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '爱抖家族',
            style: TextStyle(
                fontSize: 15.scale(),
                fontWeight: FontWeight.bold,
                color: HexColor.fromHex('#8B8C91'),
                fontFamily: MineUtil.fontFamily
            ),
          ),
          SizedBox(height: 3.scale(),),
          Text(
            '让短视频变现更简单',
            style: TextStyle(
              fontSize: 11.scale(),
              fontWeight: FontWeight.normal,
              color: HexColor.fromHex('#696971'),
              fontFamily: MineUtil.fontFamily,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 50.scale(), bottom: 50.scale()),
    );
  }

}
