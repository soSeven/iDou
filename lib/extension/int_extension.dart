import 'package:idou/utils/mine_util.dart';

extension Scale on int {
  double scale() {
    return this * MineUtil.scale;
  }
}