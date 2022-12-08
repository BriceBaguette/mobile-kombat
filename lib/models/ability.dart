import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'loader.dart';

class LightDodge extends Ability {
  LightDodge() {
    duration = 500; //millisec
    recoilDistance = 0;

    images = [Loader().imgMap[AssetList.lightDodgeAbility_1]!];
    powerPerImage = [0];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class LightQuick extends Ability {
  LightQuick() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.lightQuickAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class LightAir extends Ability {
  LightAir() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.lightAirAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class LightStatic extends Ability {
  LightStatic() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.lightStaticAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class LightHorizontal extends Ability {
  LightHorizontal() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [
      Loader().imgMap[AssetList.lightHorizontalAbility_1]!,
      Loader().imgMap[AssetList.lightHorizontalAbility_2]!
    ];
    powerPerImage = [0, 10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0, 0];
    hitBoxTopOffset = [0, 0];
  }
}

class LightFloor extends Ability {
  LightFloor() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.lightFloorAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class HeavyDodge extends Ability {
  HeavyDodge() {
    duration = 500; //millisec
    recoilDistance = 0;

    images = [Loader().imgMap[AssetList.heavyDodgeAbility_1]!];
    powerPerImage = [0];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class HeavyQuick extends Ability {
  HeavyQuick() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.heavyQuickAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class HeavyAir extends Ability {
  HeavyAir() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.heavyAirAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class HeavyStatic extends Ability {
  HeavyStatic() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [
      Loader().imgMap[AssetList.heavyStaticAbility_1]!,
      Loader().imgMap[AssetList.heavyStaticAbility_2]!
    ];
    powerPerImage = [0, 10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0, 0];
    hitBoxTopOffset = [0, 0];
  }
}

class HeavyHorizontal extends Ability {
  HeavyHorizontal() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.heavyHorizontalAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

class HeavyFloor extends Ability {
  HeavyFloor() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.heavyFloorAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1.0;
    imageBoxWidthRatio = 1.0;

    hitBoxLeftOffset = [0];
    hitBoxTopOffset = [0];
  }
}

abstract class Ability {
  late List<int> powerPerImage;
  late double duration;
  late int recoilDistance;

  late List<ui.Image> images;

  late double imageBoxHeightRatio;
  late double imageBoxWidthRatio;

  late List<double> hitBoxLeftOffset;
  late List<double> hitBoxTopOffset;

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
