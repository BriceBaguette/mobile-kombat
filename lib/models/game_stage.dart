import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/constant.dart';

import 'dart:ui' as ui;

import 'package:flutter_application_1/models/character.dart';

import 'custom_buttons.dart';
import 'ground.dart';

enum AssetList {
  characterImg,
  rightButtonImg,
  leftButtonImg,
  baseGround,
  jumpButtonImg
}

const _sceneAssets = {
  AssetList.characterImg: "assets/character.png",
  AssetList.rightButtonImg: "assets/rightArrow.png",
  AssetList.leftButtonImg: "assets/leftArrow.png",
  AssetList.baseGround: "assets/baseGround.png",
  AssetList.jumpButtonImg: "assets/jump.png"
};

class Stage extends ChangeNotifier {
  static Stage? _stage;
  var characters = <Character>[];
  var buttons = <Button>[];
  var grounds = <Ground>[];
  var _loading = true;
  var _ready = false;
  late Timer gameTimer;
  late Constant constants;
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
    // enforce aspect ratio RATIO for all body parts, while adapting to screen size
    // ignore: constant_identifier_names

    characters.add(
      StickMan(
          image: imgMap[AssetList.characterImg]!,
          bbox: Rect.fromLTWH(constants.w / 2, constants.h / 2, 64, 64),
          speed: 3,
          facing: 'RIGHT'),
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
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _stage!.updateGame();
    });
  }

  void move(Character character, String dir, bool isMoving) {
    character.setDirection(dir);
    character.setMovement(isMoving);
  }

  void updateGame() {
    for (var character in _stage!.characters) {
      character.update();
    }
    _updateScreen();
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
}
