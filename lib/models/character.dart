import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

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
}

abstract class Character {
  get speed => null;

  get image => null;

  get bbox => null;

  void update();
  void setMovement(bool move);
  void setDirection(String direction);
  void move();
}
