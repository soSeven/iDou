import 'dart:collection';

import 'package:idou/bean/hot_video_bean.dart';
import 'package:idou/blocs/app_bloc_base.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/network/data/data_center_api.dart';

class HotVideoBloc extends AppBlocBase {
  static const int FIRST_PAGE = 1; //页码从1开始
  List<HotVideoBean> _dataList;
  DataCenterApi dataApi = new DataCenterApi();
  int page = FIRST_PAGE;

  //数据列表
  BehaviorSubject<List<HotVideoBean>> dataChangeSubject =
      BehaviorSubject<List<HotVideoBean>>();

  //列表加载状态
  BehaviorSubject<bool> listStatusSubject = BehaviorSubject<bool>();

  @override
  void dispose() {
    dataChangeSubject.close();
    listStatusSubject.close();
    super.dispose();
  }

  @override
  Future getData({String labelId, int page = FIRST_PAGE}) {
    this.page = page;
    return callApi(dataApi.getHotVideo(page), (list) {
      if (_dataList == null) {
        _dataList = new List();
      }
      if (page == FIRST_PAGE) {
        _dataList.clear();
      }
      _dataList.addAll(list);
      dataChangeSubject.add(UnmodifiableListView<HotVideoBean>(_dataList));
      listStatusSubject?.add(ObjectUtil.isEmpty(list));
    }, onError: (error) {
      dataChangeSubject.addError(error);
    });
  }

  @override
  Future onLoadMore({String labelId}) {
    return getData(page: page + 1);
  }

  @override
  Future onRefresh({String labelId}) {
    return getData(page: FIRST_PAGE);
  }
}
