import 'package:flutter/foundation.dart';

abstract class TeamSubEvent {

  const TeamSubEvent();

}

class TeamSubEventFetched extends TeamSubEvent {

  final int page;
  final int limit;
  final bool isHeaderRefresh;

  const TeamSubEventFetched({@required this.page, this.limit = 10, this.isHeaderRefresh = false});

}