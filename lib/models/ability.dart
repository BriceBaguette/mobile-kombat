import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'loader.dart';

class LightDodge extends Ability {
  LightDodge() {
    power = 0;
    duration = 500; //millisec
    recoilDistance = 0;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class LightQuick extends Ability {
  LightQuick() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class LightAir extends Ability {
  LightAir() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class LightStatic extends Ability {
  LightStatic() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class LightHorizontal extends Ability {
  LightHorizontal() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class LightFloor extends Ability {
  LightFloor() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class HeavyDodge extends Ability {
  HeavyDodge() {
    power = 0;
    duration = 500; //millisec
    recoilDistance = 0;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class HeavyQuick extends Ability {
  HeavyQuick() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class HeavyAir extends Ability {
  HeavyAir() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class HeavyStatic extends Ability {
  HeavyStatic() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class HeavyHorizontal extends Ability {
  HeavyHorizontal() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

class HeavyFloor extends Ability {
  HeavyFloor() {
    power = 10;
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.swordImg]!];

    bboxHeightRatio = 1.0;
    bboxWidthRatio = 1.0;
  }
}

abstract class Ability {
  late int power;
  late double duration;
  late int recoilDistance;

  late List<ui.Image> images;

  late double bboxHeightRatio;
  late double bboxWidthRatio;

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
