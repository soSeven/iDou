import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idou/bean/app_applet_bean.dart';
import 'package:idou/bean/bannerbean.dart';
import 'package:idou/bean/home_applet_classfy_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/bean/system_msg_bean.dart';
import 'package:idou/blocs/main_bloc.dart';
import 'package:idou/blocs/qrcode_bloc.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/pages/douyin_account_page.dart';
import 'package:idou/pages/play_introduce_page.dart';
import 'package:idou/utils/navigator_util.dart';
import 'package:idou/widgets/base_dialog.dart';
import 'package:idou/widgets/fullternarquee/FlutterMarqueeIndex.dart';
import 'package:idou/widgets/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'applet_detail_page.dart';

bool isHomeInit = true;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.e("HomePage build......");
    RefreshController _controller = new RefreshController();
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);

    if (isHomeInit) {
      LogUtil.e("HomePage init......");
      isHomeInit = false;
      Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
        bloc.onRefresh();
      });
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff151921),
            centerTitle: true,
            title: Text("爱抖家族",
                style: TextStyle(fontSize: 18, color: Colors.white))),
        body: new Container(
          color: Color(0xff151921),
          child: new StreamBuilder(
              stream: bloc.appletListStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<AppletBean>> snapshot) {
                return new SmartRefresher(
                  controller: _controller,
                  enablePullUp: false,
                  onRefresh: ({bool isReload}) {
                    return bloc.onRefresh();
                  },
                  child: new ListView(
                    children: <Widget>[
                      new StreamBuilder(
                          stream: bloc.bannerStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<BannerBean>> snapshot) {
                            return buildBanner(context, snapshot.data);
                          }),
                      new StreamBuilder(
                          stream: bloc.sysMsgStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<SystemMsgBean>> snapshot) {
                            return buildSysMsg(context, snapshot.data);
                          }),
                      bulidAppIntro(context),
                      new StreamBuilder(
                          stream: bloc.appletListStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<AppletBean>> snapshot) {
                            return bulidAppNumTitle(context, snapshot.data);
                          }),
                      new StreamBuilder(
                          stream: bloc.appletStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<AppletClassfyBean>> snapshot) {
                            return buildHomeClass(context, snapshot.data, bloc);
                          }),
                      new StreamBuilder(
                          stream: bloc.appletListStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<AppletBean>> snapshot) {
                            return buildAppletList(
                                context, snapshot.data, bloc);
                          })
                    ],
                  ),
                );
              }),
        ));
  }

  Widget buildBanner(BuildContext context, List<BannerBean> list) {
    LogUtil.e(list.toString());
    if (ObjectUtil.isEmpty(list)) {
      return new Container(height: 0.0);
    }
    return new Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: new AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: Swiper(
            indicatorAlignment: AlignmentDirectional.topEnd,
            circular: true,
            interval: const Duration(seconds: 5),
            indicator: NumberSwiperIndicator(),
            children: list.map((model) {
              return new InkWell(
                onTap: () {
                  LogUtil.e("BannerModel: " + model.toString());
                  NavigatorUtil.pushWeb(context,
                      title: model.title, url: model.url);
                },
                child: new CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: model.source_url,
                  placeholder: (context, url) => new ProgressView(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              );
            }).toList(),
          ),
        ));
  }

  Widget buildSysMsg(BuildContext context, List<SystemMsgBean> data) {
    if (ObjectUtil.isEmpty(data)) {
      return new Container(height: 0.0);
    }
    List<SystemMsgBean> msg = new List();
    for (int i = 0; i < data.length; i++) {
      msg.add(data[i]);
    }
    for (int i = 0; i < data.length; i++) {
      msg.add(data[i]);
    }
    List<String> text = new List();
    for (int i = 0; i < msg.length; i++) {
      text.add(msg[i].title);
    }
    LogUtil.e("buildSysMsg");
    return Container(
        color: Color(0xff151921),
        child: new Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: new Text(
              "公告",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9.0, right: 9.0),
            child: new Text(
              "|",
              style: TextStyle(fontSize: 16.0, color: Color(0xff373943)),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: 40,
                child: FlutterMarquee(
                    texts: text,
                    textColor: Color(0xffffffff),
                    seletedTextColor: Color(0xffffffff),
                    onChange: (i) {
                      NavigatorUtil.pushWeb(context,
                          title: msg[i].title,
                          url: Constant.server_address + msg[i].h5_url);
                    },
                    duration: msg.length),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.chevron_right,
              color: const Color.fromARGB(255, 204, 204, 204),
            ),
          )
        ]));
  }

  Widget bulidAppIntro(BuildContext context) {
    return Container(
      color: Color(0xff151921),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: new InkWell(
                      onTap: () {
                        NavigatorUtil.pushPage(context, PlayIntroducePage(),
                            pageName: "玩法介绍");
                      },
                      child: new Image(
                        image: AssetImage("assets/images/playprofile_icon.png"),
                      )))),
          Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: new InkWell(
                      onTap: () {
                        NavigatorUtil.pushPage(context, DouyinAccountPage(),
                            pageName: "我的抖音号");
                      },
                      child: new Image(
                        image: AssetImage("assets/images/douyin_icon.png"),
                      )))),
          Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: new InkWell(
                      onTap: () {},
                      child: new Image(
                        image: AssetImage("assets/images/school_icon.png"),
                      ))))
        ],
      ),
    );
  }

  Widget bulidAppNumTitle(BuildContext context, List<AppletBean> data) {
    if (ObjectUtil.isEmpty(data)) {
      return new Container(height: 0.0);
    }
    return Container(
        color: Color(0xff151921),
        child: new Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 24.5),
            child: new Text(
              "产品列表",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9.0, right: 9.0, top: 24.5),
            child: new Text(
              "|",
              style: TextStyle(fontSize: 14.0, color: Color(0xff373943)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.5),
            child: RichText(
                text: TextSpan(
                    text: "共",
                    style: TextStyle(fontSize: 12, color: Color(0xff696971)),
                    children: <TextSpan>[
                  TextSpan(
                      text: data.length.toString(),
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xffF3CF49))),
                  TextSpan(
                      text: '款小程序',
                      style:
                          TextStyle(fontSize: 12.0, color: Color(0xff696971)))
                ])),
          ),
        ]));
  }

  Widget buildHomeClass(
      BuildContext context, List<AppletClassfyBean> data, MainBloc bloc) {
    if (ObjectUtil.isEmpty(data)) {
      return new Container(height: 0.0);
    }
    return new Container(
        height: 50,
        color: Color(0xff151921),
        child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            AppletClassfyBean bean = data[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: _getItem(data, bean, index, bloc),
            );
          },
          itemCount: data.length,
        ));
  }

  Widget _getItem(List<AppletClassfyBean> data, AppletClassfyBean bean,
      int index, MainBloc bloc) {
    return new StreamBuilder(
        stream: bloc.appClassfyIndex,
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
                bloc.appClassfyIndex.add(index);
                bloc.getHomeAppletData(data[index].encode_id);
                print(data[index].encode_id);
              });
        });
  }

  Widget buildAppletList(
      BuildContext context, List<AppletBean> data, MainBloc bloc) {
    if (ObjectUtil.isEmpty(data)) {
      return new Container(height: 0.0);
    }
    return Container(
        color: Color(0xff151921),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            AppletBean bean = data[index];
            return Padding(
                padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
                child: _getAppletItem(context, data, bean, index, bloc));
          },
          itemCount: data.length,
        ));
  }

  Widget _getAppletItem(BuildContext context, List<AppletBean> data,
      AppletBean bean, int index, MainBloc bloc) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff23252F),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: new Image(
                image: bean.isVip == 1
                    ? AssetImage("assets/images/vip_study_special_icon.png")
                    : AssetImage("assets/images/free_icon.png"),
                width: 31,
                height: 32.5,
              )),
          Container(
            padding: EdgeInsets.only(left: 12, top: 15, right: 12, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    new CachedNetworkImage(
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                      imageUrl: bean.thumb,
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    new Expanded(
                        child: new Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bean.title,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          Text(bean.category.name,
                              style: TextStyle(
                                  fontSize: 12.0, color: Color(0xff696971))),
                        ],
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new CupertinoPageRoute<void>(
                              builder: (ctx) => new AppletDetailClass(
                                  encode_id: bean.encodeId),
                            ));
                      },
                      child: new Container(
                        width: 85,
                        height: 31,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffFF324D),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text("查看详情",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  child: Text(
                    bean.description,
                    style: TextStyle(fontSize: 13, color: Color(0xff696971)),
                  ),
                ),
                Divider(height: 1.0, color: Color(0xff383A43)),
                new Padding(
                  padding: EdgeInsets.only(top: 18.5, bottom: 18.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    //交叉轴的布局方式，对于column来说就是水平方向的布局方式
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //就是字child的垂直布局方向，向上还是向下
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "昨日最高收益",
                            style: TextStyle(
                                fontSize: 11.0, color: Color(0xffC6C6C9)),
                          ),
                          Text(bean.yesterdayIncome.toString(),
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.white)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "总分佣比例",
                            style: TextStyle(
                                fontSize: 11.0, color: Color(0xffC6C6C9)),
                          ),
                          Text(bean.spreadNum.toString(),
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.white)),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          bloc.getQrCode(bean.encodeId);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return BaseDialog(
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 13, top: 13, bottom: 2),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  child: Image(
                                                      image: AssetImage(
                                                          "assets/images/close_icon.png"),
                                                      width: 15,
                                                      height: 15),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 25),
                                            child: Text("下载二维码",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff1A1A1A),
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Container(
                                          height: 210,
                                          width: 210,
                                          decoration: (BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  width: 2.5,
                                                  color: Color(0xffE8E8E9)))),
                                          child: BuildQrCode(context, bloc, 1),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Text("长按二维码保存到相册",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xffFF324D))))
                                      ],
                                    ),
                                    338,
                                    300);
                              });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new Image(
                              width: 13.5,
                              height: 12.5,
                              image: AssetImage("assets/images/load_icon.png"),
                            ),
                            Text("下载推广码",
                                style: TextStyle(
                                    fontSize: 14.0, color: Color(0xffFF324D))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(height: 1.0, color: Color(0xff383A43)),
                BuildAppletSubNum(data, index),
                BuildAppletSubList(context, data, index, bloc),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget BuildAppletSubNum(List<AppletBean> data, int index) {
    if (ObjectUtil.isEmpty(data[index].sub)) {
      return new Container(height: 0.0);
    }
    return new Padding(
      padding: EdgeInsets.only(top: 19.5, bottom: 15),
      child: RichText(
          text: TextSpan(
              text: "精选子产品",
              style: TextStyle(fontSize: 14, color: Color(0xffE7E7E9)),
              children: <TextSpan>[
            TextSpan(
                text: data[index].sub.length.toString(),
                style: TextStyle(fontSize: 14.0, color: Color(0xffF3CF49))),
            TextSpan(
                text: '款',
                style: TextStyle(fontSize: 14.0, color: Color(0xffE7E7E9)))
          ])),
    );
  }
}

