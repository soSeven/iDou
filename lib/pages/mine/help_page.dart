import 'package:flutter/material.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/utils/mine_util.dart';

class HelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    String avatarUrl = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594982021733&di=ba88251dac08319d03a8b31b628a7a2f&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F-vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2Fd53f8794a4c27d1e8ff07fe61fd5ad6eddc43839.jpg';

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 20.scale(),
              child: Container(
                child: Column(
                  children: <Widget>[
                    NormalText.normal(
                        text: '客服：爱抖家族官方客服-依依',
                        fontSize: 14,
                        color: HexColor.fromHex('#1A1A1A'),
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height: 12.scale(),),
                    Center(
                      child: Container(
                          width: 164.scale(),
                          height: 164.scale(),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(avatarUrl),
                                  fit: BoxFit.cover
                              )
                          )
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                text: '尊敬的',
                                style: TextStyle(
                                  fontFamily: MineUtil.fontFamily,
                                  fontSize: 14.scale(),
                                  color: HexColor.fromHex('#1A1A1A'),
                                  fontWeight: FontWeight.normal,
                                )
                              ),
                              TextSpan(
                                  text: '北海道的鱼',
                                  style: TextStyle(
                                    fontFamily: MineUtil.fontFamily,
                                    fontSize: 14.scale(),
                                    color: HexColor.fromHex('#FF324D'),
                                    fontWeight: FontWeight.normal,
                                  )
                              ),
                            ]
                          )),
                          NormalText.normal(
                              text: '这是您的专属客服',
                              fontSize: 14,
                              color: HexColor.fromHex('#1A1A1A'),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 15.scale(), top: 25.scale()),
                    ),
                    NormalText.normal(
                      text: '请您截图或长按保存二维码添加客服微信',
                      fontSize: 12,
                      color: HexColor.fromHex('#666666'),
                      textAlign: TextAlign.center
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: (){
                        },
                        child: NormalText.normal(
                          text: '下载二维码',
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.scale()),
                        ),
                        color: HexColor.fromHex('#FF324D'),
                      ),
                      margin: EdgeInsets.only(left: 20.scale(), right: 20.scale(), top: 15.scale(), bottom: 29.scale()),
                      height: 49.scale(),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
                width: 300.scale(),
                height: 441.scale(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.scale())),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: 70.scale(),
                height: 70.scale(),
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(70.scale()/2.0)),
                   border: Border.all(color: Colors.white, width: 4.scale()),
                    image: DecorationImage(
                       image: NetworkImage(avatarUrl),
                       fit: BoxFit.cover
                    )
                  )
              ),
            ),
          ],
        ),
        color: Colors.transparent,
        width: 300.scale(),
        height: 461.scale(),
      ),
    );
  }
}