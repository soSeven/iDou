import 'package:idou/bean/mine/message_model.dart';


abstract class MessageState {

  const MessageState();

}

class MessageInitial extends MessageState {}

class MessageFailure extends MessageState {

  final String error;
  final bool isHeaderRefresh;

  const MessageFailure({this.error, this.isHeaderRefresh = false});

}

class MessageSuccess extends MessageState {

  final List<MessageModel> messages;
  final bool isHeaderRefresh;

  const MessageSuccess({this.messages, this.isHeaderRefresh = false});


}