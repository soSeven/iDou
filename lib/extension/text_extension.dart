import 'package:flutter/material.dart';
import 'package:idou/utils/mine_util.dart';
import 'int_extension.dart';

extension NormalText on Text {

  static Text normal({
    @required String text,
    int fontSize = 12,
    FontWeight weight = FontWeight.normal,
    Color color = Colors.white,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize.scale(),
          fontWeight: weight,
          fontFamily: MineUtil.fontFamily,
          color: color
      ),
      textAlign: textAlign,
    );
  }

}