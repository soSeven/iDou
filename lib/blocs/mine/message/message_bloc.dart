import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_event.dart';
import 'message_state.dart';
import 'dart:async';
import 'package:idou/network/mine/mine_api.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {

  MessageBloc() : super(MessageInitial());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is MessageFetched) {
      try {
          final messages = await MineApi.postWithMessageList(page: event.page);
          if (messages == null) {
            yield MessageSuccess(messages: messages, isHeaderRefresh: event.isHeaderRefresh);
          } else {
            yield MessageSuccess(messages: messages, isHeaderRefresh: event.isHeaderRefresh);
          }
      } catch (e) {
        yield MessageFailure(error: e is String ? e : '请求失败', isHeaderRefresh: event.isHeaderRefresh);
      }
    }
  }

}