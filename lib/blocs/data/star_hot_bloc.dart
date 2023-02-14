import 'dart:collection';

import 'package:idou/bean/star_hot_bean.dart';
import 'package:idou/blocs/app_bloc_base.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/network/data/data_center_api.dart';

class StarHotBloc extends AppBlocBase {
  static const int FIRST_PAGE = 1; //页码从1开始
  List<StarHotBean> _dataList;
  DataCenterApi dataApi = new DataCenterApi();
  int page = FIRST_PAGE;

  //数据列表
  BehaviorSubject<List<StarHotBean>> dataChangeSubject =
      BehaviorSubject<List<StarHotBean>>();

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
    return callApi(dataApi.getStarHotList(page), (list) {
      if (_dataList == null) {
        _dataList = new List();
      }
      if (page == FIRST_PAGE) {
        _dataList.clear();
      }
      _dataList.addAll(list);
      dataChangeSubject.add(UnmodifiableListView<StarHotBean>(_dataList));
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
