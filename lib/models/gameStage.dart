import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:flutter_application_1/models/character.dart';

import 'CustomButtons.dart';

enum AssetList { characterImg, rightButtonImg, leftButtonImg }

const _sceneAssets = {
  AssetList.characterImg: "assets/character.png",
  AssetList.rightButtonImg: "assets/rightArrow.png",
  AssetList.leftButtonImg: "assets/leftArrow.png"
};

class Stage extends ChangeNotifier {
  static Stage? _stage;
  var characters = <Character>[];
  var buttons = <Button>[];
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
    var screenWidth = window.size.width;
    var screenHeight = window.size.height;
    var ratio = screenHeight / screenWidth;
    // enforce aspect ratio RATIO for all body parts, while adapting to screen size
    double h, w;
    // ignore: constant_identifier_names
    const RATIO = 2.058;
    if (ratio < RATIO) {
      // wider screen aspect
      h = screenHeight;
      w = h / RATIO;
    } else if (ratio > RATIO) {
      // longer screen aspect
      w = screenWidth;
      h = w * RATIO;
    } else {
      // same aspect ratio
      w = screenWidth;
      h = screenHeight;
    }
    characters.add(
      StickMan(
          image: imgMap[AssetList.characterImg]!,
          bbox: Rect.fromLTWH(h / 2, w / 2, 64, 64),
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
          bbox: Rect.fromLTWH(110, h - 45, 60, 40)));
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
      character.move();
    }
    notifyListeners();
  }

  Button? getButton(Offset pointerPos) {
    for (var button in buttons) {
      if (button.bbox.contains(pointerPos)) return button;
    }
    return null;
  }
}
