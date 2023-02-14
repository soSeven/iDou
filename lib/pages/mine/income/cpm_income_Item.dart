import 'package:flutter/material.dart';
import 'package:idou/bean/mine/cpm_income_model.dart';
import 'package:idou/extension/import_extension.dart';

class CpmIncomeItem extends StatelessWidget {

  final CpmIncomeDataModel model;

  const CpmIncomeItem({@required this.model});

  @override
  Widget build(BuildContext context) {

    Widget _getTop() {
      return Container(
        margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 23.scale()),
        child: Row(
          children: <Widget>[
            Container(
                width: 44.scale(),
                height: 44.scale(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(44.scale()/2.0)),
                    image: DecorationImage(
                        image: NetworkImage(model.thumb ?? ''),
                        fit: BoxFit.cover
                    )
                )
            ),
            Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      NormalText.normal(
                        text: model.title ?? '',
                        fontSize: 15,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(height: 3.scale(),),
                      NormalText.normal(
                        text: '今日访问：${model.todayVisitNum ?? 0}',
                        color: HexColor.fromHex('#8B8C91'),
                        fontSize: 11,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                  ),
                  margin: EdgeInsets.only(left: 15.scale()),
                )
            ),
            InkWell(
              child: Row(
                children: <Widget>[
                  NormalText.normal(
                    text: '详细数据',
                    fontSize: 13,
                    color: HexColor.fromHex('#8B8C91'),
                  ),
                  SizedBox(width: 5.scale(),),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 13.scale(), height:13.scale()),
                    child: Image(
                      image: LoadImage.localImage('my_profit_into'),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            )
          ],
        ),
      );
    }

    Widget _getBottom() {

      Widget _getItem(String title, String price) {
        return Column(
          children: <Widget>[
            NormalText.normal(
              text: price,
              fontSize: 21,
            ),
            NormalText.normal(
              text: title,
              fontSize: 13,
              color: HexColor.fromHex('#8B8C91')
            ),
            SizedBox(height: 24.scale(),)
          ],
        );
      }

      return Container(
        child: Row(
          children: <Widget>[
            _getItem('本月已获得(元)', model.income ?? '0.00'),
            _getItem('今日预估(元)', model.todayPredictIncome ?? '0.00'),
            _getItem('昨日收益(元)', model.yesterdayIncome ?? '0.00')
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      );
    }

    return Center(
        child: Container(
          margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 15.scale(), bottom: 15.scale()),
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
          decoration: BoxDecoration(
            color: HexColor.fromHex('#23252F'),
            borderRadius: BorderRadius.circular(5.scale()),
          ),
        )
//        height: 90.scale(),
    );
  }

}