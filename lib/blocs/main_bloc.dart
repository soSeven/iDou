import 'dart:collection';

import 'package:idou/bean/app_applet_bean.dart';
import 'package:idou/bean/bannerbean.dart';
import 'package:idou/bean/home_applet_classfy_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/bean/system_msg_bean.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/data/repository/wan_repository.dart';

class MainBloc implements BlocBase {
  ///****** ****** ****** Home ****** ****** ****** /
//首页banner
  BehaviorSubject<List<BannerBean>> _banner =
      BehaviorSubject<List<BannerBean>>();

  String id = "";

  Sink<List<BannerBean>> get _bannerSink => _banner.sink;

  Stream<List<BannerBean>> get bannerStream => _banner.stream;

  //系统消息列表
  BehaviorSubject<List<SystemMsgBean>> _msgRepos =
      BehaviorSubject<List<SystemMsgBean>>();

  Sink<List<SystemMsgBean>> get _msgReposSink => _msgRepos.sink;

  Stream<List<SystemMsgBean>> get sysMsgStream => _msgRepos.stream;

  //小程序分类
  BehaviorSubject<List<AppletClassfyBean>> _applet =
      BehaviorSubject<List<AppletClassfyBean>>();

  Sink<List<AppletClassfyBean>> get _appletSink => _applet.sink;

  Stream<List<AppletClassfyBean>> get appletStream => _applet.stream;

  //小程序列表
  BehaviorSubject<List<AppletBean>> _appletListControl =
      BehaviorSubject<List<AppletBean>>();

  Sink<List<AppletBean>> get _appletListSink => _appletListControl.sink;

  Stream<List<AppletBean>> get appletListStream => _appletListControl.stream;

  List<AppletBean> _appletList;

  BehaviorSubject<int> appClassfyIndex = BehaviorSubject<int>();

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

  MainBloc() {
    LogUtil.e("MainBloc......");
  }

  @override
  Future getData({int page}) {
    return getHomeData();
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = 0;
    ++_page;
    return getData(page: _page);
  }

  @override
  Future onRefresh({bool isReload}) {
    return getData(page: 0);
  }

  Future getHomeData() {
    getSystemMsg();
    getHomeAppletData(id);
    return getBanner(1);
  }

  Future getBanner(int type) {
    LogUtil.e("getBanner");
    return wanRepository.getBanner(type).then((list) {
      _bannerSink.add(UnmodifiableListView<BannerBean>(list));
    });
  }

  Future getSystemMsg() async {
    return wanRepository.getMsgList().then((list) {
      _msgReposSink.add(UnmodifiableListView<SystemMsgBean>(list));
    });
  }

  Future getHomeAppletData(String encode_id) async {
    if (ObjectUtil.isEmpty(encode_id)) {
      wanRepository.getAppletClass().then((list) {
        _appletSink.add(UnmodifiableListView<AppletClassfyBean>(list));
        getAppletList(list[0].encode_id);
      });
    } else {
      id = encode_id;
      print("--------------" + id);
      getAppletList(encode_id);
    }
  }

  Future getAppletList(String labelId) {
    return wanRepository.getAppletList(labelId).then((list) {
      if (_appletList == null) {
        _appletList = new List();
      }
      if (_appletList.length > 0) _appletList.clear();

      _appletList.addAll(list);
      _appletListSink.add(UnmodifiableListView<AppletBean>(_appletList));
    });
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
  void test() {
    LogUtil.e("MainBloc test 1.....");
  }

  @override
  void dispose() {
    _banner.close();
    _msgRepos.close();
    _applet.close();
    _appletListControl.close();
    appClassfyIndex.close();
  }
}
