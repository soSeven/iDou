import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/bean/mine/cpm_income_model.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_bloc.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_event.dart';
import 'package:idou/blocs/mine/income/cmp_income_sub_state.dart';
import 'package:idou/extension/import_extension.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/pages/mine/cashBag/cash_cpm_item.dart';
import 'package:idou/pages/mine/income/cpm_income_Item.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/extension/assetImage_extension.dart';
import 'package:idou/extension/color_extension.dart';
import 'package:idou/widgets/normal_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:idou/widgets/toast.dart';
import 'package:idou/network/mine/mine_api.dart';

class CashCmpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Bloc.BlocProvider(
      create: (context) => CmpIncomeSubBloc(type: InComeTimeType.month),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'CPM收益记录',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.scale(),
              fontWeight: FontWeight.bold,
              fontFamily: MineUtil.fontFamily,
            ),
          ),
          centerTitle: true,
          backgroundColor: HexColor.fromHex('#181824'),
          elevation: 0,
          leading: FlatButton(
            child: ConstrainedBox(
              child: Image(
                image: LoadImage.localImage('icon_back'),
              ),
              constraints: BoxConstraints.tightFor(width: 9.scale(), height: 16.scale()),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _CashCmpPageListView(),
        backgroundColor: HexColor.fromHex('#181824'),
      ),
    );
  }

}

class _CashCmpPageListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _CashCmpPageListViewState();

}

class _CashCmpPageListViewState extends State<_CashCmpPageListView> {

  final _controller = RefreshController(initialRefresh: true);
  final _headerRefresh = WaterDropHeader();
  final _footerRefresh = ClassicFooter();
  var _page = 1;
  var _dataList = <CpmIncomeDataModel>[];
  var _selection = '';
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
            return Column(
              children: <Widget>[
                _getTopView(),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CashCpmPage();
//                        return CpmIncomeItem(model: _dataList[index],);
                      },
                      itemCount: _dataList.length,
                      itemExtent: 87.scale(),
                    ),
                    header: _headerRefresh,
                    footer: _footerRefresh,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    controller: _controller,
                  ),
                ),
              ],
            );
          }

        },
      ),
    );
  }

  Widget _getTopView() {
    return Container(
      child: Row(
        children: <Widget>[
          PopupMenuButton(
            color: HexColor.fromHex('#3A3A44'),
            onCanceled: (){},
            onSelected: (d){},
            itemBuilder: (context) {
              List<PopupMenuEntry> list = List<PopupMenuEntry>();
              list.add(PopupMenuItem(
                height: 32.scale(),
                value: '1',
                child: Center(child: NormalText.normal(text: '2020-07', fontSize: 15, textAlign: TextAlign.center),)
              ),);
              list.add(PopupMenuItem(
                  height: 30.scale(),
                  value: '1',
                  child: Center(child: NormalText.normal(text: '2020-07', fontSize: 15, textAlign: TextAlign.center),)
              ),);
              return list;
            },
//                        initialValue: 'ddddd',
            child: NormalButton(
              child: Row(
                children: <Widget>[
                  NormalText.normal(text: '本月', fontSize: 12),
                  SizedBox(width: 7.scale(),),
                  Image(image: LoadImage.localImage('arrow_gay'), height: 13.scale(), width: 13.scale(),)
                ],
              ),
              height: 30.scale(),
              color: HexColor.fromHex('#3A3A44'),
              padding: EdgeInsets.only(left: 17.scale(), right: 17.scale()),
              borderRadius: BorderRadius.circular(2.scale()),
              margin: EdgeInsets.only(bottom: 5.scale()),
            ),
            offset: Offset(0, 50.scale()),
          ),
          Column(
            children: <Widget>[
              NormalText.normal(text: '待发放', fontSize: 13, color: HexColor.fromHex('#8B8C91')),
              SizedBox(height: 9.scale(),),
              NormalText.normal(text: '+12.21', fontSize: 17),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      color: HexColor.fromHex('#23252F'),
      height: 83.scale(),
      padding: EdgeInsets.only(left: 15.scale(), right: 15.scale()),
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

}


