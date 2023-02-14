import 'package:flutter/material.dart';

extension LoadImage on AssetImage {

  static AssetImage localImage(String name) {
    return AssetImage('assets/images/$name.png');
  }

}