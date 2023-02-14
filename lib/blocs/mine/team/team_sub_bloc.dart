import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/bean/mine/team_sub_model.dart';
import 'package:idou/blocs/mine/team/team_sub_event.dart';
import 'package:idou/blocs/mine/team/team_sub_state.dart';
import 'dart:async';
import 'package:idou/network/mine/mine_api.dart';

class TeamSubBloc extends Bloc<TeamSubEvent, TeamSubState> {

  final TeamSubUrlType type;

  TeamSubBloc({this.type}) : super(TeamSubStateInitial());

  @override
  Stream<TeamSubState> mapEventToState(TeamSubEvent event) async* {
    if (event is TeamSubEventFetched) {
      try {
        final page = TeamSubPageModel(total: 10, page: event.page, count: 1);
        final data = TeamSubDataModel(id: 1,encodeId: 'dfdf', nickname: '一个我', avatar: 'http://api-testing.duoduoxingqiu.com/static/index/image/default.png', createTime: '2019-12-31 01:21:58');
        final obj = await TeamSubModel(page: page, data: [data]);
//        final obj = await MineApi.postWithTeamUserList(page: event.page, type: type);
        if (obj != null) {
          yield TeamSubStateSuccess(model: obj, isHeaderRefresh: event.isHeaderRefresh);
        } else {
          yield TeamSubStateFailure(error: '请求失败', isHeaderRefresh: event.isHeaderRefresh);
        }
      } catch (e) {
        yield TeamSubStateFailure(error: e is String ? e : '请求失败', isHeaderRefresh: event.isHeaderRefresh);
      }
    }
  }

}