import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';

import 'models/custom_buttons.dart';
import 'models/game_stage.dart';

class Controller {
  static Controller? _controller;

  late ui.Offset pointerPos;
  List<Button> buttons = [];
  final _scene = Stage();

  factory Controller() {
    _controller ??= Controller._hidden();
    return _controller!;
  }

  Controller._hidden();

  void onTapStart(PointerDownEvent details) {
    pointerPos = details.localPosition;
    var button = _scene.getButton(pointerPos);
    if (button != null) {
      if (!buttons.contains(button)) {
        buttons.add(button);
        button.onTap();
      }
    }
  }

  void onDrag(PointerMoveEvent details) {
    pointerPos = details.localPosition;
    var button = _scene.getButton(pointerPos);
    if (button != null) {
      if (!buttons.contains(button)) {
        if (buttons.isNotEmpty) {
          buttons.removeAt(0).onTapCancel();
        }
        buttons.add(button);
        button.onTap();
      } else if (buttons.isNotEmpty) {
        buttons.insert(0, buttons.removeAt(buttons.indexOf(button)));
      }
    } else if (buttons.isNotEmpty) {
      buttons.removeAt(0).onTapCancel();
    }
  }

  void onTapStop(PointerUpEvent details) {
    pointerPos = details.localPosition;
    var button = _scene.getButton(pointerPos);
    if (button != null) {
      if (buttons.contains(button)) {
        button.onTapCancel();
        buttons.remove(button);
      }
    }
  }
}
