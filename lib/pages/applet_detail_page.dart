import 'package:base_library/base_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idou/bean/app_applet_bean.dart';
import 'package:idou/bean/applet_detail_bean.dart';
import 'package:idou/bean/applet_detail_sub_bean.dart';
import 'package:idou/bean/applet_income_bean.dart';
import 'package:idou/bean/applet_team_income_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/blocs/applet_detail_bloc.dart';
import 'package:idou/blocs/bloc_provider.dart';
import 'package:idou/res/styles.dart';
import 'package:idou/utils/utils.dart';
import 'package:idou/widgets/base_dialog.dart';
import 'package:idou/widgets/datapicker/date_format.dart';
import 'package:idou/widgets/datapicker/datetime_picker_theme.dart';
import 'package:idou/widgets/datapicker/flutter_datetime_picker.dart';
import 'package:idou/widgets/datapicker/i18n_model.dart';
import 'package:idou/widgets/ext_tab_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppletDetailClass extends StatelessWidget {
  const AppletDetailClass({Key key, this.encode_id}) : super(key: key);

  final String encode_id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: AppletDetailStateless(encode_id), bloc: AppletDetailBloc());
  }
}

class AppletDetailStateless extends StatelessWidget {
  String encode_id;

  List<Data> subBean;

  final List<String> tabTxt = ['直推团队收益', '间推团队收益'];

