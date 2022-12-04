import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

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

  heavyStatic_1,
  heavyStatic_2
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
  AssetList.heavyStatic_1: "./assets/images/heavy/heavy_static_1.png",
  AssetList.heavyStatic_2: "./assets/images/heavy/heavy_static_2.png"
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
