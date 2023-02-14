import 'package:flutter/material.dart';
import 'package:idou/bean/hot_video_bean.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/blocs/data/hot_video_bloc.dart';
import 'package:idou/utils/utils.dart';
import 'package:idou/widgets/refresh_scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class HotVideoPage extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static const int HEAD_LINE_COUNT = 1;

  @override
  Widget build(BuildContext context) {
    final HotVideoBloc bloc = BlocProvider.of<HotVideoBloc>(context);

    bloc.listStatusSubject.listen((isNoMore) {
      //是否还有下一页
      if (isNoMore) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
      _refreshController.refreshCompleted();
    });
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
      bloc.getData();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '热门视频',
          style: TextStyle(
            fontSize: 18, //设置字体大小
          ),
        ),
        centerTitle: true,
        elevation: 0, //隐藏底部阴影分割线
      ),
      body: new StreamBuilder(
          stream: bloc.dataChangeSubject,
          builder: (BuildContext context,
              AsyncSnapshot<List<HotVideoBean>> snapshot) {
            var list = snapshot.data;
            return new RefreshScaffold(
              labelId: "refresh",
              loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
              controller: _refreshController,
              onRefresh: ({bool isReload}) {
                return bloc.onRefresh();
              },
              onLoadMore: () {
                bloc.onLoadMore();
              },
              itemCount: HEAD_LINE_COUNT +
                  (snapshot.data == null ? 0 : snapshot.data.length),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Image.asset(
                    Utils.getImgPath("banner_hot_video"),
                    height: 145,
                    fit: BoxFit.cover,
                  );
                }
                HotVideoBean bean = list[index - HEAD_LINE_COUNT];
                return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 24,
                          margin: EdgeInsets.only(right: 13),
                          child: Text("${index + 1 - HEAD_LINE_COUNT}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: index <= 3
                                      ? Color(0xfff3cf4a)
                                      : Color(0xff8b8c91))),
                        ),
                        Image.network(
                          bean.cover,
                          width: 40,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    title: Wrap(
                      children: <Widget>[
                        Text(bean.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(fontSize: 14, color: Colors.white))
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          Utils.getImgPath("home_icon_hot"),
                          width: 13,
                          height: 10,
                        ),
                        Text("${bean.hotLevelStr}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff8b8c91))),
                      ],
                    ));
              },
            );
          }),
    );
  }
}
