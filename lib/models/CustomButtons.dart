import 'package:flutter/cupertino.dart';
import "dart:ui" as ui;
import 'gameStage.dart';

class MovingButton extends Button {
  final String dir;
  final _scene = Stage();
  bool _pressed = false;
  @override
  final ui.Image img;
  @override
  final Rect bbox;

  MovingButton({required this.dir, required this.img, required this.bbox});

  @override
  void onTap() async {
    _scene.move(_scene.characters[0], dir, true);
  }

  @override
  void onTapCancel() {
    _scene.move(_scene.characters[0], dir, false);
  }
}

abstract class Button {
  get img => null;

  get bbox => null;

  void onTap();
  void onTapCancel();
}
