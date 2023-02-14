import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/pages/mine/income/cpm_income_page.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:flutter/cupertino.dart';

class IncomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _IncomePageState();
  
}

class _IncomePageState extends State<IncomePage> {

  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '团队管理',
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
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: InkWell(
                      child: Center(
                        child: NormalText.normal(text: 'CPM分佣模式', fontSize: 15),
                      ),
                      onTap: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: _currentIndex == 0 ? HexColor.fromHex('#FF324D') : Colors.transparent,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5.scale()), bottomLeft: Radius.circular(5.scale())),
                      ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: InkWell(
                      child: Center(
                        child: NormalText.normal(text: 'CPS分佣模式', fontSize: 15),
                      ),
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                      color: _currentIndex == 1 ? HexColor.fromHex('#FF324D') : Colors.transparent,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(5.scale()), bottomRight: Radius.circular(5.scale())),
                    ),
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
            margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 10.scale()),
            height: 40.scale(),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.scale()),
                border: Border.all(width: 0.5, color: HexColor.fromHex('#FF324D')),
              ),
          ),
          Expanded (
            child: _currentIndex == 0
                ? CPMIncomePage() 
                : Container(
              child: NormalText.normal(
                  text: '- 即将开放，敬请期待 -',
                  color: HexColor.fromHex('#696971'),
                  fontSize: 13
              ),
              margin: EdgeInsets.only(top: 54.scale()),
            ),
          )
        ],
      ),
      backgroundColor: HexColor.fromHex('#181824'),
    );

  }

}