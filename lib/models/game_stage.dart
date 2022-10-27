import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kombat/constant.dart';

import 'dart:ui' as ui;

import 'package:mobile_kombat/models/character.dart';

import 'custom_buttons.dart';
import 'ground.dart';

enum AssetList {
  characterImg,
  rightButtonImg,
  leftButtonImg,
  baseGround,
  jumpButtonImg,
  swordImg,
  attackImg,
  reversedCharacterImg
}

const _sceneAssets = {
  AssetList.characterImg: "./assets/images/goku.png",
  AssetList.rightButtonImg: "./assets/images/rightArrow.png",
  AssetList.leftButtonImg: "./assets/images/leftArrow.png",
  AssetList.baseGround: "./assets/images/baseGround.png",
  AssetList.jumpButtonImg: "./assets/images/jump.png",
  AssetList.swordImg: "./assets/images/sword.png",
  AssetList.attackImg: "./assets/images/attack.png",
};

class Stage extends ChangeNotifier {
  static Stage? _stage;
  var characters = <Character>[];
  var buttons = <Button>[];
  var grounds = <Ground>[];
  var imgMap = <AssetList, ui.Image>{};
  var _loading = true;
  var _ready = false;
  List<int> characterLife = [100, 100];
  late Timer gameTimer;
  late Constant constants;
  late int displayTime;
  bool gameOver = false;
  bool get ready => _ready && !_loading;

  factory Stage() {
    _stage ??= Stage._hidden();
    return _stage!;
  }

  Stage._hidden() {
    _loadImages();
  }

  void _updateScreen() {
    if (ready) {
      notifyListeners();
    }
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

    var window = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    constants = Constant(w: window.size.width, h: window.size.height);
    stageSetup(imgMap);
    _ready = true;
    _loading = false;
    _updateScreen();
    gameTimer =
        Timer.periodic(Duration(milliseconds: constants.framerate), (timer) {
      _stage!.updateGame();
    });
  }

  void stageSetup(imgMap) {
    displayTime = constants.time;
    characters
      ..add(StickMan(
          image: imgMap[AssetList.characterImg]!,
          bbox: Rect.fromLTWH(constants.w / 4, constants.h / 2,
              constants.w / 20, constants.w / 20 * constants.gokuRatio),
          speed: 3,
          facing: 'RIGHT',
          mainAbImage: imgMap[AssetList.swordImg]!))
      ..add(StickMan(
          image: imgMap[AssetList.characterImg]!,
          bbox: Rect.fromLTWH(constants.w - constants.w / 4, constants.h / 2,
              constants.w / 20, constants.w / 20 * constants.gokuRatio),
          speed: 3,
          facing: 'LEFT',
          mainAbImage: imgMap[AssetList.swordImg]!));
    buttons
      ..add(MovingButton(
          dir: 'LEFT',
          img: imgMap[AssetList.leftButtonImg]!,
          bbox: constants.leftButtonPosition))
      ..add(MovingButton(
          dir: 'RIGHT',
          img: imgMap[AssetList.rightButtonImg]!,
          bbox: constants.rightButtonPosition))
      ..add(JumpButton(
          img: imgMap[AssetList.jumpButtonImg]!,
          bbox: constants.jumpButtonPosition))
      ..add(AttackButton(
          img: imgMap[AssetList.attackImg]!,
          bbox: constants.attackButtonPosition));
    grounds.add(Ground(
        bbox: Rect.fromLTWH(
            0,
            constants.h / 2 + _stage!.characters[0].bbox.height,
            constants.w,
            constants.h / 10),
        groundImg: imgMap[AssetList.baseGround]!));
  }

  void reset() {
    gameOver = false;
    displayTime = constants.time;
    _loading = true;
    _loadImages();
  }

  void move(Character character, String dir, bool isMoving) {
    character.setDirection(dir);
    character.setMovement(isMoving);
  }

  void updateGame() {
    for (var character in _stage!.characters) {
      for (var other in _stage!.characters) {
        if (other != character &&
            other.usingAbility &&
            character.bbox.overlaps(other.abilityRange())) {
          character.getDamage(other.abilityDamage());
        }
      }
      character.update();
    }
    _updateTimer();
    if (displayTime <= 0) {
      characters.removeRange(0, characters.length);
      grounds.removeRange(0, grounds.length);
      buttons.removeRange(0, buttons.length);
      gameTimer.cancel();
      gameOver = true;
    }
    _updateScreen();
  }

  void _updateTimer() {
    displayTime -= constants.framerate;
  }

  Button? getButton(Offset pointerPos) {
    for (var button in buttons) {
      if (button.bbox.contains(pointerPos)) return button;
    }
    return null;
  }

  bool isGround(Offset charPosLeft, Offset charPosRight) {
    for (var ground in grounds) {
      if (ground.bbox.contains(charPosLeft) ||
          ground.bbox.contains(charPosRight)) return true;
    }
    return false;
  }

  void setReady(bool bool) {
    _ready = bool;
  }
}
