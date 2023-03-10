import 'package:flutter/cupertino.dart';
import 'package:mobile_kombat/models/database.dart';
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
      _rtDb.setDirection(dir);
      _rtDb.setMovement(true);
    }
  }

  @override
  void onTapCancel() {
    var character = _scene.characters[0];
    if (!character.usingAbility && !character.isGettingDamage) {
      character.setMovement(false);
      _rtDb.setMovement(false);
    } else {
      character.isMoving = false;
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
    if (!_scene.characters[0].hasJumped &&
        !_scene.characters[0].usingAbility &&
        !_scene.characters[0].isGettingDamage) {
      _scene.characters[0].jump(-6);
      _rtDb.setJump(-6);
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
    _rtDb.setAttack('normal');
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
    _rtDb.setAttack('quick');
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
    if (_scene.characters[0].dodgeRemainingCooldown <= 0) {
      _scene.characters[0].attack(dodge: true);
      _rtDb.setAttack('dodge');
    }
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
    if (_scene.characters[0].isGrounded() && !_scene.characters[0].isMoving) {
      _scene.characters[0].isFloor = true;
    }
  }

  @override
  void onTapCancel() {
    _scene.characters[0].isFloor = false;
  }
}

abstract class Button {
  final RealTimeDB _rtDb = RealTimeDB();
  get img => null;

  get bbox => null;

  void onTap();
  void onTapCancel();
}
