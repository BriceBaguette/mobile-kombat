import 'package:flutter/cupertino.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'dart:ui' as ui;

import 'loader.dart';

class LightDodge extends Ability {
  LightDodge() {
    duration = 500; //millisec
    recoilDistance = 0;

    images = [Loader().imgMap[AssetList.lightDodgeAbility_1]!];
    powerPerImage = [0];

    imageBoxHeightRatio = 965 / Constant().lightDefaultHeight;
    imageBoxWidthRatio = 345 / Constant().lightDefaultWidth;

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
  }
}

class LightQuick extends Ability {
  LightQuick() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.lightQuickAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 798 / Constant().lightDefaultHeight;
    imageBoxWidthRatio = 980 / Constant().lightDefaultWidth;

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
  }
}

class LightAir extends Ability {
  LightAir() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [
      Loader().imgMap[AssetList.lightAirAbility_1]!,
      Loader().imgMap[AssetList.lightAirAbility_2]!,
      Loader().imgMap[AssetList.lightAirAbility_3]!,
      Loader().imgMap[AssetList.lightAirAbility_4]!
    ];
    powerPerImage = [0, 10, 0, 0];

    imageBoxHeightRatio = 1330 / Constant().lightDefaultHeight;
    imageBoxWidthRatio = 1655 / Constant().lightDefaultWidth;

    hitBoxLeftOffsetRatio = [0, 330 / 1655, 850 / 1635, 1100 / 1635];
    hitBoxTopOffsetRatio = [0, 125 / 1330, 230 / 1330, 650 / 1330];
  }
}

class LightStatic extends Ability {
  LightStatic() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.lightStaticAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 1080 / Constant().lightDefaultHeight;
    imageBoxWidthRatio = 1080 / Constant().lightDefaultWidth;

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
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

    imageBoxHeightRatio = 682 / Constant().lightDefaultHeight;
    imageBoxWidthRatio = 1082 / Constant().lightDefaultWidth;

    hitBoxLeftOffsetRatio = [
      110 / Constant().lightDefaultWidth,
      375 / Constant().lightDefaultWidth
    ];
    hitBoxTopOffsetRatio = [0, 150 / Constant().lightDefaultHeight];
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

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
  }
}

class HeavyDodge extends Ability {
  HeavyDodge() {
    duration = 500; //millisec
    recoilDistance = 0;

    images = [Loader().imgMap[AssetList.heavyDodgeAbility_1]!];
    powerPerImage = [0];

    imageBoxHeightRatio = 729 / Constant().heavyDefaultHeight;
    imageBoxWidthRatio = 384 / Constant().heavyDefaultWidth;

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
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

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
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

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
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

    imageBoxHeightRatio = 766 / Constant().heavyDefaultHeight;
    imageBoxWidthRatio = 1058 / Constant().heavyDefaultWidth;

    hitBoxLeftOffsetRatio = [100 / 1058, 130 / 1058];
    hitBoxTopOffsetRatio = [40 / 766, 90 / 766];
  }
}

class HeavyHorizontal extends Ability {
  HeavyHorizontal() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.heavyHorizontalAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 709 / Constant().heavyDefaultHeight;
    imageBoxWidthRatio = 1080 / Constant().heavyDefaultWidth;

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
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

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
  }
}

abstract class Ability {
  late List<int> powerPerImage;
  late double duration;
  late int recoilDistance;

  late List<ui.Image> images;

  late double imageBoxHeightRatio;
  late double imageBoxWidthRatio;

  late List<double> hitBoxLeftOffsetRatio;
  late List<double> hitBoxTopOffsetRatio;

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
