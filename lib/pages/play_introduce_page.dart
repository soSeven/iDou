import 'package:base_library/base_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idou/bean/app_applet_bean.dart';
import 'package:idou/bean/bannerbean.dart';
import 'package:idou/bean/home_applet_classfy_bean.dart';
import 'package:idou/bean/play_introduce_search_bean.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/blocs/play_introduce_bloc.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/utils/navigator_util.dart';
import 'package:idou/widgets/fullternarquee/fullter_marquee_item.dart';
import 'package:idou/widgets/search_text_field_widget.dart';
import 'package:idou/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlayIntroducePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        child: PlayIntroduceStateless(), bloc: PlayIntroduceBloc());
  }
}

class PlayIntroduceStateless extends StatelessWidget {
  List<Category> searchTypeList = new List();
  int searchType = 0;
  String pageSearchContent = "";
  final controller = TextEditingController();
  bool isFirstIn = true ;

  @override
  Widget build(BuildContext context) {
    LogUtil.e("PlayIntroducePage build......");
    RefreshController _controller = new RefreshController();
    var appletClassfyBean = new Category();
    appletClassfyBean.id = 0;
    appletClassfyBean.name = "全部";
    searchTypeList.add(appletClassfyBean);
    var appletClassfyBean1 = new Category();
    appletClassfyBean1.id = 1;
    appletClassfyBean1.name = "平台";
    searchTypeList.add(appletClassfyBean1);
    var appletClassfyBean2 = new Category();
    appletClassfyBean2.id = 2;
    appletClassfyBean2.name = "抖音";
    searchTypeList.add(appletClassfyBean2);

    final PlayIntroduceBloc bloc = BlocProvider.of<PlayIntroduceBloc>(context);
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
      bloc.getPlayIntroBanner();
      bloc.getPlayIntroSearch(pageSearchContent, searchType);
    });
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff151921),
            centerTitle: true,
            title: Text("玩法介绍",
                style: TextStyle(fontSize: 18, color: Colors.white))),
        body: new StreamBuilder(
          stream: bloc.bannerStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<BannerBean>> snapshot) {
            return new ListView(shrinkWrap: true, children: [
              buildBanner(context, snapshot.data),
              Container(
                  padding: const EdgeInsets.only(left: 15, top: 33.5),
                  child: Text("常见问题",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              buildSearchContent(context, bloc),
            ]);
          },
        ));
  }

  Widget buildBanner(BuildContext context, List<BannerBean> data) {
    LogUtil.e(data.toString());
    if (ObjectUtil.isEmpty(data)) {
      return new Container(height: 0.0);
    }
    return new Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        height: 235,
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 16.0 / 14.0,
          child: Swiper(
            indicatorAlignment: AlignmentDirectional.topEnd,
            circular: true,
            interval: const Duration(seconds: 5),
//        indicator: NumberSwiperIndicator(),
            children: data.map((model) {
              return Container(
                child: new InkWell(
                    onTap: () {
                      LogUtil.e("BannerModel: " + model.toString());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 193,
                            width: double.infinity,
                            child: Stack(children: [
                              Container(
                                  height: 193,
                                  width: double.infinity,
                                  child: new CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: model.source_url,
                                    placeholder: (context, url) =>
                                        new ProgressView(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                  )),
                              Align(
                                  alignment: Alignment.center,
                                  child: new Image(
                                    image: AssetImage(
                                        "assets/images/icon_play.png"),
                                    width: 45.5,
                                    height: 45.5,
                                  ))
                            ])),
                        Padding(
                            padding: const EdgeInsets.only(top: 15.5),
                            child: Text(model.title,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ],
                    )),

//              ]
//                  )
              );
            }).toList(),
          ),
        ));
  }

  Widget buildSearchContent(BuildContext context, PlayIntroduceBloc bloc) {
    return new StreamBuilder(
        stream: bloc.searchStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<PlayIntroSearchBean>> snapshot) {
          var data = snapshot.data;
          return Container(
            padding: const EdgeInsets.only(top: 11.5, bottom: 11.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: buildSearchWidget(bloc),
                        ),
                        GestureDetector(
                          child: new Container(
                            decoration: BoxDecoration(
                                color: Color(0xffFF324D),
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.elliptical(0, 0),
                                    right: Radius.elliptical(2, 2))),
                            width: 57.5,
                            height: 36,
                            alignment: Alignment.center,
                            child: Text(
                              '搜索',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            bloc.getPlayIntroSearch(
                                "${controller.text}", searchType);
                          },
                        )
                      ],
                    )),
                bildSearbchTypeList(bloc),
                buildSearchContentList(data),
              ],
            ),
          );
        });
  }

  Widget bildSearbchTypeList(PlayIntroduceBloc bloc) {
    return new Container(
        height: 50,
        padding: const EdgeInsets.only(left: 15, right: 15),
        color: Color(0xff151921),
        child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Category bean = searchTypeList[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20, right: 15),
              child: _getItem(searchTypeList, bean, index, bloc),
            );
          },
          itemCount: searchTypeList.length,
        ));
  }

  Widget _getItem(
      List<Category> data, Category bean, int index, PlayIntroduceBloc bloc) {
    return new StreamBuilder(
        stream: bloc.IndexbehaviorSubject,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          var currentIndex = snapshot.data;
          return new GestureDetector(
              child: new Container(
                  decoration: BoxDecoration(
                    color: Color(0xff23252F),
                    borderRadius: BorderRadius.circular(5),
                    border: index == currentIndex
                        ? Border.all(width: 1, color: Color(0xffF3CF4B))
                        : Border.all(width: 1, color: Color(0xff23252F)),

                    ///圆角
                  ),
                  child: new Padding(
                      padding: new EdgeInsets.only(
                          left: 11.5, top: 5.5, right: 11.5, bottom: 5.5),
                      child: new Text(
                        bean.name,
                        style: TextStyle(
                            fontSize: 11.0,
                            color: index == currentIndex
                                ? Color(0xffF2CE4A)
                                : Color(0xff8B8B91)),
                      ))),
              onTap: () {
                searchType = index;
                bloc.IndexbehaviorSubject.add(index);
                bloc.getPlayIntroSearch("${controller.text}", data[index].id);
                print("${controller.text}");
              });
        });
  }

  Widget buildSearchWidget(PlayIntroduceBloc bloc) {
    return new StreamBuilder(
        stream: bloc.contentbehaviorSubject,
        initialData: "",
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return SearchTextFieldWidget(
            hintText: "输入你想搜索的关键字",
            onSubmitted: (searchContent) {
              pageSearchContent = searchContent;
              bloc.contentbehaviorSubject.add(searchContent);
              bloc.getPlayIntroSearch(pageSearchContent, searchType);
              print(searchType);
            },
            controller: controller,
          );
        });
  }

  Widget buildSearchContentList(List<PlayIntroSearchBean> data) {
    if (ObjectUtil.isEmpty(data)) {
      if (isFirstIn) {
        isFirstIn = false;
        return Container(
          height: 0,
        );
      } else {
        return Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 22.5, bottom: 25.5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image(
                    image: AssetImage("assets/images/search_not_icon.png"),
                    width: 125,
                    height: 125),
                Padding(
                  padding: const EdgeInsets.only(top: 5.5),
                  child: Text(
                    "搜不到问题，换个关键词试试",
                    style: TextStyle(fontSize: 14, color: Color(0xff8B8C91)),
                  ),
                )
              ]),
        );
      }
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          PlayIntroSearchBean bean = data[index];
          return Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: _getSearchItem(data, bean, index),
          );
        },
        itemCount: data.length);
  }

  Widget _getSearchItem(
      List<PlayIntroSearchBean> data, PlayIntroSearchBean bean, int index) {
    return ExpansionTile(
      title: Text(bean.questionNo.toString() + "、" + bean.questionTitle,
          style: TextStyle(fontSize: 15, color: Colors.white)),
      // 放开始的组件
      // 设置点开后的背景颜色
      backgroundColor: Color(0xff161922),
      // 设置展开显示的内容
      children: <Widget>[
        ListTile(
          title: Text(bean.questionAnswer,
              style: TextStyle(fontSize: 14, color: Color(0xff8B8C91))),
        )
      ],
      // 第一次显示打开的状态
      //initiallyExpanded: true,
    );
  }
}
