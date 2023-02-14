import 'package:base_library/base_library.dart';
import 'package:idou/bean/dy_category_bean.dart';
import 'package:idou/bean/dy_category_data_bean.dart';
import 'package:idou/bean/hot_sentence_bean.dart';
import 'package:idou/bean/hot_video_bean.dart';
import 'package:idou/bean/rank_user_entity.dart';
import 'package:idou/bean/star_hot_bean.dart';
import 'package:idou/common/common.dart';

class DataCenterApi {
  /// 用户排行榜
  Future<List<RankUserEntity>> getRankUserList(bool isVip) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, "/data_center/rank",
            data: {"is_vip": isVip ? 1 : 0});

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<RankUserEntity> list;

    if (baseResp.data != null) {
      UserRankBean userRankBean = UserRankBean.fromJson(baseResp.data);
      list = userRankBean.list;
    }
    return list;
  }

  ///  抖音账号领域分类 /douyin_account/category
  Future<List<DyCategoryBean>> getDYCategory() async {
    BaseResp<List> baseResp =
        await DioUtil().request<List>(Method.post, "/douyin_account/category");

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<DyCategoryBean> list;

    if (baseResp.data != null) {
      list = baseResp.data.map((value) {
        return DyCategoryBean.fromJson(value);
      }).toList();
    }
    return list;
  }

  ///  抖音账号领域数据 /douyin_account/category_data
  Future<List<DyCategoryDataBean>> getDYCategoryData(String encodeId) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, "/douyin_account/category_data",
            data: {"encode_id": encodeId});

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<DyCategoryDataBean> list;

    if (baseResp.data != null) {
      DyCategoryDataResponse bean =
          DyCategoryDataResponse.fromJson(baseResp.data);
      list = bean.data;
    }
    return list;
  }

  ///  数据中心-总播放量 /data_center/totalData
  Future<List<DyCategoryDataBean>> getTotalData() async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, "/data_center/totalData");

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<DyCategoryDataBean> list;

    if (baseResp.data != null) {
      DyCategoryDataResponse bean =
          DyCategoryDataResponse.fromJson(baseResp.data);
      list = bean.data;
    }
    return list;
  }

  ///  热门视频榜 /douyin_data/hot_video
  Future<List<HotVideoBean>> getHotVideo(int page) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, "/douyin_data/hot_video",
            data: {"page": page});

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<HotVideoBean> list;
    if (baseResp.data != null && baseResp.data["data"] != null) {
      list = baseResp.data["data"].map<HotVideoBean>((value) {
        return HotVideoBean.fromJson(value);
      }).toList();
    }
    return list;
  }

  ///  抖音星图榜单数据 /douyin_data/star_hot_list
  Future<List<StarHotBean>> getStarHotList(int page) async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.post, "/douyin_data/star_hot_list",
        data: {"page": page});

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<StarHotBean> list;

    if (baseResp.data != null) {
      list = baseResp.data.map<StarHotBean>((value) {
        return StarHotBean.fromJson(value);
      }).toList();
    }
    return list;
  }

  ///  POST 获取实时热点词 /douyin_data/hot_search_sentences
  Future<List<HotSentenceBean>> hotSearchSentences(int page) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, "/douyin_data/hot_search_sentences",
            data: {"page": page});

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<HotSentenceBean> list;

    if (baseResp.data != null && baseResp.data["data"] != null) {
      list = baseResp.data["data"].map<HotSentenceBean>((value) {
        return HotSentenceBean.fromJson(value);
      }).toList();
    }
    return list;
  }

  ///  GET 爱抖家族话题 /douyin_data/question
  Future<List<HotSentenceBean>> hotSearchSentencesIDou(int page) async {
    if (page > 1) return null;
    BaseResp<List> baseResp =
        await DioUtil().request<List>(Method.get, "/douyin_data/question");

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<HotSentenceBean> list;

    if (baseResp.data != null) {
      list = baseResp.data.map<HotSentenceBean>((value) {
        return HotSentenceBean.fromJson(value);
      }).toList();
    }
    return list;
  }

  ///  POST 获取热点词聚合的视频 /douyin_data/hot_search_videos
  Future<List<HotVideoBean>> hotSearchVideos(String sentence) async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.post, "/douyin_data/hot_search_videos",
        data: {"sentence": sentence});

    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    List<HotVideoBean> list;

    if (baseResp.data != null) {
      list = baseResp.data.map<HotVideoBean>((value) {
        return HotVideoBean.fromJson(value);
      }).toList();
    }
    return list;
  }
}
