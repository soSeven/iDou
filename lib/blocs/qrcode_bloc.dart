import 'dart:collection';

import 'package:idou/bean/douyin_account_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/blocs/bloc_index.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/data/repository/wan_repository.dart';

class QrcodeBloc extends BlocBase {


  BehaviorSubject<QrCodeBean> _QrcodeSub =
  BehaviorSubject<QrCodeBean>();

  String id = "";

  Sink<QrCodeBean> get _qrCodeSink => _QrcodeSub.sink;

  Stream<QrCodeBean> get qrCodeStream => _QrcodeSub.stream;


  BehaviorSubject<QrCodeBean> _SubQrcodeSub =
  BehaviorSubject<QrCodeBean>();


  Sink<QrCodeBean> get _subQrCodeSink => _SubQrcodeSub.sink;

  Stream<QrCodeBean> get subCodeStream => _SubQrcodeSub.stream;

  QrcodeBloc() {
    LogUtil.e("PlayIntroduceBloc......");
  }

  WanRepository wanRepository = new WanRepository();
  HttpUtils httpUtils = new HttpUtils();

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