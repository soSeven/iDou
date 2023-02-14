import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:idou/blocs/mine/team/team_bloc.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/widgets/ext_tab_indicator.dart';
import 'team_sub_page.dart';
import 'package:idou/blocs/mine/team/team_state.dart';
import 'package:idou/network/mine/mine_api.dart';

class TeamPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Bloc.BlocProvider<TeamBloc> (
        create: (context) => TeamBloc(),
        child: _TeamPage(),
      ),
    );
  }
}

class _TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Bloc.BlocBuilder<TeamBloc, TeamState>(
      bloc: Bloc.BlocProvider.of(context),
      builder: (context, state) {
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
            bottom: TabBar(
              unselectedLabelColor: HexColor.fromHex('#8B8C91'),
              indicator: ExtUnderlineTabIndicator(
                borderSide: BorderSide(width: 2.scale(), color: HexColor.fromHex('#FF324D')),
              ),
              tabs: <Widget>[
                Tab(text: '潜在用户(${state.user})'),
                Tab(text: '已绑定(${state.bind})'),
                Tab(text: 'VIP会员(${state.vip})'),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                height: 0.5,
                color: HexColor.fromHex('#383A43'),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    TeamSubPage(type: TeamSubUrlType.user),
                    TeamSubPage(type: TeamSubUrlType.bind),
                    TeamSubPage(type: TeamSubUrlType.vip),
                  ],
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
          backgroundColor: HexColor.fromHex('#181824'),
        );
      },
    );
  }
}
