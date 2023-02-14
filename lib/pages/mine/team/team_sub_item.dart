import 'package:flutter/material.dart';
import 'package:idou/bean/mine/team_sub_model.dart';
import 'package:idou/extension/import_extension.dart';

class TeamSubItem extends StatelessWidget {

  final TeamSubDataModel model;

  const TeamSubItem({@required this.model});

  @override
  Widget build(BuildContext context) {

    Widget _getWeChat() {
      if (model.wechat != null && model.wechat.isNotEmpty) {
        return Row(
          children: <Widget>[
            NormalText.normal(
                text: '微信号：${model.wechat}',
                fontSize: 12,
                color: HexColor.fromHex('#696971')
            ),
            Container(
              child: OutlineButton(
                onPressed: (){},
                child: NormalText.normal(
                  text: '复制',
                  color: HexColor.fromHex('#C6C6C9'),
                  fontSize: 11,
                ),
                borderSide: BorderSide(
                    color: HexColor.fromHex('#C6C6C9'),
                    width: 0.5
                ),
                padding: EdgeInsets.zero,
              ),
              width: 35.scale(),
              height: 16.scale(),
              margin: EdgeInsets.only(left: 8.scale()),
            ),
          ],
        );
      } else {
        return NormalText.normal(
            text: '微信号：未绑定',
            fontSize: 12,
            color: HexColor.fromHex('#696971')
        );
      }
    }

    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 15.scale(), right: 10.scale()),
        child: Row(
          children: <Widget>[
            Container(
                width: 40.scale(),
                height: 40.scale(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.scale()/2.0)),
                    image: DecorationImage(
                        image: NetworkImage(model.avatar ?? ''),
                        fit: BoxFit.cover
                    )
                )
            ),
            Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      NormalText.normal(
                        text: model.nickname ?? '',
                        fontSize: 14,
                      ),
                      SizedBox(height: 3.scale(),),
                      _getWeChat(),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                  ),
                  margin: EdgeInsets.only(left: 15.scale()),
                )
            ),
            Column(
              children: <Widget>[
                NormalText.normal(
                  text: '加入时间',
                  fontSize: 12,
                  color: HexColor.fromHex('#696971'),
                ),
                SizedBox(height: 3.scale(),),
                NormalText.normal(
                  text: model.createTime ?? '',
                  fontSize: 12,
                  color: HexColor.fromHex('#696971')
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ],
        ),
      )
//        height: 90.scale(),
    );
  }

}