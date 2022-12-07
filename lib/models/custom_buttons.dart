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
    var character = _scene.characters[0];
    if (!character.usingAbility && !character.isGettingDamage) {
      character.setDirection(dir);
      character.setMovement(true);
    }
  }

  @override
  void onTapCancel() {
    var character = _scene.characters[0];
    if (!character.usingAbility && !character.isGettingDamage) {
      character.setDirection(dir);
      character.setMovement(false);
    }
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
    if (_scene.characters[0].isGrounded() &&
        !_scene.characters[0].usingAbility &&
        !_scene.characters[0].isGettingDamage) {
      _scene.characters[0].jump(-6);
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
      _scene.characters[0].attack(dodge: true, floor: true);
    }
  }

  @override
  void onTapCancel() {}
}

abstract class Button {
  get img => null;

  get bbox => null;

  void onTap();
  void onTapCancel();
}
