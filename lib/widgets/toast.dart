export 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:idou/extension/int_extension.dart';
import 'package:idou/utils/mine_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastState {
  error,
  success,
  alert
}

class Toast {

  static void showToast({
    @required BuildContext context,
    @required String text,
    ToastState state = ToastState.error,
    ToastGravity gravity = ToastGravity.BOTTOM
  }) {
    IconData _getIcon(ToastState state) {
      switch (state) {
        case ToastState.error:
          return Icons.clear;
        case ToastState.alert:
          return Icons.error;
        case ToastState.success:
          return Icons.check;
      }
      return Icons.clear;
    }
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.scale()),
          color: Colors.black.withOpacity(0.7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              child: Icon(_getIcon(state), color: Colors.white70,),
              constraints: BoxConstraints.tightFor(width: 20.scale(), height: 20.scale()),
            ),
            SizedBox(
              height: 12.scale(),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12.scale(),
                fontWeight: FontWeight.normal,
                fontFamily: MineUtil.fontFamily,
                color: Colors.white70
              ),
            ),
          ],
        ),
      );
    FToast(context).showToast(
        child: toast,
        gravity: gravity,
        toastDuration: Duration(seconds: 2),
    );

  }

}