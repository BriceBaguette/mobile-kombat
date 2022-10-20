import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:mobile_kombat/models/game_stage.dart';

class StickMan extends Character {
  @override
  StickMan(
      {required this.image,
      required this.bbox,
      required this.speed,
      required this.facing});
  @override
  ui.Image image;
  @override
  Rect bbox;
  @override
  double speed;
  String facing;
  double upSpeed = 0;
  var isMoving = false;

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
      setJumpSpeed(upSpeed + 0.05);
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
}

abstract class Character {
  get speed => null;

  get image => null;

  get bbox => null;

  get upspeed => null;

  bool isGrounded();
  void update();
  void setMovement(bool move);
  void setDirection(String direction);
  void setJumpSpeed(double value);
  void move();
}
