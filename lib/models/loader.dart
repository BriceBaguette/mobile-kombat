import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

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

class Loader extends ChangeNotifier {
  static Loader? _loader;
  var imgMap = <AssetList, ui.Image>{};
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
    _loading = false;
    notifyListeners();
  }
}
