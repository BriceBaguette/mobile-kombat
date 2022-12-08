import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/player.dart';

enum AssetList {
  environmentImg,

  characterImg,
  jumpingImg,
  swordImg,
  baseGround,

  rightButtonImg,
  leftButtonImg,
  jumpButtonImg,
  floorButtonImg,

  quickAttackButtonImg,
  dodgeButtonImg,
  heavyAttackButtonImg,

  lightStatic_1,
  lightStatic_2,
  lightMoving_1,
  lightMoving_2,
  lightMoving_3,
  lightMoving_4,
  lightJumping_1,
  lightJumping_2,

  heavyStatic_1,
  heavyStatic_2,
  heavyMoving_1,
  heavyMoving_2,
  heavyMoving_3,
  heavyMoving_4,
  heavyJumping_1,
  heavyJumping_2,

  lightDodgeAbility_1,
  lightQuickAbility_1,
  lightStaticAbility_1,
  lightHorizontalAbility_1,
  lightHorizontalAbility_2,
  lightFloorAbility_1,
  lightAirAbility_1,

  heavyDodgeAbility_1,
  heavyQuickAbility_1,
  heavyStaticAbility_1,
  heavyStaticAbility_2,
  heavyHorizontalAbility_1,
  heavyFloorAbility_1,
  heavyAirAbility_1
}

const _sceneAssets = {
  AssetList.environmentImg: "./assets/images/environment.jpg",
  AssetList.characterImg: "./assets/images/goku.png",
  AssetList.jumpingImg: "./assets/images/jumping.png",
  AssetList.swordImg: "./assets/images/sword.png",
  AssetList.baseGround: "./assets/images/baseGround.png",
  AssetList.rightButtonImg: "./assets/images/buttons/rightArrow.png",
  AssetList.leftButtonImg: "./assets/images/buttons/leftArrow.png",
  AssetList.jumpButtonImg: "./assets/images/buttons/jump.png",
  AssetList.floorButtonImg: "./assets/images/buttons/arrowDown.png",
  AssetList.quickAttackButtonImg: "./assets/images/buttons/quickAttack.png",
  AssetList.dodgeButtonImg: "./assets/images/buttons/dodge.png",
  AssetList.heavyAttackButtonImg: "./assets/images/buttons/heavyAttack.png",
  AssetList.lightStatic_1: "./assets/images/light/light_static_1.png",
  AssetList.lightStatic_2: "./assets/images/light/light_static_1.png",
  AssetList.lightMoving_1: "./assets/images/light/light_moving_1.png",
  AssetList.lightMoving_2: "./assets/images/light/light_moving_2.png",
  AssetList.lightMoving_3: "./assets/images/light/light_moving_3.png",
  AssetList.lightMoving_4: "./assets/images/light/light_moving_4.png",
  AssetList.lightJumping_1: "./assets/images/light/light_static_1.png",
  AssetList.lightJumping_2: "./assets/images/light/light_static_1.png",
  AssetList.heavyStatic_1: "./assets/images/heavy/heavy_static_1.png",
  AssetList.heavyStatic_2: "./assets/images/heavy/heavy_static_2.png",
  AssetList.heavyMoving_1: "./assets/images/heavy/heavy_moving_1.png",
  AssetList.heavyMoving_2: "./assets/images/heavy/heavy_moving_2.png",
  AssetList.heavyMoving_3: "./assets/images/heavy/heavy_moving_3.png",
  AssetList.heavyMoving_4: "./assets/images/heavy/heavy_moving_4.png",
  AssetList.heavyJumping_1: "./assets/images/jumping.png",
  AssetList.heavyJumping_2: "./assets/images/jumping.png",
  AssetList.lightDodgeAbility_1: "./assets/images/abilities/light_dodge_1.png",
  AssetList.lightQuickAbility_1: "./assets/images/abilities/light_quick_1.png",
  AssetList.lightStaticAbility_1:
      "./assets/images/abilities/light_static_1.png",
  AssetList.lightHorizontalAbility_1:
      "./assets/images/abilities/light_horizontal_1.png",
  AssetList.lightHorizontalAbility_2:
      "./assets/images/abilities/light_horizontal_2.png",
  AssetList.lightFloorAbility_1: "./assets/images/abilities/light_static_1.png",
  AssetList.lightAirAbility_1: "./assets/images/abilities/light_static_1.png",
  AssetList.heavyDodgeAbility_1: "./assets/images/abilities/heavy_dodge_1.png",
  AssetList.heavyQuickAbility_1:
      "./assets/images/abilities/heavy_horizontal_1.png",
  AssetList.heavyStaticAbility_1:
      "./assets/images/abilities/heavy_static_1.png",
  AssetList.heavyStaticAbility_2:
      "./assets/images/abilities/heavy_static_2.png",
  AssetList.heavyHorizontalAbility_1:
      "./assets/images/abilities/heavy_horizontal_1.png",
  AssetList.heavyFloorAbility_1:
      "./assets/images/abilities/heavy_horizontal_1.png",
  AssetList.heavyAirAbility_1:
      "./assets/images/abilities/heavy_horizontal_1.png"
};

class Loader extends ChangeNotifier {
  final Constant _constant = Constant();
  static Loader? _loader;
  var imgMap = <AssetList, ui.Image>{};
  List<Character> characterList = [];
  var _loading = true;
  var _ready = false;
  bool gameOver = false;
  bool get ready => _ready && !_loading;

  factory Loader() {
    _loader ??= Loader._hidden();
    return _loader!;
  }

  Loader._hidden() {
    _loadImages();
  }

  Future<ui.Image> _loadImage(String path) async {
    var imgData = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(imgData.buffer.asUint8List());
    var imgf = await codec.getNextFrame();
    return imgf.image;
  }

  Future<void> _loadImages() async {
    _ready = true;
    for (var key in _sceneAssets.keys) {
      var img = await _loadImage(_sceneAssets[key]!);
      imgMap[key] = img;
    }
    characterList.add(Heavy(
        bbox: Rect.fromLTWH(
            _constant.leftCharacterLeft,
            _constant.leftCharacterTop,
            _constant.heavyWidth,
            _constant.heavyHeight),
        speed: 3,
        facing: 'RIGHT',
        framerate: _constant.framerate));
    Player().setCharacter(characterList[0]);
    _loading = false;
    notifyListeners();
  }
}
