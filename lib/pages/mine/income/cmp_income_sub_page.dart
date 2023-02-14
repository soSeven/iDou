import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/bean/mine/cpm_income_model.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_bloc.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_event.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_state.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/pages/mine/income/cpm_income_Item.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/extension/assetImage_extension.dart';
import 'package:idou/extension/color_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:idou/widgets/toast.dart';
import 'package:idou/network/mine/mine_api.dart';

class CmpIncomeSubPage extends StatelessWidget {

  final InComeTimeType type;

  const CmpIncomeSubPage({@required this.type});

  @override
  Widget build(BuildContext context) {
    return Bloc.BlocProvider(
      create: (context) => CmpIncomeSubBloc(type: type),
      child: _CmpIncomeSubPageListView(),
    );
  }

}

class _CmpIncomeSubPageListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CmpIncomeSubPageListViewState();

}

class _CmpIncomeSubPageListViewState extends State<_CmpIncomeSubPageListView> with AutomaticKeepAliveClientMixin {

  final _controller = RefreshController(initialRefresh: true);
  final _headerRefresh = WaterDropHeader();
  final _footerRefresh = ClassicFooter();
  var _page = 1;
  var _dataList = <CpmIncomeDataModel>[];
  CmpIncomeSubBloc _bloc;

  // MARK: - Refresh Event

  void _onRefresh() {
    print('on Refresh');
    _page = 1;
    _bloc.add(CmpIncomeSubEventFetched(page: _page, isHeaderRefresh: true));
  }

  void _onLoading() {
    print('on Loading');
    _page ++;
    _bloc.add(CmpIncomeSubEventFetched(page: _page));
  }

  @override
  void initState() {
    super.initState();
    _bloc = Bloc.BlocProvider.of<CmpIncomeSubBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Bloc.BlocListener<CmpIncomeSubBloc, CmpInComeSubState>(
      listener: (context, state) {
        if (state is CmpInComeSubStateFailure &&
            _dataList.isNotEmpty) {
          Toast.showToast(context: context, text: state.error);
        }
      },
      child: Bloc.BlocBuilder<CmpIncomeSubBloc, CmpInComeSubState>(
        builder: (context, state) {
          if (state is CmpInComeSubStateFailure) {
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

          if (state is CmpInComeSubStateSuccess) {

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

          if (_dataList.isEmpty && !(state is CmpInComeSubStateInitial)) {
            return _getEmptyView();
          } else {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CpmIncomeItem(model: _dataList[index],);
                },
                itemCount: _dataList.length,
                itemExtent: 205.scale(),
              ),
              header: _headerRefresh,
              footer: _footerRefresh,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _controller,
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
              image: LoadImage.localImage('profit_not_icon'),
            ),
            constraints: BoxConstraints.tightFor(width: 100.scale(), height: 100.scale()),
          ),
          Padding(
            child: Text(
              '您暂时还没有收益记录哦',
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