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
  swordImg
}

const _sceneAssets = {
  AssetList.characterImg: "assets/character.png",
  AssetList.rightButtonImg: "assets/rightArrow.png",
  AssetList.leftButtonImg: "assets/leftArrow.png",
  AssetList.baseGround: "assets/baseGround.png",
  AssetList.jumpButtonImg: "assets/jump.png",
  AssetList.swordImg: "assets/sword.png"
};

class Stage extends ChangeNotifier {
  static Stage? _stage;
  var characters = <Character>[];
  var buttons = <Button>[];
  var grounds = <Ground>[];
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
    var imgMap = <AssetList, ui.Image>{};
    for (var key in _sceneAssets.keys) {
      var img = await _loadImage(_sceneAssets[key]!);
      imgMap[key] = img;
    }

    var window = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    constants = Constant(w: window.size.width, h: window.size.height);
    displayTime = constants.time;
    characters.add(
      StickMan(
          image: imgMap[AssetList.characterImg]!,
          bbox: Rect.fromLTWH(constants.w / 2, constants.h / 2, 64, 64),
          speed: 3,
          facing: 'RIGHT',
          mainAbImage: imgMap[AssetList.swordImg]!),
    );
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
          bbox: constants.jumpButtonPosition));
    grounds.add(Ground(
        bbox: Rect.fromLTWH(
            0,
            constants.h / 2 + _stage!.characters[0].bbox.height,
            constants.w,
            constants.h / 10),
        groundImg: imgMap[AssetList.baseGround]!));
    _ready = true;
    _loading = false;
    _updateScreen();
    gameTimer =
        Timer.periodic(Duration(milliseconds: constants.framerate), (timer) {
      _stage!.updateGame();
    });
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
