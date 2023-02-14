import 'dart:collection';

import 'package:idou/bean/hot_sentence_bean.dart';
import 'package:idou/bean/hot_video_bean.dart';
import 'package:idou/blocs/app_bloc_base.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/network/data/data_center_api.dart';

class HotSentenceBloc extends AppBlocBase {
  static const int Label_IDOU = 1;
  static const int FIRST_PAGE = 1; //页码从1开始
  List<HotSentenceBean> _dataList;
  List<HotSentenceBean> _dataListIdou;
  DataCenterApi dataApi = new DataCenterApi();
  int page = FIRST_PAGE;
  int curTabIndex = 0;

  //数据列表
  BehaviorSubject<List<HotSentenceBean>> dataChangeSubject =
      BehaviorSubject<List<HotSentenceBean>>();

  //数据列表
  BehaviorSubject<List<HotVideoBean>> subTitleListSubject =
      BehaviorSubject<List<HotVideoBean>>();

  //数据列表
  BehaviorSubject<String> subTitleSubject = BehaviorSubject<String>();

  //列表加载状态
  BehaviorSubject<bool> listStatusSubject = BehaviorSubject<bool>();

  //Tab当前索引
  BehaviorSubject<int> curTabIndexSubject = BehaviorSubject<int>();

  @override
  void dispose() {
    dataChangeSubject.close();
    subTitleSubject.close();
    subTitleListSubject.close();
    listStatusSubject.close();
    curTabIndexSubject.close();
    super.dispose();
  }

  @override
  Future getData({int labelId, int page = FIRST_PAGE}) {
    if (labelId == Label_IDOU) {
      return getIdouList(page);
    } else {
      return getList(labelId, page);
    }
  }

  Future getIdouList(int page) {
    return callApi(dataApi.hotSearchSentencesIDou(page), (list) {
      if (_dataListIdou == null) {
        _dataListIdou = new List();
      }
      if (page == FIRST_PAGE) {
        _dataListIdou.clear();
      }
      if (list != null) _dataListIdou.addAll(list);
      dataChangeSubject
          .add(UnmodifiableListView<HotSentenceBean>(_dataListIdou));
      listStatusSubject?.add(ObjectUtil.isEmpty(list));
    }, onError: (error) {
      dataChangeSubject.addError(error);
    });
  }

  Future getList(int labelId, int page) {
    this.page = page;
    return callApi(dataApi.hotSearchSentences(page), (list) {
      if (_dataList == null) {
        _dataList = new List();
      }
      if (page == FIRST_PAGE) {
        _dataList.clear();
      }
      _dataList.addAll(list);
      dataChangeSubject.add(UnmodifiableListView<HotSentenceBean>(_dataList));
      listStatusSubject?.add(ObjectUtil.isEmpty(list));
    }, onError: (error) {
      dataChangeSubject.addError(error);
    });
  }

  Future hotSearchVideos(String sentence) {
    return callApi(dataApi.hotSearchVideos(sentence), (list) {
      subTitleListSubject.add(UnmodifiableListView<HotVideoBean>(list));
      subTitleSubject?.add(sentence);
    }, onError: (error) {
      subTitleListSubject.addError(error);
    });
  }

  @override
  Future onLoadMore() {
    return getData(labelId: curTabIndex, page: page + 1);
  }

  @override
  Future onRefresh() {
    return getData(labelId: curTabIndex, page: FIRST_PAGE);
  }

  void changeTabList(int labelId) {
    // do nothing if already disposed
    if (isDisposed) {
      return;
    }
    curTabIndex = labelId;
    if (labelId == Label_IDOU) {
      if (_dataListIdou == null) {
        getData(labelId: labelId);
      } else {
        dataChangeSubject
            .add(UnmodifiableListView<HotSentenceBean>(_dataListIdou));
      }
    } else {
      if (_dataList == null) {
        getData();
      } else {
        dataChangeSubject.add(UnmodifiableListView<HotSentenceBean>(_dataList));
      }
    }
  }
}
