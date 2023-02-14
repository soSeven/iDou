class WanAndroidApi {
  /// 首页banner
  static const String BANNER = "carousel/index";

  /// 首页系统消息列表
  static const String SYSTEM_MSG = "/system_announement/index";

  /// 首页小程序分类
  static const String APPLET_CLASSFY = "/applet/category";

  /// 项目分类
  static const String CONFIG_MSG = "/common/config";

  ///首页小程序列表
  static const String APPLET_LIST = "/applet/index";

  /// 小程序详情
  static const String APPLET_DETAIL = "/applet/detail";

  /// 小程序详情小程序子列表
  static const String APPLET_DETAIL_SUBLIST = "/applet/sub";

  /// 小程序详情收益
  static const String APPLET_INCOME = "/stat/applet";

  /// 小程序团队详情收益
  static const String APPLET_TEAM_INCOME = "/stat/applet_team";

  /// 玩法介绍搜索结果
  static const String PLAY_INTRO_RESULT = "/play_question/index";

  /// 抖音账号列表
  static const String DOUYIN_ACCOUNT_LIST = "/douyin_account/index";

  /// 下载小程序二维码
  static const String QR_CODE = "/applet/create_qr_code";

  /// 下载小程序子程序二维码
  static const String SUB_QR_CODE = "/applet/create_qr_code_sub";

  /// 绑定抖音二维码
  static const String DOUYIN_QR_CODE = "/douyin_account/bind";

  /// 删除抖音号
  static const String DELETE_DOUYIN = "/douyin_account/delete";


  /// 查看某个公众号历史数据 http://wanandroid.com/wxarticle/list/405/1/json
  /// 在某个公众号中搜索历史文章 http://wanandroid.com/wxarticle/list/405/1/json?k=Java
  static const String WXARTICLE_LIST = "wxarticle/list";

  static const String user_register = "user/register"; //注册
  static const String user_login = "user/login"; //登录
  static const String user_logout = "user/logout"; //退出

  static const String lg_collect_list = "lg/collect/list"; //收藏文章列表
  static const String lg_collect = "lg/collect"; //收藏站内文章
  static const String lg_uncollect_originid = "lg/uncollect_originId"; //取消收藏

  static String getPath({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    return sb.toString();
  }
}