Widget BuildQrCode(BuildContext context, MainBloc bloc, int type) {
  return new StreamBuilder(
      stream: type == 1 ? bloc.qrCodeStream : bloc.subCodeStream,
      builder: (BuildContext context, AsyncSnapshot<QrCodeBean> snapshot) {
        var data = snapshot.data;
        if (ObjectUtil.isEmpty(data)) {
          return Container(height: 0);
        }
        return Container(
          padding: const EdgeInsets.all(11),
          child: GestureDetector(
              onLongPress: () async {
                Utils.saveImage(data.url);
//                print(result);
//                if(result){
//                }else{
//                  Fluttertoast.showToast(msg: "保存失败");
//                }
              },
              child: new CachedNetworkImage(
                width: 43,
                height: 43,
                fit: BoxFit.fill,
                imageUrl: data.url,
                errorWidget: (context, url, error) => new Icon(Icons.error),
              )),
        );
      });
}



Widget BuildAppletSubList(
    BuildContext context, List<AppletBean> data, int index, MainBloc bloc) {
  if (ObjectUtil.isEmpty(data[index].sub)) {
    return new Container(height: 0.0);
  }
  List<Sub> bean = data[index].sub;
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      Sub subBean = bean[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _getAppletSubItem(context, bean, subBean, index, bloc),
      );
    },
    itemCount: bean.length,
  );
}

