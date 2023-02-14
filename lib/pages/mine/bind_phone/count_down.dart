import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idou/extension/import_extension.dart';

class CountDown {

  factory CountDown() => _sharedInstance();

  static CountDown _instance;

  Timer _timer;
  var count = 0;
  VoidCallback timeCallBack;

  CountDown._() {
    _timer = Timer.periodic(Duration(seconds: 1), (t){
      print('timeddd');
      if (count <= 0) {
        count = 0;
        return;
      }
      count --;
      if (timeCallBack != null) {
        timeCallBack();
      }
    });
  }

  static CountDown _sharedInstance() {
    if (_instance == null) {
      _instance = CountDown._();
    }
    return _instance;
  }


}

class CountDownView extends StatefulWidget {

  final VoidCallback onTap;
  final bool enable;
  const CountDownView({@required this.onTap, @required this.enable});

  @override
  State<StatefulWidget> createState() => _CountDownViewState();

}

class _CountDownViewState extends State<CountDownView> {

  @override
  void initState() {
    super.initState();
    CountDown().timeCallBack = (){
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: NormalText.normal(
        text: CountDown().count == 0 ? '发送验证码' : '  ${CountDown().count}S  ',
        color:CountDown().count == 0 && widget.enable ? HexColor.fromHex('#FF324D') : HexColor.fromHex('#666666'),
        fontSize: 14
      ),
      onTap: () {
        if (!widget.enable) {
          return;
        }
        if (CountDown().count == 0) {
          CountDown().count = 60;
          if (widget.onTap != null) {
            widget.onTap();
          }
        }
      },
    );
  }
}