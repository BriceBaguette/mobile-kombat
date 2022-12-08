import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/cosmetics.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/player.dart';

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
  reversedCharacterImg,
  character2Img,
  hatImg,
  swimwearImg,
  hawaiianshirtImg
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
  AssetList.character2Img: "assets/images/GenericGuy.png",
  AssetList.hatImg:"assets/images/ClassyHat.png",
  AssetList.swimwearImg:"assets/images/swimwear.png",
  AssetList.hawaiianshirtImg:"assets/images/hawaiian-shirt.png",
};

class Loader extends ChangeNotifier {
  final Constant _constant = Constant();
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

  List<Character> characterList = [];
  List<Cosmetics> cosmeticList = [];

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
    characterList.add(StickMan2(
        bbox: Rect.fromLTWH(Constant().w - Constant().w / 4, Constant().h / 2,
            Constant().w / 20, Constant().w / 20 * Constant().gokuRatio),
        speed: 3,
        facing: 'LEFT',
        framerate: Constant().framerate));
    characterList.add(StickMan(
        bbox: Rect.fromLTWH(_constant.w / 4, _constant.h / 2, _constant.w / 20,
            _constant.w / 20 * _constant.gokuRatio),
        speed: 3,
        facing: 'RIGHT',
        framerate: _constant.framerate));
    Player().setCharacter(characterList[0]);
    cosmeticList.add(Cosmetics(
        key: const ObjectKey('test1'),
        'test1',
        const [1, 0, -1, 0],
        'assets/images/ClassyHat.png',
        "H",
        "gen",
        100,
        imgMap[AssetList.hatImg]!,
        0
    ),);
    cosmeticList.add(Cosmetics(
        key: const ObjectKey('test2'),
        'test2',
        const [0, 0, -1, 0],
        'assets/images/GenericGuy.png',
        "H",
        "gen",
        100,
        Loader().imgMap[AssetList.character2Img]!,
        1
    ),);
    cosmeticList.add(Cosmetics(
        key: const ObjectKey('test3'),
        'test3',
        const [2, 0, 0, 0],
        'assets/images/hawaiian-shirt.png',
        "B",
        "gen",
        100,
        Loader().imgMap[AssetList.hawaiianshirtImg]!,
        2
    ),);
    cosmeticList.add(Cosmetics(
        key: const ObjectKey('test4'),
        'test4',
        const [1, 1, -2, 0],
        'assets/images/swimwear.png',
        "F",
        "gen",
        100,
        Loader().imgMap[AssetList.swimwearImg]!,
        3
    ));

    _loading = false;
    notifyListeners();
  }
}
