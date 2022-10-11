import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';

import 'models/CustomButtons.dart';
import 'models/gameStage.dart';

class Controller {
  static Controller? _controller;

  late ui.Offset pointerPos;
  Button? button;
  var _scene = Stage();

  factory Controller() {
    if (_controller == null) {
      _controller = Controller._hidden();
    }
    return _controller!;
  }

  Controller._hidden() {}

  void onTapStart(TapDownDetails details) {
    pointerPos = details.localPosition;
    button = _scene.getButton(pointerPos);
    if (button != null) {
      button!.onTap();
    }
  }

  void onTapStop() {
    if (button != null) {
      button!.onTapCancel();
    }
  }
}
