import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:flutter_application_1/models/game_stage.dart';
import 'package:flutter_application_1/models/ability.dart';

class StickMan extends Character {
  @override
  StickMan(
      {required this.image,
      required this.bbox,
      required this.speed,
      required this.facing,
      required this.mainAbImage}) {
    mainAbility = SwordStrike(image: mainAbImage);
  }

  @override
  ui.Image image;
  @override
  Rect bbox;
  @override
  double speed = 5;
  String facing = 'RIGHT';
  double upSpeed = 0;
  var isMoving = false;
  ui.Image mainAbImage;
  late Ability mainAbility;
  @override
  bool usingAbility = false;
  late Ability abilityInProgress;

  @override
  void setDirection(String direction) {
    facing = direction;
  }

  @override
  void setMovement(bool move) {
    isMoving = move;
  }

  @override
  void move() {
    if (isGrounded() & (upSpeed >= 0)) {
      setJumpSpeed(0);
    } else {
      setJumpSpeed(upSpeed + 0.1);
    }
    bbox =
        Rect.fromLTWH(bbox.left, bbox.top + upSpeed, bbox.width, bbox.height);
    if (isMoving) {
      switch (facing) {
        case 'RIGHT':
          bbox = Rect.fromLTWH(
              bbox.left + speed, bbox.top, bbox.width, bbox.height);
          break;
        case 'LEFT':
          bbox = Rect.fromLTWH(
              bbox.left - speed, bbox.top, bbox.width, bbox.height);
          break;
        default:
          return;
      }
    }
    return;
  }

  @override
  void update() {
    move();
  }

  @override
  void setJumpSpeed(double value) {
    upSpeed = value;
  }

  @override
  bool isGrounded() {
    if (Stage().isGround(Offset(bbox.left + bbox.width, bbox.top + bbox.height),
        Offset(bbox.left, bbox.top + bbox.height))) return true;
    return false;
  }

  @override
  ui.Image abilityImage() => abilityInProgress.image;

  @override
  Rect abilityRange() => abilityInProgress.range(bbox, facing);
}

abstract class Character {
  get speed => null;

  get image => null;

  get bbox => null;

  get upspeed => null;

  get usingAbility => null;

  bool isGrounded();
  void update();
  void setMovement(bool move);
  void setDirection(String direction);
  void setJumpSpeed(double value);
  void move();
  ui.Image abilityImage();
  Rect abilityRange();
}
