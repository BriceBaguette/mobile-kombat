import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';

enum AssetList {
  characterImg,
  rightButtonImg,
  leftButtonImg,
  baseGround,
  jumpButtonImg,
  floorButtonImg,
  swordImg,
  quickAttackImg,
  dodgeImg,
  heavyAttackImg,
  reversedCharacterImg
}

const _sceneAssets = {
  AssetList.characterImg: "./assets/images/goku.png",
  AssetList.rightButtonImg: "./assets/images/rightArrow.png",
  AssetList.leftButtonImg: "./assets/images/leftArrow.png",
  AssetList.baseGround: "./assets/images/baseGround.png",
  AssetList.jumpButtonImg: "./assets/images/jump.png",
  AssetList.floorButtonImg: "./assets/images/arrowDown.png",
  AssetList.swordImg: "./assets/images/sword.png",
  AssetList.quickAttackImg: "./assets/images/quickAttack.png",
  AssetList.dodgeImg: "./assets/images/dodge.png",
  AssetList.heavyAttackImg: "./assets/images/heavyAttack.png",
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
    characterList.add(StickMan(
        bbox: Rect.fromLTWH(_constant.w / 4, _constant.h / 2, _constant.w / 20,
            _constant.w / 20 * _constant.gokuRatio),
        speed: 3,
        facing: 'RIGHT',
        framerate: _constant.framerate));
    _loading = false;
    notifyListeners();
  }
}
