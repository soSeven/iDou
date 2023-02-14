import 'dart:collection';

import 'package:idou/bean/bannerbean.dart';
import 'package:idou/bean/play_introduce_search_bean.dart';
import 'package:idou/blocs/bloc_index.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/data/repository/wan_repository.dart';

class PlayIntroduceBloc extends BlocBase {
  ///玩法介绍banner
  BehaviorSubject<List<BannerBean>> _banner =
      BehaviorSubject<List<BannerBean>>();

  String id = "";

  Sink<List<BannerBean>> get _bannerSink => _banner.sink;

  Stream<List<BannerBean>> get bannerStream => _banner.stream;


  ///玩法介绍搜索类型
  BehaviorSubject<int> IndexbehaviorSubject = BehaviorSubject<int>();

  ///玩法介绍搜索关键词
  BehaviorSubject<String> contentbehaviorSubject = BehaviorSubject<String>();

  ///玩法介绍搜索结果
  BehaviorSubject<List<PlayIntroSearchBean>> _SearchbehaviorSubject = BehaviorSubject<List<PlayIntroSearchBean>>();

  Sink<List<PlayIntroSearchBean>> get _searchSink => _SearchbehaviorSubject.sink;

  Stream<List<PlayIntroSearchBean>> get searchStream => _SearchbehaviorSubject.stream;

  WanRepository wanRepository = new WanRepository();
  HttpUtils httpUtils = new HttpUtils();

  PlayIntroduceBloc() {
    LogUtil.e("PlayIntroduceBloc......");
  }

  Future getPlayIntroBanner() {
    return wanRepository.getBanner(2).then((list) {
      _bannerSink.add(UnmodifiableListView<BannerBean>(list));
    });
  }

  Future getPlayIntroSearch(String content,int type) {
    return wanRepository.getSearchResult(content,type).then((list) {
      _searchSink.add(UnmodifiableListView<PlayIntroSearchBean>(list));
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
