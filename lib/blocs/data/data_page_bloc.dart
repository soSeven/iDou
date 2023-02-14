import 'dart:collection';

import 'package:idou/bean/dy_category_bean.dart';
import 'package:idou/bean/dy_category_data_bean.dart';
import 'package:idou/bean/rank_user_entity.dart';
import 'package:idou/blocs/app_bloc_base.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/network/data/data_center_api.dart';

class DataPageBloc extends AppBlocBase {
  ///****** ****** ****** Data Center ****** ****** ****** /
  DataCenterApi dataApi = new DataCenterApi();

  //免费用户排行榜
  BehaviorSubject<List<RankUserEntity>> freeUserListSubject =
      BehaviorSubject<List<RankUserEntity>>();

  //VIP用户排行榜
  BehaviorSubject<List<RankUserEntity>> vipUserListSubject =
      BehaviorSubject<List<RankUserEntity>>();

  //所有分类列表
  BehaviorSubject<List<DyCategoryBean>> dyCategorySubject =
      BehaviorSubject<List<DyCategoryBean>>();

  //指定分类数据列表
  BehaviorSubject<List<DyCategoryDataBean>> dyCategoryDataSubject =
      BehaviorSubject<List<DyCategoryDataBean>>();

  //抖音排行Tab当前索引
  BehaviorSubject<int> curDyTabIndexSubject = BehaviorSubject<int>();

  //抖音排行Tab是否隐藏
  BehaviorSubject<bool> isDyTabClosedSubject = BehaviorSubject<bool>();

  Future getRankUserList(bool isVip) {
    return callApi(dataApi.getRankUserList(isVip), (list) {
      //avoid UnmodifiableListView null pointer exception
      var ul = list == null ? null : UnmodifiableListView<RankUserEntity>(list);
      if (isVip) {
        vipUserListSubject.add(ul);
      } else {
        freeUserListSubject.add(ul);
      }
    }, onError: (e) {
      if (isVip) {
        vipUserListSubject.addError(e);
      } else {
        freeUserListSubject.sink.addError(e);
      }
    });
  }

  Future getDYCategory() {
    return callApi(dataApi.getDYCategory(), (list) {
      var ul = list == null ? null : UnmodifiableListView<DyCategoryBean>(list);
      dyCategorySubject.add(ul);
    }, onError: (e) {
      dyCategorySubject.addError(e);
    });
  }

  Future getDYCategoryData(String encodeId) {
    return callApi(dataApi.getDYCategoryData(encodeId), (list) {
      var ul =
          list == null ? null : UnmodifiableListView<DyCategoryDataBean>(list);
      dyCategoryDataSubject.add(ul);
    }, onError: (e) {
      dyCategoryDataSubject.addError(e);
    });
  }

  @override
  void dispose() {
    vipUserListSubject.close();
    freeUserListSubject.close();
    dyCategorySubject.close();
    dyCategoryDataSubject.close();
    curDyTabIndexSubject.close();
    isDyTabClosedSubject.close();
    super.dispose();
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
