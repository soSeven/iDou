import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/bean/mine/team_sub_model.dart';
import 'package:idou/blocs/mine/team/team_bloc.dart';
import 'package:idou/blocs/mine/team/team_event.dart';
import 'package:idou/blocs/mine/team/team_sub_bloc.dart';
import 'package:idou/blocs/mine/team/team_sub_event.dart';
import 'package:idou/blocs/mine/team/team_sub_state.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/pages/mine/team/team_sub_item.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/extension/assetImage_extension.dart';
import 'package:idou/extension/color_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:idou/widgets/toast.dart';
import 'package:idou/network/mine/mine_api.dart';

class TeamSubPage extends StatelessWidget {

  final TeamSubUrlType type;

  const TeamSubPage({@required this.type});

  @override
  Widget build(BuildContext context) {
    return Bloc.BlocProvider(
      create: (context) => TeamSubBloc(type: type),
      child: _TeamSubPageListView(),
    );
  }

}

class _TeamSubPageListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TeamSubPageListViewState();

}

class _TeamSubPageListViewState extends State<_TeamSubPageListView> with AutomaticKeepAliveClientMixin {

  final _controller = RefreshController(initialRefresh: true);
  final _headerRefresh = WaterDropHeader();
  final _footerRefresh = ClassicFooter();
  var _page = 1;
  var _dataList = <TeamSubDataModel>[];
  TeamSubBloc _bloc;
  TeamBloc _teamBloc;

  // MARK: - Refresh Event

  void _onRefresh() {
    print('on Refresh');
    _page = 1;
    _bloc.add(TeamSubEventFetched(page: _page, isHeaderRefresh: true));
  }

  void _onLoading() {
    print('on Loading');
    _page ++;
    _bloc.add(TeamSubEventFetched(page: _page));
  }

  void _refreshNumber(int n) {
    switch (_bloc.type) {
      case TeamSubUrlType.user:
        _teamBloc.add(TeamEventUser(number: n));
        break;
      case TeamSubUrlType.bind:
        _teamBloc.add(TeamEventBind(number: n));
        break;
      case TeamSubUrlType.vip:
        _teamBloc.add(TeamEventVip(number: n));
        break;
    }
  }

  Widget _getHeaderView() {
    switch (_bloc.type) {
      case TeamSubUrlType.user:
        return Container(
          child: NormalText.normal(
            text: '以下粉丝将为您锁粉24小时，如果24小时内未开通或未绑定抖音号，后续事件付款开通VIP或绑定抖音号，所得收益可能归其他人所有。',
            fontSize: 11,
            color: HexColor.fromHex('#F3CF4A'),
          ),
          margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 23.scale(), bottom: 19.scale()),
        );
      case TeamSubUrlType.bind:
        return Container(
          child: NormalText.normal(
            text: '已经授权绑定抖音号，将永久是您的团队成员',
            fontSize: 11,
            color: HexColor.fromHex('#F3CF4A'),
          ),
          margin: EdgeInsets.only(left: 15.scale(), right: 15.scale(), top: 23.scale(), bottom: 19.scale()),
        );
        break;
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = Bloc.BlocProvider.of<TeamSubBloc>(context);
    _teamBloc = Bloc.BlocProvider.of<TeamBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Bloc.BlocListener<TeamSubBloc, TeamSubState>(
      listener: (context, state) {
        if (state is TeamSubStateFailure &&
            _dataList.isNotEmpty) {
          Toast.showToast(context: context, text: state.error);
        }
        if (state is TeamSubStateSuccess &&
            state.model.page != null) {
          _refreshNumber(state.model.page.total);
        }
      },
      child: Bloc.BlocBuilder<TeamSubBloc, TeamSubState>(
        builder: (context, state) {
          if (state is TeamSubStateFailure) {
            if (_dataList.isEmpty) {
              return _getErrorView();
            } else {
              if (state.isHeaderRefresh) {
                _controller.refreshCompleted();
              } else {
                _controller.loadComplete();
              }
            }
          }

          if (state is TeamSubStateSuccess) {

            if (state.isHeaderRefresh) {
              _controller.refreshCompleted();
              _controller.resetNoData();
              _dataList.clear();
              if (state.model.data != null) {
                _dataList.addAll(state.model.data);
              }
            } else {
              if (state.model.page.total == _dataList.length) {
                _controller.loadNoData();
              } else {
                if (state.model.data != null) {
                  _dataList.addAll(state.model.data);
                }
                _controller.loadComplete();
              }
            }
          }

          if (_dataList.isEmpty && !(state is TeamSubStateInitial)) {
            return _getEmptyView();
          } else {
            return Column(
              children: <Widget>[
                _getHeaderView(),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return TeamSubItem(model: _dataList[index],);
                      },
                      itemCount: _dataList.length,
                      itemExtent: 72.scale(),
                    ),
                    header: _headerRefresh,
                    footer: _footerRefresh,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    controller: _controller,
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            );
          }

        },
      ),
    );
  }

  Widget _getEmptyView() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 130.scale(),),
          ConstrainedBox(
            child: Image(
              image: LoadImage.localImage('team_not_icon'),
            ),
            constraints: BoxConstraints.tightFor(width: 100.scale(), height: 100.scale()),
          ),
          Padding(
            child: Text(
              '您暂时还没有团队成员哦',
              style: TextStyle(
                color: HexColor.fromHex('#8B8C91'),
                fontSize: 14.scale(),
                fontFamily: MineUtil.fontFamily,
                fontWeight: FontWeight.normal,
              ),
            ),
            padding: EdgeInsets.only(top: 40.scale()),
          )
        ],
      ),

    );
  }

  Widget _getErrorView() {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 230.scale(),),
          Padding(
            child: Text(
              '请求失败',
              style: TextStyle(
                color: HexColor.fromHex('#8B8C91'),
                fontSize: 14.scale(),
                fontFamily: MineUtil.fontFamily,
                fontWeight: FontWeight.normal,
              ),
            ),
            padding: EdgeInsets.only(top: 40.scale()),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

}