  AppletDetailStateless(String encode_id) {
    this.encode_id = encode_id;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    LogUtil.e("AppletDetailPage build......");
    RefreshController _controller = new RefreshController();
    final AppletDetailBloc appletDetailBloc =
        BlocProvider.of<AppletDetailBloc>(context);
//    if (isHomeInit) {
    LogUtil.e("AppletDetailClass init......");
    Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_) {
      print("AppletDetailStateless" + encode_id);
      appletDetailBloc.getAppletData(encode_id);
      appletDetailBloc.getAppletIncome(encode_id, DateTime.now());
      appletDetailBloc.getAppletTeamIncome(encode_id, "direct");
      appletDetailBloc.getAppletTeamIncome(encode_id, "indirect");
    });

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "详情",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: new Container(
        color: Color(0xff151921),
        child: new StreamBuilder(
            stream: appletDetailBloc.appletDetailStream,
            builder: (BuildContext context,
                AsyncSnapshot<AppletDetailBean> snapshot) {
              var appDetailBean = snapshot.data;
              print(appDetailBean);
              if (ObjectUtil.isEmpty(appDetailBean))
                return new Container(height: 0.0);
              return new SmartRefresher(
                  controller: _controller,
                  enablePullUp: false,
                  onRefresh: ({bool isReload}) {
                    return appletDetailBloc.onRefresh();
                  },
                  child: new ListView(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  new CachedNetworkImage(
                                    width: 57.5,
                                    height: 57.5,
                                    fit: BoxFit.fill,
                                    imageUrl: appDetailBean.thumb,
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                  ),
                                  new Expanded(
                                      child: new Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          appDetailBean.title,
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        Text(
                                            "已有" +
                                                appDetailBean.spreadNum
                                                    .toString() +
                                                "人推广",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color(0xff696971))),
                                      ],
                                    ),
                                  )),
                                  InkWell(
                                    onTap: () {
                                      appletDetailBloc.getQrCode(encode_id);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return BaseDialog(
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 13,
                                                                top: 13,
                                                                bottom: 2),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            InkWell(
                                                              child: Image(
                                                                  image: AssetImage(
                                                                      "assets/images/close_icon.png"),
                                                                  width: 15,
                                                                  height: 15),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            )
                                                          ],
                                                        )),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 25),
                                                        child: Text("下载二维码",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Color(
                                                                    0xff1A1A1A),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                    Container(
                                                      height: 210,
                                                      width: 210,
                                                      decoration: (BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          border: Border.all(
                                                              width: 2.5,
                                                              color: Color(
                                                                  0xffE8E8E9)))),
                                                      child: BuildQrCode(
                                                          context,
                                                          appletDetailBloc,
                                                          1),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 15),
                                                        child: Text(
                                                            "长按二维码保存到相册",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xffFF324D))))
                                                  ],
                                                ),
                                                338,
                                                300);
                                          });
                                    },
                                    child: new Container(
                                        width: 106,
                                        height: 31,
                                        decoration: BoxDecoration(
                                          color: Color(0xffFF324D),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            new Image(
                                                width: 13.5,
                                                height: 12.5,
                                                image: AssetImage(
                                                    "assets/images/white_load.png")),
                                            Text("下载推广码",
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white)),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 33, bottom: 19.5),
                                  child: Text(
                                    appDetailBean.description,
                                    style: TextStyle(
                                        fontSize: 13, color: Color(0xff696971)),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 19.5),
                                  child: Text(
                                      "精选" +
                                          appDetailBean.subCount.toString() +
                                          "款子产品",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                              new StreamBuilder(
                                  stream: appletDetailBloc
                                      .appletDetailSublistStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<Data>> snapshot) {
                                    if (ObjectUtil.isEmpty(snapshot.data))
                                      return new Container(height: 0);
                                    return ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          subBean = snapshot.data;
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12),
                                              child: _getAppletDetailSubItem(
                                                  subBean,
                                                  index,
                                                  context,
                                                  appletDetailBloc));
                                        },
                                        itemCount: snapshot.data.length);
                                  }),
                              buildMoreApplet(context, snapshot.data),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 19.5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("推广思路",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(child: Text("")),
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  "assets/images/light_bulb.png"),
                                              width: 9,
                                              height: 12),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text("推广思路",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Color(0xffFF324D))))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              buildIntroExample(context, snapshot.data),
                              new StreamBuilder(
                                  stream: appletDetailBloc.appCpmVisble,
                                  initialData: true,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    bool visble = snapshot.data;
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0xff23252F),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12,
                                                  right: 12,
                                                  top: 14.5,
                                                  bottom: 22.5),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                            "抖音小程序推广分佣比例",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .white))),
                                                    InkWell(
                                                      onTap: () {
                                                        visble = !visble;
                                                        appletDetailBloc
                                                            .appCpmVisble
                                                            .add(visble);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              visble
                                                                  ? "收起"
                                                                  : "展开",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color(
                                                                      0xffFF324D))),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              child: Image(
                                                                image: visble
                                                                    ? AssetImage(
                                                                        "assets/images/delta_red.png")
                                                                    : AssetImage(
                                                                        "assets/images/delta_down.png"),
                                                                width: 10,
                                                                height: 5.5,
                                                              ))
                                                        ],
                                                      ),
                                                    )
                                                  ])),
                                          buildCpmDetail(
                                              context, appDetailBean, visble)
                                        ],
                                      ),
                                    );
                                  }),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35, bottom: 12),
                                  child: Text("个人收益",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))),
                              new StreamBuilder(
                                  stream: appletDetailBloc.appletDatatime,
                                  initialData: DateTime.now(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DateTime> snapshot) {
                                    var date = snapshot.data;
                                    return Column(
                                      children: [
                                        InkWell(
                                          //让组件可以点击
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text('${formatDate(date, [
                                                    yyyy,
                                                    '-',
                                                    mm,
                                                    '-',
                                                    dd,
                                                    ' '
                                                  ], LocaleType.zh)}'),
                                              //使用第三方库按照指定形式显示数据
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                          onTap: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime.now(),
                                                maxTime: DateTime(2100, 6, 7),
                                                theme: DatePickerTheme(
                                                    headerColor: Colors.white,
                                                    backgroundColor:
                                                        Colors.white,
                                                    itemStyle: TextStyle(
                                                        color:
                                                            Color(0xff111111),
                                                        fontSize: 17),
                                                    doneStyle: TextStyle(
                                                        color:
                                                            Color(0xff3A76FF),
                                                        fontSize: 15),
                                                    cancelStyle: TextStyle(
                                                        color:
                                                            Color(0xff666666),
                                                        fontSize: 15)),
                                                onChanged: (date) {
                                              print(
                                                  'change $date in time zone ' +
                                                      date.timeZoneOffset
                                                          .inHours
                                                          .toString());
                                            }, onConfirm: (date) {
                                              appletDetailBloc.appletDatatime
                                                  .add(date);
                                              appletDetailBloc.getAppletIncome(
                                                  encode_id, date);
                                              print('confirm $date');
                                            },
                                                currentTime: DateTime.now(),
                                                locale: LocaleType.zh);
                                          },
                                        ),
                                        new StreamBuilder(
                                            stream: appletDetailBloc
                                                .appletIncomeSublistStream,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<AppletIncomeBean>
                                                    snapshot) {
                                              var appletIncomeData =
                                                  snapshot.data;
                                              return Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12,
                                                              bottom: 19.5),
                                                      child: Text(
                                                          date.month
                                                                  .toString() +
                                                              "月份数据统计中，目前收益" +
                                                              appletIncomeData
                                                                  .monthRealIncome +
                                                              "元，预计" +
                                                              (date.month + 1)
                                                                  .toString() +
                                                              "月31日发放",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Color(
                                                                  0xff8B8C91)))),
                                                  Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff23252F),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12,
                                                                    right: 12,
                                                                    top: 15,
                                                                    bottom: 21),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "今日CPM收益",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Colors.white)),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 6),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return BaseDialog(
                                                                                      Container(
                                                                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Padding(
                                                                                                  padding: const EdgeInsets.only(right: 0, bottom: 2),
                                                                                                  child: Row(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    children: [
                                                                                                      InkWell(
                                                                                                        child: Image(image: AssetImage("assets/images/close_icon.png"), width: 15, height: 15),
                                                                                                        onTap: () {
                                                                                                          Navigator.pop(context);
                                                                                                        },
                                                                                                      )
                                                                                                    ],
                                                                                                  )),
                                                                                              Text("CPM说明", style: TextStyle(fontSize: 16, color: Color(0xff1A1A1A), fontWeight: FontWeight.bold)),
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Padding(padding: const EdgeInsets.only(top: 17.5), child: Text("什么是CPM?", style: TextStyle(fontSize: 15, color: Color(0xff1A1A1A)))),
                                                                                                  Padding(padding: const EdgeInsets.only(top: 10.5), child: Text("本模式适用于开放了激励广告的小程序。每次用户完整观看广告都会为您带来收益，CPM即 Cost per mille“千次广告展示?", style: TextStyle(fontSize: 14, color: Color(0xff666666)))),
                                                                                                  Padding(padding: const EdgeInsets.only(top: 17.5), child: Text("CPM的结算周期?", style: TextStyle(fontSize: 15, color: Color(0xff1A1A1A)))),
                                                                                                  Padding(padding: const EdgeInsets.only(top: 10.5, bottom: 21), child: Text("由于抖音官方规则限制,当前月份的广告收益会在次月进行结算。结算后,抖音会在45个工作日内发放。举例来说,您在6月份的广告收入会", style: TextStyle(fontSize: 14, color: Color(0xff666666)))),
                                                                                                ],
                                                                                              )
                                                                                            ],
                                                                                          )),
                                                                                      338,
                                                                                      300);
                                                                                });
                                                                          },
                                                                          child:
                                                                              Image(
                                                                            image:
                                                                                AssetImage("assets/images/help_icon.png"),
                                                                            width:
                                                                                14,
                                                                            height:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return BaseDialog(
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Padding(padding: const EdgeInsets.only(top:29,bottom: 15), child: Text("各抖音号今日完播量", style: TextStyle(fontSize: 16, color: Color(0xff1A1A1A), fontWeight: FontWeight.bold))),
                                                                                     buildFinishPlayingList(appletIncomeData),
//
                                                                                    Container(
                                                                                        alignment: Alignment.center,
                                                                                        height: 44,
                                                                                        margin: const EdgeInsets.only(left: 39,right: 39,top: 32),
                                                                                        decoration: (BoxDecoration(
                                                                                          color: Color(0xffFF324D),
                                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                                        )),
                                                                                        child: InkWell(
                                                                                            onTap: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: Text("朕知道了", style: TextStyle(fontSize: 15, color: Colors.white))))
                                                                                  ],
                                                                                ),
                                                                                338,
                                                                                300);
                                                                          });
                                                                    },
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 5),
                                                                            child: Image(image: AssetImage("assets/images/desic_icon.png"), width: 11.5, height: 11.5)),
                                                                        Text(
                                                                            "完播量明细",
                                                                            style:
                                                                                TextStyle(fontSize: 13, color: Color(0xffFF324D))),
                                                                      ],
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 19,
                                                                    left: 12,
                                                                    right: 12),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        appletIncomeData
                                                                            .predictIncome,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold)),
                                                                    Text(
                                                                        "本月预估收益",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Color(0xff8B8C91)))
                                                                  ],
                                                                ),
                                                                Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                          appletIncomeData
                                                                              .monthRealIncome,
                                                                          style: TextStyle(
                                                                              fontSize: 19,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold)),
                                                                      Text(
                                                                          "本月累积收益",
                                                                          style: TextStyle(
                                                                              fontSize: 13,
                                                                              color: Color(0xff8B8C91)))
                                                                    ])
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            height: 1,
                                                            color: Color(
                                                                0xff383A43),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 19,
                                                                    bottom: 20,
                                                                    left: 12,
                                                                    right: 12),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        appletIncomeData
                                                                            .visitNum
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold)),
                                                                    Text(
                                                                        "今日访问量",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Color(0xff8B8C91)))
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        appletIncomeData
                                                                            .finishPlayingNum
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold)),
                                                                    Text(
                                                                        "广告完播量",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Color(0xff8B8C91)))
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        appletIncomeData
                                                                            .ecpm
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold)),
                                                                    Text(
                                                                        "预估eCPM",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Color(0xff8B8C91)))
                                                                  ],
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        appletIncomeData
                                                                            .yesterdayEcpm,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold)),
                                                                    Text(
                                                                        "昨日rCPM",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Color(0xff8B8C91)))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              );
                                            }),
                                      ],
                                    );
                                  }),
                              buildTeamIncome(context, appletDetailBloc),
                            ]),
                      )
                    ],
                  ));
            }),
      ),
    );
  }

  Widget _getAppletDetailSubItem(List<Data> subBean, int index,
      BuildContext context, AppletDetailBloc appletDetailBloc) {
    if (ObjectUtil.isEmpty(subBean)) {
      return new Container(height: 0.0);
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        new CachedNetworkImage(
          width: 43,
          height: 43,
          fit: BoxFit.fill,
          imageUrl: subBean[index].thumb,
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
        new Expanded(
            child: new Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subBean[index].title,
                style: TextStyle(fontSize: 15.0, color: Color(0xffE7E7E9)),
              ),
              Text(subBean[index].shareTitle,
                  style: TextStyle(fontSize: 12.0, color: Color(0xff8B8B91))),
            ],
          ),
        )),
        InkWell(
          onTap: () {
            appletDetailBloc.getSubQrCode(subBean[index].encodeId);
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
                            child: BuildQrCode(context, appletDetailBloc, 2),
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
          child: Text("预览",
              style: TextStyle(fontSize: 14.0, color: Color(0xffFF324D))),
        ),
      ],
    );
  }

  Widget buildMoreApplet(BuildContext context, AppletDetailBean data) {
    if (data.subCount == 0) {
      return new Container(height: 0);
    }
    return new Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 25.5),
        child: InkWell(
          onTap: () {},
          child: Text(
            "更多单品",
            style: TextStyle(fontSize: 13, color: Color(0xffF3CF4A)),
          ),
        ));
  }

  Widget BuildQrCode(BuildContext context, AppletDetailBloc bloc, int type) {
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
                },
                child: new CachedNetworkImage(
                  width: 43,
                  height: 43,
                  fit: BoxFit.fill,
                  imageUrl: data.url,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ));
        });
  }

  Widget buildIntroExample(BuildContext context, AppletDetailBean data) {
    if (data.example.length == 0) return Container(height: 0);
    List<Example> example = data.example;
    return new Container(
        height: 180,
        child: new ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Example bean = example[index];
            return Padding(
              padding: const EdgeInsets.only(left: 0),
              child: _getItem(data, bean, index),
            );
          },
          itemCount: example.length,
        ));
  }

  Widget _getItem(AppletDetailBean data, Example bean, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.5, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            width: 75,
            height: 100,
            fit: BoxFit.fill,
            imageUrl: bean.thumb,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: new Container(
                width: 60.5,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1, color: Color(0xffF4CF4B)),

                  ///圆角
                ),
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: bean.description));
                    Fluttertoast.showToast(msg: "复制成功");
                  },
                  child: Text("复制链接",
                      style: TextStyle(fontSize: 11, color: Color(0xffF3CF4B))),
                )),
          )
        ],
      ),
    );
  }

  Widget buildCpmDetail(
      BuildContext context, AppletDetailBean appDetailBean, bool visble) {
    if (!visble) {
      return new Container(height: 0);
    }
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("广告分成",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("预估eCPM\n95%分成",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff696971)))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Text("|",
                      style: TextStyle(fontSize: 30, color: Color(0xff696971))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(appDetailBean.stair1.toString() + "%",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("自己拍抖音\n赚佣金比例",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff696971)))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Text("|",
                      style: TextStyle(fontSize: 30, color: Color(0xff696971))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(appDetailBean.stair2.toString() + "%",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("直推团队拍\n抖音佣金比例",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff696971)))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Text("|",
                      style: TextStyle(fontSize: 30, color: Color(0xff696971))),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(appDetailBean.stair3.toString() + "%",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    Text("间推团队拍\n抖音佣金比例",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff696971)))
                  ],
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Text("结算周期:次月发放收益",
                    style: TextStyle(fontSize: 13, color: Color(0xffF3CF4A)))),
          ],
        ));
  }

  Widget buildTeamIncome(
      BuildContext context, AppletDetailBloc appletDetailBloc) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 26.5),
        child: Container(
            decoration: BoxDecoration(
                color: Color(0xff23252F),
                borderRadius: BorderRadius.circular(5)),
            height: 116,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  Container(
                      height: 38,
                      width: double.infinity,
                      child: TabBar(
                        indicator: ExtUnderlineTabIndicator(
                            borderSide: BorderSide(
                                width: 2.0, color: Color(0xffF43E5A))),
                        tabs: tabTxt.map((e) => Tab(text: e)).toList(),
                      )),
                  Divider(height: 0.5, color: Color(0xff383A43)),
                  Expanded(
//                  height: 78,
                      child: TabBarView(
                    children: [
                      StreamBuilder(
                          stream: appletDetailBloc.appletTeamIncomeDSubStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<AppletTeamIncomeBean> snapshot) {
                            var model = snapshot.data;
                            if (model == null) {
                              return new Container(
                                height: 0.0,
                              );
                            }

                            return _buildTeamIncome(context, snapshot.data);
                          }),
                      StreamBuilder(
                          stream: appletDetailBloc.appletTeamIncomeIndSubStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<AppletTeamIncomeBean> snapshot) {
                            var model = snapshot.data;
                            if (model == null) {
                              return new Container(
                                height: 0.0,
                              );
                            }

                            return _buildTeamIncome(context, snapshot.data);
                          }),
                    ],
                  ))
                ],
              ),
            )));
  }

  Widget _buildTeamIncome(BuildContext context, AppletTeamIncomeBean data) {
    return Container(
      padding: const EdgeInsets.only(top: 19, bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data.income,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("本小程序总收益",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff696971)))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data.yesterdayIncome,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("昨日收益",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff696971)))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data.todayFinishPlayingNum.toString(),
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("今日完播量",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff696971)))
            ],
          )
        ],
      ),
    );
  }

  Widget _getFinishItem(AppletIncomeBean appletIncomeData,
      List<FinishPlayingList> bean, int index) {
    if (ObjectUtil.isEmpty(bean)) {
      return Container(height: 0);
    }
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(bean[index].avatar),
                    fit: BoxFit.cover,
                  ))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              bean[index].nickname,
              style: TextStyle(fontSize: 14, color: Color(0xff1a1a1a)),
            ),
          )),
          Text(bean[index].finishPlayingNum.toString() + "次",
              style: TextStyle(fontSize: 15, color: Color(0xffFF324D)))
        ],
      ),
    );
  }

  Widget buildFinishPlayingList(AppletIncomeBean appletIncomeData) {
    if(ObjectUtil.isEmpty(appletIncomeData.finishPlayingList)){
      return Container(height: 0);
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        List<FinishPlayingList> bean = appletIncomeData.finishPlayingList;
        return _getFinishItem(appletIncomeData, bean, index);
        },
    );
  }
}
