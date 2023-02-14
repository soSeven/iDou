import 'package:base_library/base_library.dart';
import 'package:idou/bean/app_applet_bean.dart';
import 'package:idou/bean/applet_detail_bean.dart';
import 'package:idou/bean/applet_detail_sub_bean.dart';
import 'package:idou/bean/applet_income_bean.dart';
import 'package:idou/bean/applet_team_income_bean.dart';
import 'package:idou/bean/douyin_account_bean.dart';
import 'package:idou/bean/home_applet_classfy_bean.dart';
import 'package:idou/bean/play_introduce_search_bean.dart';
import 'package:idou/bean/qr_code_bean.dart';
import 'package:idou/bean/system_msg_bean.dart';
import 'package:idou/bean/system_msg_list_bean.dart';
import 'package:idou/common/common.dart';
import 'package:idou/data/api/apis.dart';
import 'package:idou/bean/bannerbean.dart';
import 'package:idou/widgets/datapicker/date_format.dart';
import 'package:idou/widgets/datapicker/i18n_model.dart';
import 'package:idou/bean/douyin_account_bean.dart';

class WanRepository {
  Future<List<BannerBean>> getBanner(int type) async {
    LogUtil.e("WanRepository");
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.post, WanAndroidApi.BANNER,
        data: {"carousel_type": type});
    List<BannerBean> bannerList;
    LogUtil.e(baseResp.data);
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data.map((value) {
        return BannerBean.fromJson(value);
      }).toList();
    }
    return bannerList;
  }

  Future<List<SystemMsgBean>> getMsgList() async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.SYSTEM_MSG);

    MsgListBean msgListBean;
    List<SystemMsgBean> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      msgListBean = MsgListBean.fromJson(baseResp.data);
      list = msgListBean.list;
    }
    return list;
  }

//
  Future<List<AppletClassfyBean>> getAppletClass() async {
    BaseResp<List> baseResp = await DioUtil()
        .request<List>(Method.post, WanAndroidApi.APPLET_CLASSFY);
    List<AppletClassfyBean> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      list = baseResp.data.map((value) {
        return AppletClassfyBean.fromJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<AppletBean>> getAppletList(String encode_id) async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
        Method.post, WanAndroidApi.APPLET_LIST,
        data: {"encode_id": encode_id});
    List<AppletBean> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      list = baseResp.data.map((value) {
        return AppletBean.fromJson(value);
      }).toList();
    }
    return list;
  }

  Future<AppletDetailBean> getAppletDateal(String encode_id) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.APPLET_DETAIL,
            data: {"encode_id": encode_id});
    AppletDetailBean appletDetailBean;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      appletDetailBean = AppletDetailBean.fromJson(baseResp.data);
//      list = msgListBean.list;
    }
    return appletDetailBean;
  }

//
  Future<List<PlayIntroSearchBean>> getSearchResult(String content,int type) async {
    BaseResp<List> baseResp = await DioUtil()
        .request<List>(
            Method.post,
             WanAndroidApi.PLAY_INTRO_RESULT,
            data: {"question_type":type,"keyword":content});
    List<PlayIntroSearchBean> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      list = baseResp.data.map((value) {
        return PlayIntroSearchBean.fromJson(value);
      }).toList();
    }
    return list;
  }
//
  Future<List<Data>> getAppletDetailSublist(String encode_id) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.post, WanAndroidApi.APPLET_DETAIL_SUBLIST,
            data: {"encode_id": encode_id});
    AppletDetailSubBean appletDetailSubBean;
    List<Data> appletSubList;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      appletDetailSubBean = AppletDetailSubBean.fromJson(baseResp.data);

      appletSubList = appletDetailSubBean.data;
    }
    return appletSubList;
  }

//
  Future<AppletIncomeBean> getAppletIncome(
      String encode_id, DateTime dateTime) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.APPLET_INCOME,
            data: {
          "encode_id": encode_id,
          "date":
              formatDate(dateTime, [yyyy, '-', mm, '-', dd, ' '], LocaleType.zh)
        });
    AppletIncomeBean appletIncomeBean;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      appletIncomeBean = AppletIncomeBean.fromJson(baseResp.data);
    }
    return appletIncomeBean;
  }

  Future<AppletTeamIncomeBean> getAppletTeamIncome(
      String encode_id, String  type) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.APPLET_TEAM_INCOME,
        data: {
          "encode_id": encode_id,
          "type": type
        });
    AppletTeamIncomeBean appletIncomeBean;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      appletIncomeBean = AppletTeamIncomeBean.fromJson(baseResp.data);
    }
    return appletIncomeBean;
  }


  Future<List<DouyinAccount>> getDouyinAccountList() async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.DOUYIN_ACCOUNT_LIST,data: {"page":1,"limit":15});

    DouyinAccountBean data;
    List<DouyinAccount> list;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      data = DouyinAccountBean.fromJson(baseResp.data);
      list = data.data;
    }
    return list;
  }

  Future<QrCodeBean> getQrCode(String encode_id) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.QR_CODE,
        data: {
          "encode_id": encode_id,
        });
    QrCodeBean qrCodeBean;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      qrCodeBean = QrCodeBean.fromJson(baseResp.data);
    }
    return qrCodeBean;
  }




  Future<QrCodeBean> getSubQrCode(String encode_id) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.SUB_QR_CODE,
        data: {
          "encode_id": encode_id,
        });
    QrCodeBean qrCodeBean;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      qrCodeBean = QrCodeBean.fromJson(baseResp.data);
    }
    return qrCodeBean;
  }


  Future<QrCodeBean> getDouyinQrCode() async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.DOUYIN_QR_CODE);
    QrCodeBean qrCodeBean;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      qrCodeBean = QrCodeBean.fromJson(baseResp.data);
    }
    return qrCodeBean;
  }

  Future<bool> deleteDouyin(String encode_id) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.post, WanAndroidApi.DELETE_DOUYIN,data: {"encode_id":encode_id});
//    QrCodeBean qrCodeBean;
    if (baseResp.code != Constant.status_success) {
      return new Future.error(baseResp.msg);
    }
//    if (baseResp.msg != null) {
//      qrCodeBean = QrCodeBean.fromJson(baseResp.data);
//    }
    if(baseResp.msg == "操作成功"){
//      getDouyinAccountList();
      return true;
    }else
      return false;


  }
}
