import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/blocs/mine/bindphone/bind_phone_event.dart';
import 'package:idou/blocs/mine/bindphone/bind_phone_state.dart';
import 'dart:async';
import 'package:idou/network/mine/mine_api.dart';

class BindPhoneBloc extends Bloc<BindPhoneEvent, BindPhoneState> {

  BindPhoneBloc() : super(BindPhoneStateInitial());

  @override
  Stream<BindPhoneState> mapEventToState(BindPhoneEvent event) async* {
    if (event is BindPhoneEventPhoneComplete) {
      yield BindPhoneStatePhoneCompleted();
    }
    if (event is BindPhoneEventPhoneNotComplete) {
      yield BindPhoneStatePhoneNotCompleted();
    }
    if (event is BindPhoneEventCheckCodeGet) {
      try {
        await MineApi.postWithCheckCode(event.phone);
        yield BindPhoneStateCheckCodeGetSuccess();
      } catch (e) {
        yield BindPhoneStateCheckCodeGetFailure();
      }
    }
    if (event is BindPhoneEventComplete) {
      yield BindPhoneStateCompleted();
    }
    if (event is BindPhoneEventNotComplete) {
      yield BindPhoneStateNotCompleted();
    }
    if (event is BindPhoneEventUpload) {
      try {
        if (event.weChat != null && event.weChat.length > 0) {
          await MineApi.postWithBindPhone(event.phone, event.checkCode);
          await MineApi.postWithChangeWeChat(event.weChat);
          yield BindPhoneStateSuccess();
        } else {
          await MineApi.postWithBindPhone(event.phone, event.checkCode);
          yield BindPhoneStateSuccess();
        }
      } catch (e) {
        yield BindPhoneStateFailure(e is String ? e : '提交失败');
      }
    }
  }
}