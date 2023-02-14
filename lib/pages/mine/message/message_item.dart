import 'package:flutter/material.dart';
import 'package:idou/bean/mine/message_model.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/extension/color_extension.dart';
import 'package:idou/utils/mine_util.dart';

class MessageItem extends StatelessWidget {

  final MessageModel message;

  const MessageItem({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 13.scale(), bottom: 20.scale()),
      child: Column(
        children: <Widget>[
          Text(
            message.createTime ?? "",
            style: TextStyle(
                color: HexColor.fromHex('#696971'),
                fontSize: 12.scale(),
                fontFamily: MineUtil.fontFamily,
                fontWeight: FontWeight.normal
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  message.title ?? "",
                  style: TextStyle(
                      color: HexColor.fromHex('#FFFFFF'),
                      fontSize: 15.scale(),
                      fontFamily: MineUtil.fontFamily,
                      fontWeight: FontWeight.normal
                  ),),
                SizedBox(height: 10.scale(),),
                Text(
                  message.content ?? "",
                  style: TextStyle(
                      color: HexColor.fromHex('#8B8C91'),
                      fontSize: 13.scale(),
                      fontFamily: MineUtil.fontFamily,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.scale()),
              color: HexColor.fromHex('#23252F'),
            ),
            margin: EdgeInsets.only(top: 20.scale()),
            padding: EdgeInsets.only(top: 18.scale(), bottom: 18.scale(), left: 15.scale(), right: 15.scale()),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

}

