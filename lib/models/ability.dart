import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class SwordStrike extends Ability {
  @override
  int power = 10;
  @override
  ui.Image image;

  SwordStrike({required this.image});

  @override
  Rect range(Rect characterHitBox, String facing) {
    var left = characterHitBox.left;
    var top = characterHitBox.top + characterHitBox.height / 2;
    var width = characterHitBox.width;
    var height = characterHitBox.height / 3;

    var range = Rect.fromLTWH(left, top, width, height);

    switch (facing) {
      case 'RIGHT':
        range = range.translate(characterHitBox.width, 0);
        break;
      case 'LEFT':
        range = range.translate(-width, 0);
        break;
      default:
        break;
    }

    return range;
  }
}

abstract class Ability {
  get power => null;

  get image => null;

  Rect range(Rect characterHitBox, String facing);
}
