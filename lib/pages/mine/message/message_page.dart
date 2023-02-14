import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as Bloc;
import 'package:idou/bean/mine/message_model.dart';
import 'package:idou/blocs/mine/message/message_event.dart';
import 'package:idou/blocs/mine/message/message_state.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:idou/extension/assetImage_extension.dart';
import 'package:idou/extension/color_extension.dart';
import 'package:idou/blocs/mine/message/message_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:idou/widgets/toast.dart';
import 'message_item.dart';


class MessagePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MessagePageState();

}

class _MessagePageState extends State<MessagePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '消息',
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
      body: _getBody(),
      backgroundColor: HexColor.fromHex('#181824'),
    );
  }

  Widget _getBody() {
    return Bloc.BlocProvider(
      create: (context) => MessageBloc(),
      child: _MessagePageListView(),
    );
  }

}

class _MessagePageListView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MessagePageListViewState();

}

class _MessagePageListViewState extends State<_MessagePageListView> {

  final _controller = RefreshController(initialRefresh: true);
  final _headerRefresh = WaterDropHeader();
  final _footerRefresh = ClassicFooter();
  var _page = 1;
  var _dataList = <MessageModel>[];
  MessageBloc _messageBloc;

  // MARK: - Refresh Event

  void _onRefresh() {
    print('on Refresh');
    _page = 1;
    _messageBloc.add(MessageFetched(page: _page, isHeaderRefresh: true));
  }

  void _onLoading() {
    print('on Loading');
//    _page ++;
    _messageBloc.add(MessageFetched(page: _page));
  }

  @override
  void initState() {
    super.initState();
    _messageBloc = Bloc.BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Bloc.BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is MessageFailure && _dataList.isNotEmpty) {
          Toast.showToast(context: context, text: state.error);
        }
      },
      child: Bloc.BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageFailure) {
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

          if (state is MessageSuccess) {
            if (state.isHeaderRefresh) {
              _controller.refreshCompleted();
              _controller.resetNoData();
              _dataList.clear();
              _dataList.addAll(state.messages);
            } else {
              if (state.messages.isEmpty) {
                _controller.loadNoData();
              } else {
                _dataList.addAll(state.messages);
                _controller.loadComplete();
              }
            }
          }

          if (_dataList.isEmpty && !(state is MessageInitial)) {
            return _getEmptyView();
          } else {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MessageItem(message: _dataList[index],);
                },
                itemCount: _dataList.length,
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
              image: LoadImage.localImage('news_not_icon'),
            ),
            constraints: BoxConstraints.tightFor(width: 100.scale(), height: 100.scale()),
          ),
          Padding(
            child: Text(
                '暂时还没有消息',
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
