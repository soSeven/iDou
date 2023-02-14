import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idou/pages/container_page.dart';
import 'package:idou/pages/splash_page.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bean/LanguageBean.dart';
import 'blocs/application_bloc.dart';
import 'blocs/bloc_provider.dart';
import 'blocs/main_bloc.dart';
import 'common/component_index.dart';
import 'common/global.dart';

import 'routes/mine_route.dart';
import 'routes/home_route.dart';
import 'routes/data_route.dart';

void main() {
  Global.init(() {
    runApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider(child: MyApp(), bloc: MainBloc()),
    ));
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = MyColors.app_main;

  @override
  void initState() {
    super.initState();
    setInitDir(initStorageDir: true);
    requestPermission();
//    setLocalizedValues(localizedValues);
    init();
  }

  void init() {
    _init();
    _initListener();
    _loadLocale();
  }

  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      _loadLocale();
    });
  }

  void _loadLocale() {
    setState(() {
      LanguageBean model =
          SpUtil.getObj(Constant.keyLanguage, (v) => LanguageBean.fromJson(v));
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }

      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null)
        _themeColor = themeColorMap[_colorKey];
    });
  }

  void _init() {
    DioUtil.openDebug();
    Options options = DioUtil.getDefOptions();
    options.baseUrl = Constant.server_address;
    String token = "3a7e4280-8832-4567-8ba3-7dfa604aaa81";
    if (ObjectUtil.isNotEmpty(token)) {
      Map<String, dynamic> _headers = new Map();
      _headers["token"] = token;
      options.headers = _headers;
    }
    HttpConfig config = new HttpConfig(options: options);
    //重新定义基础字段名
    config.code = "err_code";
    config.msg = "msg";
    config.data = "data";
    DioUtil().setConfig(config);

//    DioUtil().getDio().onHttpClientCreate = (client) {
//      client.findProxy = (uri) {
//        return 'PROXY 192.168.100.228:8888';
//      };
//    };

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final routes = <String, WidgetBuilder> {
      BaseConstant.routeMain: (ctx) => ContainerPage(),
    };
    routes.addAll(HomeRoute.routes);
    routes.addAll(DataRoute.routes);
    routes.addAll(MineRoute.routes);

    return new MaterialApp(
      routes: routes,
      home: new SplashPage(),
      theme: ThemeData.dark().copyWith(
        primaryColor: _themeColor,
        scaffoldBackgroundColor: MyColors.app_bg,
        accentColor: _themeColor,
        indicatorColor: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
    );
  }

  Future requestPermission() async {
    if(await Permission.storage.request().isGranted) {
    }else{
      Fluttertoast.showToast(msg: "请打开读写权限，方便下载小程序二维码");
      Permission.storage.request();
    }

  }

  @override
  void dispose() {
    super.dispose();
  }


}
