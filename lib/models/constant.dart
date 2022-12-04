import 'dart:ui';

import 'package:flutter/material.dart';

class Constant {
  static Constant? _constant;
  late final double w;
  late final double h;
  final int framerate = 16;
  final time = 15000;
  final double gokuRatio = 1.88;

  late double heavyWidth;
  late double heavyHeight;

  late Rect leftButtonPosition;
  late Rect rightButtonPosition;
  late Rect jumpButtonPosition;
  late Rect floorButtonPosition;
  late Rect attackButtonPosition;
  late Rect dodgeButtonPosition;
  late Rect quickAttackButtonPosition;
  factory Constant() {
    _constant ??= Constant._hidden();
    return _constant!;
  }

  Constant._hidden() {
    var window = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    w = window.size.width;
    h = window.size.height;

    heavyHeight = w / 20 * gokuRatio;
    heavyWidth = (405 / 699) * heavyHeight;

    leftButtonPosition = Rect.fromLTWH(w / 40, h - h / 9, w / 15, h / 10);
    rightButtonPosition =
        Rect.fromLTWH(2 * w / 40 + w / 15, h - h / 9, w / 15, h / 10);
    jumpButtonPosition =
        Rect.fromLTWH(w / 40, h - w / 20 - h / 9 - h / 15, w / 20, w / 20);
    floorButtonPosition = Rect.fromLTWH(
        2 * w / 40 + w / 15, h - w / 20 - h / 9 - h / 15, w / 20, w / 20);
    attackButtonPosition =
        Rect.fromLTWH(w - w / 40 - w / 15, h - h / 9, w / 20, w / 20);
    dodgeButtonPosition =
        Rect.fromLTWH(w - w / 40 - 2 * w / 15, h - h / 9, w / 20, w / 20);
    quickAttackButtonPosition =
        Rect.fromLTWH(w - w / 40 - 3 * w / 15, h - h / 9, w / 20, w / 20);
  }
}
