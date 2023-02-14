import 'package:flutter/foundation.dart';

abstract class CmpIncomeSubEvent {

  const CmpIncomeSubEvent();

}

class CmpIncomeSubEventFetched extends CmpIncomeSubEvent {

  final int page;
  final int limit;
  final bool isHeaderRefresh;

  const CmpIncomeSubEventFetched({@required this.page, this.limit = 10, this.isHeaderRefresh = false});

}