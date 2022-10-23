import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';

import 'models/custom_buttons.dart';
import 'models/game_stage.dart';

class Controller {
  static Controller? _controller;

  late ui.Offset pointerPos;
  Button? button;
  final _scene = Stage();

  factory Controller() {
    _controller ??= Controller._hidden();
    return _controller!;
  }

  Controller._hidden();

  void onTapStart(PointerDownEvent details) {
    pointerPos = details.localPosition;
    button = _scene.getButton(pointerPos);
    if (button != null) {
      button!.onTap();
    }
  }

  void onDrag(PointerMoveEvent details) {
    pointerPos = details.localPosition;
    if (button != null) {
      button!.onTapCancel();
    }
    button = _scene.getButton(pointerPos);
    if (button != null) {
      button!.onTap();
    }
  }

  void onTapStop(PointerUpEvent details) {
    pointerPos = details.localPosition;
    button = _scene.getButton(pointerPos);
    if (button != null) {
      button!.onTapCancel();
    }
  }
}
