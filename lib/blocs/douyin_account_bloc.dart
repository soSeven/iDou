import 'dart:collection';

import 'package:idou/bean/douyin_account_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/blocs/bloc_index.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/data/repository/wan_repository.dart';

class DouyinAccountBloc extends BlocBase {

  ///抖音账号列表
  BehaviorSubject<List<DouyinAccount>> _douyinAccountSub =
  BehaviorSubject<List<DouyinAccount>>();

  String id = "";

  Sink<List<DouyinAccount>> get _bannerSink => _douyinAccountSub.sink;

  Stream<List<DouyinAccount>> get douyinStream => _douyinAccountSub.stream;

  ///绑定抖音号
  BehaviorSubject<QrCodeBean> _douyinQrCodeSub =
  BehaviorSubject<QrCodeBean>();


  Sink<QrCodeBean> get _douyinQrCodeSink => _douyinQrCodeSub.sink;

  Stream<QrCodeBean> get douyinQrCodeStream => _douyinQrCodeSub.stream;

  ///删除抖音号
  BehaviorSubject<bool> deleteDouyin =
  BehaviorSubject<bool>();

  Sink<bool> get _deleteDouyinSink => deleteDouyin.sink;

  Stream<bool> get deleteDouyinStream => deleteDouyin.stream;

  PlayIntroduceBloc() {
    LogUtil.e("PlayIntroduceBloc......");
  }

  WanRepository wanRepository = new WanRepository();
  HttpUtils httpUtils = new HttpUtils();

  Future getDouyinAccountList() {
    return wanRepository.getDouyinAccountList().then((list) {
      var ul = list == null ? null : UnmodifiableListView<DouyinAccount>(list);
      _bannerSink.add(ul);
    });
  }

  Future bindingDouyinAccount() {
    return wanRepository.getDouyinQrCode().then((QrCodeBean data) {
      _douyinQrCodeSink.add(data);
    });
  }

  Future deleteDouyinAccount(encode_id) {
    return wanRepository.deleteDouyin(encode_id).then((bool data) {
      _deleteDouyinSink.add(data);
    });
  }



  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future getData({int page}) {
    // TODO: implement getData
    throw UnimplementedError();
  }

  @override
  Future onLoadMore() {
    // TODO: implement onLoadMore
    throw UnimplementedError();
  }

  @override
  Future onRefresh() {
    // TODO: implement onRefresh
    throw UnimplementedError();
  }

}