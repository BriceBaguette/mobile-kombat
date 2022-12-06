import 'dart:ui';

import 'package:flutter/material.dart';

class Constant {
  static Constant? _constant;
  late final double w;
  late final double h;
  final int framerate = 16;
  final time = 15000;
  final double gokuRatio = 1.88;

  final int environmentOriginalHeight = 1080;
  final int environmentOriginalWidth = 1920;
  late Rect leftPlatformBox;
  late Rect rightPlatformBox;
  late Rect middlePlatformBox;
  late Rect upperPlatformBox;

  late double lightWidth;
  late double lightHeight;

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

    leftPlatformBox = Rect.fromLTWH(
        (200 / environmentOriginalWidth) * w,
        h * (1 - (116 / environmentOriginalHeight)),
        (228 / environmentOriginalWidth) * w,
        (116 / environmentOriginalHeight) * h);
    rightPlatformBox = Rect.fromLTWH(
        w * (1 - ((419) / environmentOriginalWidth)),
        h * (1 - (116 / environmentOriginalHeight)),
        (219 / environmentOriginalWidth) * w,
        (116 / environmentOriginalHeight) * h);
    middlePlatformBox = Rect.fromLTWH(
        (570 / environmentOriginalWidth) * w,
        h * (1 - (240 / environmentOriginalHeight)),
        (780 / environmentOriginalWidth) * w,
        (240 / environmentOriginalHeight) * h);
    upperPlatformBox = Rect.fromLTWH(
        (729 / environmentOriginalWidth) * w,
        (430 / environmentOriginalHeight) * h,
        (412 / environmentOriginalWidth) * w,
        (45 / environmentOriginalHeight) * h);

    lightHeight = w / 20 * gokuRatio;
    lightWidth = (345 / 923) * lightHeight;

    heavyHeight = w / 20 * gokuRatio;
    heavyWidth = (421 / 711) * heavyHeight;

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
