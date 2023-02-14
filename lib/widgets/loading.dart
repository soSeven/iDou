
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';

extension Loading on FlutterEasyLoading {

  static FlutterEasyLoading build({
    @required Widget child,
    bool userInteractions = false,
  }) {

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = userInteractions;

    return FlutterEasyLoading(
      child: child,
    );

  }

}