Widget _getAppletSubItem(BuildContext context, List<Sub> data, Sub subBean,
    int index, MainBloc bloc) {
  if (ObjectUtil.isEmpty(data)) {
    return new Container(height: 0.0);
  }
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      new CachedNetworkImage(
        width: 43,
        height: 43,
        fit: BoxFit.fill,
        imageUrl: subBean.thumb,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
      new Expanded(
          child: new Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subBean.title,
              style: TextStyle(fontSize: 15.0, color: Color(0xffE7E7E9)),
            ),
            Text(subBean.shareTitle,
                style: TextStyle(fontSize: 12.0, color: Color(0xff8B8B91))),
          ],
        ),
      )),
      InkWell(
        onTap: () {
          bloc.getSubQrCode(subBean.encodeId);
          showDialog(
              context: context,
              builder: (context) {
                return BaseDialog(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 13, top: 13, bottom: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/close_icon.png"),
                                      width: 15,
                                      height: 15),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Text("下载二维码",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff1A1A1A),
                                    fontWeight: FontWeight.bold))),
                        Container(
                          height: 210,
                          width: 210,
                          decoration: (BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  width: 2.5, color: Color(0xffE8E8E9)))),
                          child: BuildQrCode(context, bloc, 2),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text("长按二维码保存到相册",
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xffFF324D))))
                      ],
                    ),
                    338,
                    300);
              });
        },
        child: Text("推广",
            style: TextStyle(fontSize: 14.0, color: Color(0xffFF324D))),
      ),
    ],
  );
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}
