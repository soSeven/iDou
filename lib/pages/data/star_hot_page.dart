import 'package:flutter/material.dart';
import 'package:idou/bean/star_hot_bean.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/blocs/data/star_hot_bloc.dart';
import 'package:idou/utils/utils.dart';
import 'package:idou/widgets/refresh_scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class StarHotPage extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static const int HEAD_LINE_COUNT = 1;

  @override
  Widget build(BuildContext context) {
    final StarHotBloc bloc = BlocProvider.of<StarHotBloc>(context);

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
          '星图热榜',
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
              AsyncSnapshot<List<StarHotBean>> snapshot) {
            var list = snapshot.data;
            return new RefreshScaffold(
              labelId: "refresh",
              loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
              controller: _refreshController,
              enablePullUp: false,
              enablePullDown: false,
              enableFloatButton: false,
              itemCount: HEAD_LINE_COUNT +
                  (snapshot.data == null ? 0 : snapshot.data.length),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Image.asset(
                    Utils.getImgPath("banner_star_hot"),
                    height: 145,
                    fit: BoxFit.cover,
                  );
                }
                StarHotBean bean = list[index - HEAD_LINE_COUNT];
                return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                    leading: Container(
                      height: 29,
                      width: 25,
                      alignment: Alignment.center,
                      child: _buildRankIcon(index - HEAD_LINE_COUNT + 1),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          spacing: 9,
                          children: <Widget>[
                            Text(bean.nickName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            Wrap(
                                spacing: 9,
                                children: bean.tags
                                    ?.map((e) => Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: Color(0xff232530)),
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xff8b8c91)),
                                        )))
                                    ?.toList())
                          ],
                        ),
                        Text("热榜指数:${bean.score}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 11, color: Color(0xff8b8c91))),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text("${bean.followerStr}粉丝",
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

  Widget _buildRankIcon(int index) {
    if (1 <= index && index <= 3) {
      return Image.asset(
        Utils.getImgPath('rank_icon_$index'),
        height: 29,
      );
    }
    return Text("$index",
        style: TextStyle(fontSize: 14, color: Color(0xff8b8c91)));
  }
}
