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

  @override
  Rect range(int index, Rect characterHitBox, String facing) => noHitBox;
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

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
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
    hitBoxTopOffsetRatio = [530 / 1330, 125 / 1330, 230 / 1330, 650 / 1330];
  }

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
    if (index == 1) {
      var left = characterHitBox.left + (600 / 1655 * characterHitBox.width);
      var top = characterHitBox.top;
      var width = 550 / 1655 * characterHitBox.width;
      var height = 600 / 1330 * characterHitBox.height;

      if (facing == 'LEFT') {
        left = characterHitBox.right -
            (600 / 1655 * characterHitBox.width) -
            width;
      }

      return Rect.fromLTWH(left, top, width, height);
    }

    return noHitBox;
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

    hitBoxLeftOffsetRatio = [75 / 1080];
    hitBoxTopOffsetRatio = [200 / 1080];
  }

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
    if (index == 0) {
      var left = characterHitBox.left + (500 / 1080 * characterHitBox.width);
      var top = characterHitBox.top + (500 / 1080 * characterHitBox.height);
      var width = 600 / 1080 * characterHitBox.width;
      var height = 500 / 1080 * characterHitBox.height;

      if (facing == 'LEFT') {
        left = characterHitBox.right -
            (500 / 1080 * characterHitBox.width) -
            width;
      }

      return Rect.fromLTWH(left, top, width, height);
    }

    return noHitBox;
  }
}

class LightHorizontal extends Ability {
  LightHorizontal() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.lightHorizontalAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 798 / Constant().lightDefaultHeight;
    imageBoxWidthRatio = 980 / Constant().lightDefaultWidth;

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
  }

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
    if (index == 0) {
      var left = characterHitBox.left + (600 / 980 * characterHitBox.width);
      var top = characterHitBox.top + (100 / 798 * characterHitBox.height);
      var width = 400 / 980 * characterHitBox.width;
      var height = 250 / 798 * characterHitBox.height;

      if (facing == 'LEFT') {
        left =
            characterHitBox.right - (600 / 980 * characterHitBox.width) - width;
      }

      return Rect.fromLTWH(left, top, width, height);
    }

    return noHitBox;
  }
}

class LightFloor extends Ability {
  LightFloor() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [
      Loader().imgMap[AssetList.lightFloorAbility_1]!,
      Loader().imgMap[AssetList.lightFloorAbility_2]!
    ];
    powerPerImage = [0, 10];

    imageBoxHeightRatio = 682 / Constant().lightDefaultHeight;
    imageBoxWidthRatio = 1082 / Constant().lightDefaultWidth;

    hitBoxLeftOffsetRatio = [110 / 1082, 375 / 1082];
    hitBoxTopOffsetRatio = [0, 150 / 682];
  }

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
    if (index == 1) {
      var left = characterHitBox.left + (600 / 1082 * characterHitBox.width);
      var top = characterHitBox.top + (90 / 682 * characterHitBox.height);
      var width = 500 / 1082 * characterHitBox.width;
      var height = (1 - (90 / 682)) * characterHitBox.height;

      if (facing == 'LEFT') {
        left = characterHitBox.right -
            (600 / 1082 * characterHitBox.width) -
            width;
      }

      return Rect.fromLTWH(left, top, width, height);
    }

    return noHitBox;
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

  @override
  Rect range(int index, Rect characterHitBox, String facing) => noHitBox;
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

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
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

class HeavyAir extends Ability {
  HeavyAir() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [
      Loader().imgMap[AssetList.heavyAirAbility_1]!,
      Loader().imgMap[AssetList.heavyAirAbility_2]!
    ];
    powerPerImage = [0, 10];

    imageBoxHeightRatio = 898 / Constant().heavyDefaultHeight;
    imageBoxWidthRatio = 1090 / Constant().heavyDefaultWidth;

    hitBoxLeftOffsetRatio = [0, 180 / 1090];
    hitBoxTopOffsetRatio = [225 / 898, 225 / 898];
  }

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
    if (index == 1) {
      var left = characterHitBox.left + (900 / 1090 * characterHitBox.width);
      var top = characterHitBox.top + (250 / 898 * characterHitBox.height);
      var width = 200 / 1090 * characterHitBox.width;
      var height = 500 / 898 * characterHitBox.height;

      if (facing == 'LEFT') {
        left = characterHitBox.right -
            (900 / 1090 * characterHitBox.width) -
            width;
      }

      return Rect.fromLTWH(left, top, width, height);
    }

    return noHitBox;
  }
}

class HeavyStatic extends Ability {
  HeavyStatic() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [Loader().imgMap[AssetList.heavyStaticAbility_1]!];
    powerPerImage = [10];

    imageBoxHeightRatio = 723 / Constant().heavyDefaultHeight;
    imageBoxWidthRatio = 553 / Constant().heavyDefaultWidth;

    hitBoxLeftOffsetRatio = [0];
    hitBoxTopOffsetRatio = [0];
  }

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
    if (index == 1) {
      var left = characterHitBox.left + (400 / 553 * characterHitBox.width);
      var top = characterHitBox.top + (125 / 723 * characterHitBox.height);
      var width = 250 / 553 * characterHitBox.width;
      var height = 400 / 723 * characterHitBox.height;

      if (facing == 'LEFT') {
        left =
            characterHitBox.right - (400 / 553 * characterHitBox.width) - width;
      }

      return Rect.fromLTWH(left, top, width, height);
    }

    return noHitBox;
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

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
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

class HeavyFloor extends Ability {
  HeavyFloor() {
    duration = 500; //millisec
    recoilDistance = 40;

    images = [
      Loader().imgMap[AssetList.heavyFloorAbility_1]!,
      Loader().imgMap[AssetList.heavyFloorAbility_2]!
    ];
    powerPerImage = [0, 10];

    imageBoxHeightRatio = 766 / Constant().heavyDefaultHeight;
    imageBoxWidthRatio = 1058 / Constant().heavyDefaultWidth;

    hitBoxLeftOffsetRatio = [100 / 1058, 130 / 1058];
    hitBoxTopOffsetRatio = [40 / 766, 90 / 766];
  }

  @override
  Rect range(int index, Rect characterHitBox, String facing) {
    if (index == 1) {
      var left = characterHitBox.left + (750 / 1058 * characterHitBox.width);
      var top = characterHitBox.top + (200 / 766 * characterHitBox.height);
      var width = 300 / 1058 * characterHitBox.width;
      var height = (1 - 200 / 766) * characterHitBox.height;

      if (facing == 'LEFT') {
        left = characterHitBox.right -
            (750 / 1058 * characterHitBox.width) -
            width;
      }

      return Rect.fromLTWH(left, top, width, height);
    }

    return noHitBox;
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

  Rect noHitBox = Rect.fromLTWH(Constant().w * 2, Constant().h * 2, 0, 0);

  Rect range(int index, Rect characterHitBox, String facing);
}
