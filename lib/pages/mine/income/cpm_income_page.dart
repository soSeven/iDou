import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:idou/blocs/mine/team/team_bloc.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/pages/mine/income/cmp_income_sub_page.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/widgets/ext_tab_indicator.dart';
import 'package:idou/pages/mine/team/team_sub_page.dart';
import 'package:idou/blocs/mine/team/team_state.dart';
import 'package:idou/network/mine/mine_api.dart';

class CPMIncomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: _CPMIncomePage(),
    );
  }
}

class _CPMIncomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 15.scale(),),
          TabBar(
            unselectedLabelColor: HexColor.fromHex('#8B8C91'),
            indicator: ExtUnderlineTabIndicator(
              borderSide: BorderSide(width: 2.scale(), color: HexColor.fromHex('#FF324D')),
            ),
            tabs: <Widget>[
              Tab(text: '本月收益排序'),
              Tab(text: '昨日收益排序'),
              Tab(text: '累计收益排序'),
            ],
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  height: 0.5,
                  color: HexColor.fromHex('#383A43'),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      CmpIncomeSubPage(type: InComeTimeType.month),
                      CmpIncomeSubPage(type: InComeTimeType.yesterday),
                      CmpIncomeSubPage(type: InComeTimeType.all),
                    ],
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          )
        ],
      ),
    );

  }
}