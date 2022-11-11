import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'loader.dart';

class LightQuick extends Ability {
  @override
  int power = 10;
  @override
  late List<ui.Image> images;
  @override
  double duration = 500; //millisec

  LightQuick() {
    images = [Loader().imgMap[AssetList.swordImg]!];
  }

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

class LightAir extends Ability {
  @override
  int power = 10;
  @override
  late List<ui.Image> images;
  @override
  double duration = 500; //millisec

  LightAir() {
    images = [Loader().imgMap[AssetList.swordImg]!];
  }

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

class LightStatic extends Ability {
  @override
  int power = 10;
  @override
  late List<ui.Image> images;
  @override
  double duration = 500; //millisec

  LightStatic() {
    images = [Loader().imgMap[AssetList.swordImg]!];
  }

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

class LightHorizontal extends Ability {
  @override
  int power = 10;
  @override
  late List<ui.Image> images;
  @override
  double duration = 500; //millisec

  LightHorizontal() {
    images = [Loader().imgMap[AssetList.swordImg]!];
  }

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

class LightFloor extends Ability {
  @override
  int power = 10;
  @override
  late List<ui.Image> images;
  @override
  double duration = 500; //millisec

  LightFloor() {
    images = [Loader().imgMap[AssetList.swordImg]!];
  }

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

  get images => null;

  get duration => null;

  Rect range(Rect characterHitBox, String facing);
}
