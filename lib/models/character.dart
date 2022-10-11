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
  var moving = false;

  @override
  void setDirection(String direction) {
    facing = direction;
    return;
  }

  @override
  void setMovement(bool move) {
    moving = move;
  }

  @override
  void move() {
    if (moving) {
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
}

abstract class Character {
  get speed => null;

  get image => null;

  get bbox => null;

  void setMovement(bool move);
  void setDirection(String direction);
  void move();
}
