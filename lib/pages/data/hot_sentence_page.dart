import 'package:flutter/material.dart';
import 'package:idou/bean/hot_sentence_bean.dart';
import 'package:idou/bean/hot_video_bean.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/blocs/data/hot_sentence_bloc.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/utils/navigator_util.dart';
import 'package:idou/utils/utils.dart';
import 'package:idou/widgets/refresh_scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

var _tabs = ["抖音话题", "爱抖家族话题"];
var _isFirstInit = true;

class HotSentencePage extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static const int HEAD_LINE_COUNT = 0;

  @override
  Widget build(BuildContext context) {
    final HotSentenceBloc bloc = BlocProvider.of<HotSentenceBloc>(context);

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
          '热点话题',
          style: TextStyle(
            fontSize: 18, //设置字体大小
          ),
        ),
        centerTitle: true,
        elevation: 0, //隐藏底部阴影分割线
      ),
      body: _buildBody(bloc),
    );
  }

  Widget _buildBody(HotSentenceBloc bloc) {
    return StreamBuilder(
        stream: bloc.dataChangeSubject,
        builder: (BuildContext context,
            AsyncSnapshot<List<HotSentenceBean>> snapshot) {
          var list = snapshot.data;

          return RefreshScaffold(
            labelId: "refresh",
            loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
            controller: _refreshController,
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh();
            },
            onLoadMore: () {
              bloc.onLoadMore();
            },
            child: CustomScrollView(slivers: <Widget>[
              // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
              SliverToBoxAdapter(
                child: _buildHeader(bloc),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var bean = list[index - HEAD_LINE_COUNT];
                    return _buildListItem(bloc, bean, index);
                  },
                  childCount: HEAD_LINE_COUNT +
                      (snapshot.data == null ? 0 : snapshot.data.length),
                ),
              )
            ]),
          );
        });
  }

  Container _buildHeader(HotSentenceBloc bloc) {
    LogUtil.e("HotSentencePage, _buildHeader");
    return Container(
      decoration: BoxDecoration(
          color: MyColors.app_main,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xff383a43)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            Utils.getImgPath("banner_hot_sentence"),
            height: 145,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text("更新于：2020-07-02 09:16:34",
                style: TextStyle(fontSize: 12, color: Color(0xff8b8c91))),
          ),
          StreamBuilder(
              stream: bloc.curTabIndexSubject,
              initialData: 0,
              builder: ((BuildContext context, AsyncSnapshot<int> snapshot) {
                var curTabIndex = snapshot.data;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _tabs
                      .asMap()
                      .keys
                      .map(
                        (index) => GestureDetector(
                            onTap: () {
                              if (index != curTabIndex) {
                                bloc.curTabIndexSubject.add(index);
                                _refreshController.resetNoData();
                                //请求数据
                                bloc.changeTabList(index);
                              }
                            },
                            child: Column(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 12, 15, 12),
                                    child: Text(
                                      _tabs[index],
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: curTabIndex == index
                                              ? Colors.white
                                              : Color(0xff8b8c91)),
                                    )),
                                Container(
                                  width: index == curTabIndex ? 15 : 0,
                                  height: 2,
                                  color: Color(0xffff324d),
                                )
                              ],
                            )),
                      )
                      .toList(),
                );
              })),
        ],
      ),
    );
  }

  Widget _buildListItem(HotSentenceBloc bloc, HotSentenceBean bean, int index) {
    //第一次打开，自动展开第一行
    if (_isFirstInit && index == 0) {
      _isFirstInit = false;
      bloc.hotSearchVideos(bean.sentence);
    }

    return Column(
      children: <Widget>[
        ListTile(
            onTap: () {
              if (bloc.subTitleSubject.value == bean.sentence) {
                bloc.subTitleSubject.add("");
              } else {
                bloc.hotSearchVideos(bean.sentence);
              }
            },
//            contentPadding:
//                EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
            title: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 24,
                  margin: EdgeInsets.only(right: 15),
                  child: Text("${index + 1 - HEAD_LINE_COUNT}",
                      style: TextStyle(
                          fontSize: 18,
                          color: index < 3
                              ? Color(0xfff3cf4a)
                              : Color(0xff8b8c91))),
                ),
                Expanded(
                  child: Text(bean.sentence,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
                index < 3
                    ? Container(
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: Color(0xffFF324D),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text("热",
                            style:
                                TextStyle(fontSize: 11, color: Colors.white)),
                      )
                    : Container(width: 0, height: 0),
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
                Text("${bean.hotLevelStr ?? bean.hotLevel}",
                    maxLines: 1,
                    style: TextStyle(fontSize: 14, color: Color(0xff8b8c91))),
              ],
            )),
        _buildSubList(bloc, bean),
      ],
    );
  }

  StreamBuilder<String> _buildSubList(
      HotSentenceBloc bloc, HotSentenceBean bean) {
    return StreamBuilder(
        stream: bloc.subTitleSubject,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data != bean.sentence) return Container();
          return StreamBuilder(
            stream: bloc.subTitleListSubject,
            builder: (BuildContext context,
                AsyncSnapshot<List<HotVideoBean>> snapshot) {
              if (snapshot.data == null) return Container();
              var subList = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                itemCount: subList.length,
                itemBuilder: (BuildContext context, int index) {
                  var subBean = subList[index];
                  return buildSubListItem(subBean, context);
                },
              );
            },
          );
        });
  }

  ListTile buildSubListItem(HotVideoBean subBean, BuildContext context) {
    return ListTile(
        onTap: () {
          NavigatorUtil.pushWeb(context,
              title: "抖音短视频", url: subBean.shareUrl);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 15),
              child: Image.network(
                subBean.cover,
                width: 40,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(subBean.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
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
            Text("${subBean.hotLevelStr ?? subBean.hotLevel}",
                maxLines: 1,
                style: TextStyle(fontSize: 14, color: Color(0xff8b8c91))),
          ],
        ));
  }
}
