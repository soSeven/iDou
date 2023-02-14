import 'package:base_library/base_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:idou/bean/mine/cpm_income_model.dart';
import 'package:idou/bean/mine/team_sub_model.dart';
import 'package:idou/common/common.dart';
// model
import 'package:idou/bean/mine/base_model.dart';
import 'package:idou/bean/mine/message_model.dart';
import 'package:idou/bean/mine/invite_post_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';

typedef CreateObject<T> = T Function(Map<String, dynamic> json);
typedef CreateList = List<dynamic> Function(Map<String, dynamic> json);

enum TeamSubUrlType {
  user,
  bind,
  vip
}

enum InComeTimeType {
  month,
  yesterday,
  all
}

class MineApi  {

  // MARK: - Request Methods

  static Future<List<T>> postWithListObjects<T extends BaseModel>({
    @required String url,
    Map<String, Object> para,
    @required CreateObject<T> create
  }) async {

    try {
      BaseResp<List> baseResp =
      await DioUtil.getInstance().request<List>(Method.post, url, data: para);

      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      }
      if (baseResp.data == null) {
        return null;
      }
      var mapList = baseResp.data;
      if (mapList == null) {
        return null;
      }
      List<T> list = mapList.map((value) {
        return create(value);
      }).toList();
      return list;
    } catch (e) {
      print(e);
      return new Future.error('请求失败(90001)');
    }

  }

  static Future<List<T>> postWithCreateListObjects<T extends BaseModel>({
    @required String url,
    Map<String, Object> para,
    @required CreateList createList,
    @required CreateObject<T> create
  }) async {

    try {
      BaseResp<Map<String, dynamic>> baseResp =
      await DioUtil.getInstance().request<Map<String, dynamic>>(Method.post, url, data: para);

      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      }
      if (baseResp.data == null) {
        return null;
      }
      var mapList = createList(baseResp.data);
      if (mapList == null) {
        return null;
      }
      List<T> list = mapList.map((value) {
        return create(value);
      }).toList();
      return list;
    } catch (e) {
      return new Future.error('请求失败(90001)');
    }

  }

  static Future<T> postWithObject<T extends BaseModel>({
    @required String url,
    Map<String, Object> para,
    @required CreateObject<T> create
  }) async {
    try {
      BaseResp<Map<String, Object>> baseResp =
      await DioUtil().request<Map<String, Object>>(Method.post, url, data: para);
      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      }
      if (baseResp.data == null) {
        return null;
      }
      return create(baseResp.data);
    } catch (e) {
      return new Future.error('请求失败(90001)');
    }

  }

  // MARK: - 我的页面请求

  // 消息列表
  static Future<List<MessageModel>> postWithMessageList({@required int page}) async {

    return await postWithCreateListObjects<MessageModel>(
        url: 'system_message/index',
        para: {'page': page, 'limit': 10},
        createList:(map) => map['list'] ,
        create: (value) => MessageModel.fromJson(value),
    );

  }

  // 海报背景图列表
  static Future<List<InvitePostModel>> postWithPostList() async {

    return await postWithListObjects<InvitePostModel>(
      url: 'invite_bill/index',
      create: (value) => InvitePostModel.fromJson(value),
    );

  }

  // 潜在用户列表 group_manage/potential
  // 绑定了抖音号的用户列表 group_manage/bind_douyin
  // 开通了VIP的用户列表 group_manage/vip
  static Future<TeamSubModel> postWithTeamUserList({@required int page, @required TeamSubUrlType type}) async {

    var url = 'group_manage/potential';
    if (type == TeamSubUrlType.bind) {
      url = 'group_manage/bind_douyin';
    } else if (type == TeamSubUrlType.vip) {
      url = 'group_manage/vip';
    }
    return await postWithObject(
        url: url,
        para: {'page' : page, 'limit' : 10},
        create: (value) => TeamSubModel.fromJson(value),
    );

  }

  // 收益报表展示小程序列表
  static Future<CpmIncomeModel> postWithCpmIncomeList({@required int page, @required InComeTimeType type}) async {

    var time = 'month';
    if (type == InComeTimeType.yesterday) {
      time = 'yesterday';
    } else if (type == InComeTimeType.all) {
      time = 'all';
    }
    return await postWithObject(
      url: 'stat/applet_list',
      para: {'type' : time, 'page' : page, 'limit' : 10},
      create: (value) => CpmIncomeModel.fromJson(value),
    );

  }

  // 上传图片
  static Future<String> uploadImg(String path) async {
    try {
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      FormData formData = FormData.from({
        "file": UploadFileInfo(File(path), name),
        'upload_dir': 'feedback',
      });
      BaseResp<String> baseResp =
      await DioUtil().request<String>(Method.post, 'common/upload', data: formData);
      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      }
      if (baseResp.data == null) {
        return new Future.error('请求失败(90001)');
      }
      return baseResp.data;

    } catch (e) {
      return new Future.error('请求失败(90001)');
    }

  }

  // 上传反馈
  static Future<bool> postWithFeedback(String content, String pic, String contact) async {
    try {
      BaseResp<String> baseResp =
      await DioUtil().request<String>(Method.post, 'feedback/add',
          data:
          {
            'content' : content ?? '',
            'pic' : pic ?? '',
            'contact' : contact ?? ''
          });
      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      } else {
        return true;
      }
    } catch (e) {
      return new Future.error('请求失败(90001)');
    }

  }

  // 获取验证码
  static Future<bool> postWithCheckCode(String phone) async {
    try {
      BaseResp<String> baseResp =
      await DioUtil().request<String>(Method.post, 'common/send_mobile_code',
          data:
          {
            'event' : 'bind',
            'mobile' : phone ?? '',
          });
      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      } else {
        return true;
      }
    } catch (e) {
      return new Future.error('请求失败(90001)');
    }

  }

  // 绑定手机
  static Future<bool> postWithBindPhone(String phone, String code) async {
    try {
      BaseResp<String> baseResp =
      await DioUtil().request<String>(Method.post, 'user/bind_mobile_by_code',
          data:
          {
            'mobile' : phone ?? '',
            'code' : code ?? '',
          });
      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      } else {
        return true;
      }
    } catch (e) {
      return new Future.error('请求失败(90001)');
    }

  }

  // 修改微信号
  static Future<bool> postWithChangeWeChat(String weChat) async {
    try {
      BaseResp<String> baseResp =
      await DioUtil().request<String>(Method.post, 'user/edit_profile',
          data:
          {
            'field' : 'wechat',
            'field_val' : weChat ?? '',
          });
      if (baseResp.code != Constant.status_success) {
        return new Future.error(baseResp.msg);
      } else {
        return true;
      }
    } catch (e) {
      return new Future.error('请求失败(90001)');
    }

  }



}