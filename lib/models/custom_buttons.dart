import 'package:flutter/cupertino.dart';
import "dart:ui" as ui;
import 'game_stage.dart';

class MovingButton extends Button {
  final String dir;
  final _scene = Stage();
  @override
  final ui.Image img;
  @override
  final Rect bbox;

  MovingButton({required this.dir, required this.img, required this.bbox});

  @override
  void onTap() {
    _scene.move(_scene.characters[0], dir, true);
  }

  @override
  void onTapCancel() {
    _scene.move(_scene.characters[0], dir, false);
  }
}

class JumpButton extends Button {
  final _scene = Stage();
  @override
  final ui.Image img;
  @override
  final Rect bbox;

  JumpButton({required this.img, required this.bbox});

  @override
  void onTap() {
    if (_scene.characters[0].isGrounded()) {
      _scene.characters[0].setJumpSpeed(-4);
    }
  }

  @override
  void onTapCancel() {
    return;
  }
}

class AttackButton extends Button {
  final _scene = Stage();
  @override
  final ui.Image img;
  @override
  final Rect bbox;

  AttackButton({required this.img, required this.bbox});
  @override
  void onTap() {
    _scene.characters[0].attack();
  }

  @override
  void onTapCancel() {}
}

class QuickAttackButton extends Button {
  final _scene = Stage();
  @override
  final ui.Image img;
  @override
  final Rect bbox;

  QuickAttackButton({required this.img, required this.bbox});
  @override
  void onTap() {
    _scene.characters[0].attack(quick: true);
  }

  @override
  void onTapCancel() {}
}

class DodgeButton extends Button {
  final _scene = Stage();
  @override
  final ui.Image img;
  @override
  final Rect bbox;

  DodgeButton({required this.img, required this.bbox});
  @override
  void onTap() {
    _scene.characters[0].attack(dodge: true);
  }

  @override
  void onTapCancel() {}
}

class FloorButton extends Button {
  final _scene = Stage();
  @override
  final ui.Image img;
  @override
  final Rect bbox;

  FloorButton({required this.img, required this.bbox});

  @override
  void onTap() {
    if (_scene.characters[0].isGrounded() && _scene.characters[0].isMoving) {
      _scene.characters[0].isFloor = true;
    }
  }

  @override
  void onTapCancel() {
    _scene.characters[0].isFloor = false;
  }
}

abstract class Button {
  get img => null;

  get bbox => null;

  void onTap();
  void onTapCancel();
}
