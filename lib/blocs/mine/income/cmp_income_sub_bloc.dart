import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idou/bean/mine/cpm_income_model.dart';
import 'package:idou/bean/mine/page_model.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_event.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_state.dart';
import 'dart:async';
import 'package:idou/network/mine/mine_api.dart';

class CmpIncomeSubBloc extends Bloc<CmpIncomeSubEvent, CmpInComeSubState> {

  final InComeTimeType type;

  CmpIncomeSubBloc({this.type}) : super(CmpInComeSubStateInitial());

  @override
  Stream<CmpInComeSubState> mapEventToState(CmpIncomeSubEvent event) async* {
    if (event is CmpIncomeSubEventFetched) {
      try {
        final page = PageModel(total: 10, page: event.page, count: 1);
        final data = CpmIncomeDataModel(
          id: 2,
          encodeId: '690caoZBkDPdrfJYgPT+8ICG4QpZE3OvSCDYSzEM',
          title: '测试2',
          thumb: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594982021733&di=ba88251dac08319d03a8b31b628a7a2f&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F-vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2Fd53f8794a4c27d1e8ff07fe61fd5ad6eddc43839.jpg',
          todayVisitNum: 0,
          income: '0.00',
          yesterdayIncome: '0.00',
          todayPredictIncome: '0.00',
        );
        final obj = await CpmIncomeModel(page: page, data: [data]);
//        final obj = await MineApi.postWithCpmIncomeList(page: event.page, type: type);
        if (obj != null) {
          yield CmpInComeSubStateSuccess(model: obj, isHeaderRefresh: event.isHeaderRefresh);
        } else {
          yield CmpInComeSubStateFailure(error: '请求失败', isHeaderRefresh: event.isHeaderRefresh);
        }
      } catch (e) {
        yield CmpInComeSubStateFailure(error: e is String ? e : '请求失败', isHeaderRefresh: event.isHeaderRefresh);
      }
    }
  }

}