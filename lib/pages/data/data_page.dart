import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:idou/bean/dy_category_bean.dart';
import 'package:idou/bean/dy_category_data_bean.dart';
import 'package:idou/bean/rank_user_entity.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/blocs/data/data_page_bloc.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/pages/vip/vip_dialog.dart';
import 'package:idou/routes/data_route.dart';
import 'package:idou/utils/utils.dart';
import 'package:idou/widgets/ext_tab_indicator.dart';

bool isFirstInit = true;

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //增加一个父节点用于存放和管理model bloc
    return BlocProvider(child: DataPageStateless(), bloc: DataPageBloc());
  }
}

var isVip = false;

var _tabs = ["免费用户", "付费用户", "抖音粉丝"];

class DataPageStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildDataPage(context);
  }

  Widget buildDataPage(BuildContext context) {
    final DataPageBloc bloc = BlocProvider.of<DataPageBloc>(context);

    if (isFirstInit) {
      LogUtil.e("DataPage init......");
      isFirstInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.getRankUserList(false);
        bloc.getRankUserList(true);
        bloc.getDYCategory();
      });
      bloc.curDyTabIndexSubject.add(0);
    }

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '数据',
            style: TextStyle(
              fontSize: 18, //设置字体大小
            ),
          ),
          centerTitle: true,
          elevation: 0, //隐藏底部阴影分割线
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: _buildHeader(context),
              ),
              SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                      maxHeight: 49.0,
                      minHeight: 49.0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.app_main,
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.5, color: Color(0xff383a43)))),
                        child: TabBar(
                          indicator: ExtUnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 2.0, color: Color(0xffF43E5A))),
                          tabs: _tabs.map((e) => Tab(text: e)).toList(),
                        ),
                      )))
            ];
          },
          body: TabBarView(
//            physics: new NeverScrollableScrollPhysics(),
            children: [
              StreamBuilder(
                  stream: bloc.freeUserListSubject,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RankUserEntity>> snapshot) {
                    var model = snapshot.data;
                    if (model == null) {
                      return new Container(
                        height: 0.0,
                      );
                    }

                    return _buildRankList(context, snapshot.data);
                  }),
              StreamBuilder(
                  stream: bloc.vipUserListSubject,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<RankUserEntity>> snapshot) {
                    var model = snapshot.data;
                    if (model == null) {
                      return new Container(
                        height: 0.0,
                      );
                    }

                    return _buildRankList(context, snapshot.data);
                  }),
              _buildDyTabView(bloc, context),
            ],
          ),
        ),
      ),
    );
  }

  final Map<String, String> _bannerList = {
    "date_img01": DataRoute.routeHotVideo,
    "date_img02": DataRoute.routeStarHot,
    "date_img03": DataRoute.routeHotSentence
  };

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage(Utils.getImgPath('date_img_card')),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "64.68亿",
                      style: TextStyle(
                        fontSize: 23, //设置字体大小
                      ),
                    ),
                  ),
                  Text(
                    "达人昨日总播放量",
                    style: TextStyle(
                      fontSize: 11, //设置字体大小
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "116.15亿",
                      style: TextStyle(
                        fontSize: 23, //设置字体大小
                      ),
                    ),
                  ),
                  Text(
                    "达人总粉丝量",
                    style: TextStyle(
                      fontSize: 11, //设置字体大小
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "*小程序昨日总数据报表（每晚0点更新）",
              style: TextStyle(
                color: Color(0xFF8B8C91),
                fontSize: 11, //设置字体大小
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _bannerList.keys
              .map(
                (e) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(_bannerList[e]);
                  },
                  child: Image.asset(
                    Utils.getImgPath(e),
                    width: 108,
                    height: 64,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildRankList(BuildContext context, List<RankUserEntity> data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var bean = data[index];
          return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 13),
                    child: _buildRankIcon(index + 1),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(bean.avatar),
                  ),
                ],
              ),
              title: Text(bean.nickname,
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              trailing: Text(bean.income,
                  style: TextStyle(fontSize: 17, color: Color(0xFFF3CF4A))));
        });
  }

  // 抖音粉丝排行
  Widget _buildDyTabView(DataPageBloc bloc, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        //第一行tabs  //list, pos, isClose
        StreamBuilder(
            stream: bloc.dyCategorySubject,
            builder: (BuildContext context,
                AsyncSnapshot<List<DyCategoryBean>> snapshot) {
              var list = snapshot.data;
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (ObjectUtil.isEmpty(list) ||
                  snapshot.connectionState != ConnectionState.active) {
                return new Container(
                  height: 0.0,
                );
              }

              //请求数据
              if (isVip) bloc.getDYCategoryData(list[0].encodeId);

              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 0.5, color: Color(0xff383a43)))),
                height: 44,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: StreamBuilder(
                          stream: bloc.curDyTabIndexSubject,
//                          initialData: 0,
                          builder: ((BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            var curTabIndex = snapshot.data;
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: list
                                  .asMap()
                                  .keys
                                  .map(
                                    (index) => GestureDetector(
                                        onTap: () {
                                          if (index != curTabIndex) {
                                            bloc.curDyTabIndexSubject
                                                .add(index);
                                            //请求数据
                                            if (isVip)
                                              bloc.getDYCategoryData(
                                                  list[index].encodeId);
                                          }
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 12, 15, 12),
                                            child: Text(
                                              list[index].name,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: curTabIndex == index
                                                      ? Color(0xffff324d)
                                                      : Color(0xff8b8c91)),
                                            ))),
                                  )
                                  .toList(),
                            );
                          })),
                    ),
                    StreamBuilder(
                        stream: bloc.isDyTabClosedSubject.stream,
                        initialData: true,
                        builder: ((BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          var isCloseTab = snapshot.data != false;
                          return GestureDetector(
                            onTap: () {
                              bloc.isDyTabClosedSubject.sink.add(!isCloseTab);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                    Utils.getImgPath(isCloseTab
                                        ? 'home_icon_classification'
                                        : 'home_icon_close'),
                                    height: 14)),
                          );
                        })),
                  ],
                ),
              );
            }),

        //第二行是展开的 tabs
        StreamBuilder(
            stream: bloc.isDyTabClosedSubject.stream,
            initialData: true,
            builder: ((BuildContext context, AsyncSnapshot<bool> snapshot) {
              var isCloseTab = snapshot.data;
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (isCloseTab != false ||
                  snapshot.connectionState != ConnectionState.active) {
                return new Container(
                  height: 0.0,
                );
              }
              return StreamBuilder(
                  stream: bloc.dyCategorySubject,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DyCategoryBean>> snapshot) {
                    var list = snapshot.data;
                    if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else if (list == null ||
                        snapshot.connectionState != ConnectionState.active) {
                      return new Container(
                        height: 0.0,
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(color: Color(0xff23252f)),
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                      child: StreamBuilder(
                          stream: bloc.curDyTabIndexSubject,
//                          initialData: 0,
                          builder: ((BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            var curTabIndex = snapshot.data;
                            return Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 12,
                              runSpacing: 11,
                              children: list
                                  .asMap()
                                  .keys
                                  .map(
                                    (index) => GestureDetector(
                                        onTap: () {
                                          if (index != curTabIndex) {
                                            print("ontap $index, $curTabIndex");
                                            bloc.curDyTabIndexSubject
                                                .add(index);
                                            //请求数据
                                            bloc.getDYCategoryData(
                                                list[index].encodeId);
                                            //收起
                                            bloc.isDyTabClosedSubject.sink
                                                .add(true);
                                          }
                                        },
                                        child: Container(
//                                            margin: const EdgeInsets.fromLTRB(  15, 11, 0, 0),
                                            padding: const EdgeInsets.only(
                                                top: 9,
                                                bottom: 9.0,
                                                left: 13,
                                                right: 13),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: curTabIndex == index
                                                    ? Color(0xffff324d)
                                                    : Color(0xff3a3a44)),
                                            child: Text(
                                              list[index].name,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: curTabIndex == index
                                                      ? Colors.white
                                                      : Color(0xff8b8c91)),
                                            ))),
                                  )
                                  .toList(),
                            );
                          })),
                    );
                  });
            })),

        //第三行开始是List
        isVip
            ? StreamBuilder(
                stream: bloc.dyCategoryDataSubject,
                builder: (BuildContext context,
                    AsyncSnapshot<List<DyCategoryDataBean>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (!snapshot.hasData ||
                      snapshot.connectionState != ConnectionState.active) {
                    return new Container(
                      height: 0.0,
                    );
                  }

                  var list = snapshot.data;
                  return _buildDyRankList(list);
                })
            : _buildVIPTip(context),
      ],
    );
  }

  Column _buildVIPTip(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset(
            Utils.getImgPath("vip_holder"),
            height: 101,
          ),
        ),
        Text(
          "您还不是会员暂时无法查看数据哦",
          style: TextStyle(fontSize: 14, color: Color(0xfff1c891)),
        ),
        SizedBox(height: 21),
        FlatButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => VipDialog());
            },
            child: Container(
              width: 265,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffeec690)),
              child: Center(
                child: Text(
                  "开通会员",
                  style: TextStyle(fontSize: 16, color: Color(0xff793510)),
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildDyRankList(List<DyCategoryDataBean> data) {
    return ListView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var bean = data[0];
          return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 21,
                    height: 24,
                    margin: EdgeInsets.only(right: 13),
                    child: _buildRankIcon(index + 1),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(bean.avatar),
                  ),
                ],
              ),
              title: Text(bean.nickname,
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              trailing: Text("${bean.fansCount}",
                  style: TextStyle(fontSize: 17, color: Color(0xFFF3CF4A))));
        });
  }
}

Widget _buildRankIcon(int index) {
  if (1 <= index && index <= 3) {
    return Image.asset(
      Utils.getImgPath('rank_img_$index'),
      width: 21,
      height: 24,
    );
  }
  return Text("$index");
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
