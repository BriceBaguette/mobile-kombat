import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:flutter_application_1/models/character.dart';

import 'CustomButtons.dart';
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
    var w = window.size.width;
    var h = window.size.height;

    // enforce aspect ratio RATIO for all body parts, while adapting to screen size
    // ignore: constant_identifier_names

    characters.add(
      StickMan(
          image: imgMap[AssetList.characterImg]!,
          bbox: Rect.fromLTWH(w / 2, h / 2, 64, 64),
          speed: 0.05,
          facing: 'RIGHT'),
    );
    buttons
      ..add(MovingButton(
          dir: 'LEFT',
          img: imgMap[AssetList.leftButtonImg]!,
          bbox: Rect.fromLTWH(20, h - 45, 60, 40)))
      ..add(MovingButton(
          dir: 'RIGHT',
          img: imgMap[AssetList.rightButtonImg]!,
          bbox: Rect.fromLTWH(110, h - 45, 60, 40)))
      ..add(JumpButton(
          img: imgMap[AssetList.jumpButtonImg]!,
          bbox: Rect.fromLTWH(20, h - 80, 40, 40)));

    grounds.add(Ground(
        bbox: Rect.fromLTWH(
            0, h / 2 + _stage!.characters[0].bbox.height, w, h / 10),
        groundImg: imgMap[AssetList.baseGround]!));
    _ready = true;
    _loading = false;
    _updateScreen();
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
