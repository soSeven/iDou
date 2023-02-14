import 'dart:collection';

import 'package:idou/bean/applet_detail_bean.dart';
import 'package:idou/bean/applet_detail_sub_bean.dart';
import 'package:idou/bean/applet_income_bean.dart';
import 'package:idou/bean/applet_team_income_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/data/repository/wan_repository.dart';

class AppletDetailBloc implements BlocBase {
  ///****** ****** ****** Home ****** ****** ****** /
//首页banner
  BehaviorSubject<AppletDetailBean> _appletDetailSubject =
      BehaviorSubject<AppletDetailBean>();

  String encodeid;

  Sink<AppletDetailBean> get appletDetailSink => _appletDetailSubject.sink;

  Stream<AppletDetailBean> get appletDetailStream =>
      _appletDetailSubject.stream;

  BehaviorSubject<List<Data>> _appletDetailSublistSubject =
      BehaviorSubject<List<Data>>();

  Sink<List<Data>> get appletDetailSublistSink =>
      _appletDetailSublistSubject.sink;

  Stream<List<Data>> get appletDetailSublistStream =>
      _appletDetailSublistSubject.stream;

  //是否收起CPM
  BehaviorSubject<bool> appCpmVisble = BehaviorSubject<bool>();

  //显示选择时间
  BehaviorSubject<DateTime> appletDatatime = BehaviorSubject<DateTime>();


  BehaviorSubject<AppletIncomeBean> appletIncomeSubject = BehaviorSubject<AppletIncomeBean>();

  Sink<AppletIncomeBean> get appletIncomeSublistSink =>
      appletIncomeSubject.sink;

  Stream<AppletIncomeBean> get appletIncomeSublistStream =>
      appletIncomeSubject.stream;


  BehaviorSubject<AppletTeamIncomeBean> appletTeamIncomeDSubject = BehaviorSubject<AppletTeamIncomeBean>();

  Sink<AppletTeamIncomeBean> get appletTeamIncomeDSubtSink =>
      appletTeamIncomeDSubject.sink;

  Stream<AppletTeamIncomeBean> get appletTeamIncomeDSubStream =>
      appletTeamIncomeDSubject.stream;


  BehaviorSubject<AppletTeamIncomeBean> appletTeamIncomeIndSubject = BehaviorSubject<AppletTeamIncomeBean>();

  Sink<AppletTeamIncomeBean> get appletTeamIncomeIndSubtSink =>
      appletTeamIncomeIndSubject.sink;

  Stream<AppletTeamIncomeBean> get appletTeamIncomeIndSubStream =>
      appletTeamIncomeIndSubject.stream;


  ///****** ****** ****** Home ****** ****** ****** /
  BehaviorSubject<QrCodeBean> _QrcodeSub =
  BehaviorSubject<QrCodeBean>();


  Sink<QrCodeBean> get _qrCodeSink => _QrcodeSub.sink;

  Stream<QrCodeBean> get qrCodeStream => _QrcodeSub.stream;


  BehaviorSubject<QrCodeBean> _SubQrcodeSub =
  BehaviorSubject<QrCodeBean>();


  Sink<QrCodeBean> get _subQrCodeSink => _SubQrcodeSub.sink;

  Stream<QrCodeBean> get subCodeStream => _SubQrcodeSub.stream;
  WanRepository wanRepository = new WanRepository();
  HttpUtils httpUtils = new HttpUtils();

  AppletDetailBloc() {
    LogUtil.e("MainBloc......");
  }

  Future getQrCode(String encode_id) {
    return wanRepository.getQrCode(encode_id).then((QrCodeBean qrCodeBean) {
      _qrCodeSink.add(qrCodeBean);
    });
  }

  Future getSubQrCode(String encode_id) {
    return wanRepository.getSubQrCode(encode_id).then((QrCodeBean qrCodeBean) {
      _subQrCodeSink.add(qrCodeBean);
    });
  }

  Future getAppletData(String encodeid) {
    this.encodeid = encodeid;
    return wanRepository
        .getAppletDateal(encodeid)
        .then((AppletDetailBean data) {
      if (data.subCount > 0) {
        getAppletSublist(encodeid);
      }
      appletDetailSink.add(data);
    });
  }

  Future getAppletIncome(String encodeid,DateTime dataTime) {
    this.encodeid = encodeid;
    return wanRepository.getAppletIncome(encodeid,dataTime).then((AppletIncomeBean data) {
      appletIncomeSublistSink.add(data);
    });
  }

  Future getAppletTeamIncome(String encodeid,String type) {
    print("getAppletTeamIncome-----------------------");
    this.encodeid = encodeid;
    return wanRepository.getAppletTeamIncome(encodeid,type).then((AppletTeamIncomeBean data){
      if(type=="direct")
        appletTeamIncomeDSubtSink.add(data);
      else
        appletTeamIncomeIndSubtSink.add(data);
    });
  }




  Future getAppletSublist(String encodeid) {
    this.encodeid = encodeid;
    return wanRepository.getAppletDetailSublist(encodeid).then((list) {
      appletDetailSublistSink.add(UnmodifiableListView<Data>(list));
    });
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = 0;
    ++_page;
    return getData(page: _page);
  }

  @override
  Future onRefresh() {
    return getAppletData(encodeid);
  }

  Future getBanner() {
    LogUtil.e("getBanner");
  }

  void test() {
    LogUtil.e("MainBloc test 1.....");
  }

  @override
  void dispose() {
    _appletDetailSubject.close();
    _appletDetailSublistSubject.close();
    appCpmVisble.close();
    appletDatatime.close();
    appletIncomeSubject.close();
    appletTeamIncomeDSubject.close();
    appletTeamIncomeIndSubject.close();
  }

  @override
  Future getData({int page}) {
    // TODO: implement getData
    throw UnimplementedError();
  }
}
