import 'package:flutter/material.dart';
import 'package:idou/extension/import_extension.dart';

class CashCpmPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 15.scale(), right: 15.scale()),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    NormalText.normal(text: 'CPM收益', fontSize: 15),
                    SizedBox(height: 9.scale(),),
                    NormalText.normal(text: '07月06日', fontSize: 13, color: HexColor.fromHex('#8B8C91')),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                NormalText.normal(text: '+12.21', fontSize: 21),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        Divider(
          color: HexColor.fromHex('#20232C'),
          indent: 15.scale(),
          height: 0.5,
        )
      ],
    );
  }

}