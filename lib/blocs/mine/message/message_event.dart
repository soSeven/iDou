
import 'package:flutter/foundation.dart';

abstract class MessageEvent {

  const MessageEvent();

}

class MessageFetched extends MessageEvent {

  final int page;
  final int limit;
  final bool isHeaderRefresh;

  const MessageFetched({@required this.page, this.limit = 10, this.isHeaderRefresh = false});

}