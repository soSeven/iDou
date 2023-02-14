import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/blocs/mine/invite/invite_event.dart';
import 'package:idou/blocs/mine/invite/invite_state.dart';
import 'package:idou/blocs/mine/team/team_event.dart';
import 'package:idou/blocs/mine/team/team_state.dart';
import 'dart:async';
import 'package:idou/network/mine/mine_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {

  TeamBloc() : super(TeamState(user: 0, bind: 0, vip: 0));

  @override
  Stream<TeamState> mapEventToState(TeamEvent event) async* {
    final currentState = state;
    if (event is TeamEventUser) {
      yield TeamState(user: event.number, bind: currentState.bind, vip: currentState.vip);
    }
    if (event is TeamEventBind) {
      yield TeamState(user: currentState.user, bind: event.number, vip: currentState.vip);
    }
    if (event is TeamEventVip) {
      yield TeamState(user: currentState.user, bind: currentState.bind, vip: event.number);
    }
  }

}