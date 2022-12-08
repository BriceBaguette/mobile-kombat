import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/ability.dart';
import 'constant.dart';
import 'cosmetics.dart';
import 'loader.dart';

abstract class Character {
  get health => null;

  get id => null;

  get speed => null;

  get facing => null;

  get reversedImage => null;

  get image => null;

  get bbox => null;

  get hatBbox => null;

  get bodyBbox => null;

  get footBbox => null;

  get upSpeed => null;

  get usingAbility => null;

  bool isMoving = false;

  bool isFloor = false;

  late Ability _quickAttack;

  late Ability _airAttack;

  late Ability _staticAttack;

  late Ability _horizontalAttack;

  late Ability _floorAttack;

  late Ability _dodge;

  int getPrice();
  int getStrength();
  int getAS();
  int getResistance();
  double getSpeed();
  String getImageDir();
  String getName();

  void setStrength(int mod);
  void setAS(int mod);
  void setResistance(int mod);
  void setSpeed(int mod);
  void resetBbox();

  bool isGrounded();
  bool isBlocked();
  bool isAbove();
  void update();
  void setMovement(bool move);
  void setDirection(String direction);
  void setJumpSpeed(double value);
  void move();
  ui.Image abilityImage();
  Rect abilityRange();
  int abilityDamage();
  void getDamage(int damage);
  void attack({bool quick = false, bool dodge = false});


  Ability determineAttack(bool quick, bool dodge) {
    if (dodge) {
      return _dodge;
    }
    if (quick) {
      return _quickAttack;
    }
    if (!isGrounded()) {
      return _airAttack;
    }
    if (isFloor) {
      return _floorAttack;
    }
    if (isMoving) {
      return _horizontalAttack;
    }
    return _staticAttack;
  }

  Map<String, Cosmetics> equippedCosmetics = {};
  void equipCosmetic(Cosmetics c){
    String bp = c.getBodyPart();
    equippedCosmetics[bp] = c;
  }
  void removeCosmetic(String s){
    equippedCosmetics.remove(s);
  }

  List<int> allocateFramesToImages(
      int imageNb, double duration, double framerate) {
    double framesPerImage = framerate * duration / imageNb.toDouble();
    List<int> framesList = <int>[];
    for (; imageNb > 0; imageNb--) {
      framesList.add(framesPerImage.round());
    }
    return framesList;
  }
}

class StickMan extends Character {
  @override
  StickMan({
    required this.bbox,
    required this.speed,
    required this.facing,
    required this.framerate,
  }) {
    image = Loader().imgMap[AssetList.characterImg]!;
    _dodge = LightDodge();
    _quickAttack = LightQuick();
    _airAttack = LightAir();
    _staticAttack = LightStatic();
    _horizontalAttack = LightHorizontal();
    _floorAttack = LightFloor();
  }

  late int framerate;
  @override
  int health = 100;
  @override
  int id = 0;
  @override
  late ui.Image image;
  @override
  Rect bbox;
  @override
  double speed = 5;
  @override
  String facing;
  @override
  double upSpeed = 0;
  @override
  bool usingAbility = false;
  late Ability abilityInProgress;
  late List<ui.Image> abilityImages;
  late int abilityFramesPerImage;
  int abilityImagesOffset = 0;
  late int abilityImageFramesOffset = 0;

  final Constant constant = Constant();

  @override
  Rect hatBbox = (Rect.fromLTWH((Constant().w / 4)+6, (Constant().h / 2), Constant().w / 30,
      Constant().w / 60 * Constant().gokuRatio));
  @override
  Rect bodyBbox = (Rect.fromLTWH((Constant().w / 4)+6, (Constant().h / 2)+25, Constant().w / 30,
      Constant().w / 60 * Constant().gokuRatio));
  @override
  Rect footBbox = (Rect.fromLTWH((Constant().w / 4)+6, (Constant().h / 2)+35, Constant().w / 30,
      Constant().w / 60 * Constant().gokuRatio));


  int price = 1;
  int strength = 0;
  int aS = 0;
  int resistance = 0;
  String imageDir = "assets/images/goku.png";
  String name = "Stickman";

  @override
  String getImageDir() {
    return imageDir;
  }

  @override
  int getPrice() {
    return price;
  }

  @override
  int getStrength() {
    return strength;
  }

  @override
  int getAS() {
    return aS;
  }

  @override
  int getResistance() {
    return resistance;
  }

  @override
  double getSpeed() {
    return speed;
  }

  @override
  String getName() {
    return name;
  }

  @override
  void setStrength(int mod) {
    strength = strength + mod;
  }

  @override
  void setAS(int mod) {
    aS = aS + mod;
  }

  @override
  void setResistance(int mod) {
    resistance = resistance + mod;
  }

  @override
  void setSpeed(int mod) {
    speed = speed + mod;
  }

  @override
  void setDirection(String direction) {
    facing = direction;
  }

  @override
  void setMovement(bool move) {
    isMoving = move;
  }

  @override
  void move() {
    if (isGrounded() & (upSpeed >= 0)) {
      setJumpSpeed(0);
    } else {
      setJumpSpeed(upSpeed + 0.1);
    }
    bbox =
        Rect.fromLTWH(bbox.left, bbox.top + upSpeed, bbox.width, bbox.height);
    hatBbox = Rect.fromLTWH(hatBbox.left, hatBbox.top + upSpeed, hatBbox.width, hatBbox.height);
    bodyBbox = Rect.fromLTWH(bodyBbox.left, bodyBbox.top + upSpeed, bodyBbox.width, bodyBbox.height);
    footBbox = Rect.fromLTWH(footBbox.left, footBbox.top + upSpeed, footBbox.width, footBbox.height);
    if (isMoving && !isBlocked()) {
      switch (facing) {
        case 'RIGHT':
          bbox = Rect.fromLTWH(
              bbox.left + speed, bbox.top, bbox.width, bbox.height);
          hatBbox = Rect.fromLTWH(
              hatBbox.left + speed, hatBbox.top, hatBbox.width, hatBbox.height);
          bodyBbox = Rect.fromLTWH(
              bodyBbox.left + speed, bodyBbox.top, bodyBbox.width, bodyBbox.height);
          footBbox = Rect.fromLTWH(
              footBbox.left + speed, footBbox.top, footBbox.width, footBbox.height);
          break;
        case 'LEFT':
          bbox = Rect.fromLTWH(
              bbox.left - speed, bbox.top, bbox.width, bbox.height);
          hatBbox = Rect.fromLTWH(
              hatBbox.left - speed, hatBbox.top, hatBbox.width, hatBbox.height);
          bodyBbox = Rect.fromLTWH(
              bodyBbox.left - speed, bodyBbox.top, bodyBbox.width, bodyBbox.height);
          footBbox = Rect.fromLTWH(
              footBbox.left - speed, footBbox.top, footBbox.width, footBbox.height);
          break;
        default:
          return;
      }
    }
    if (usingAbility) {
      if (abilityImageFramesOffset < abilityFramesPerImage) {
        abilityImageFramesOffset++;
      } else {
        abilityImageFramesOffset = 0;
        abilityImagesOffset++;
        if (abilityImagesOffset == abilityImages.length) {
          usingAbility = false;
          abilityImagesOffset = 0;
        }
      }
    }
    return;
  }

  @override
  void update() {
    move();
  }

  @override
  void setJumpSpeed(double value) {
    upSpeed = value;
  }

  @override
  bool isGrounded() {
    return (Stage().isGround(Offset(bbox.right, bbox.bottom + upSpeed),
        Offset(bbox.left, bbox.bottom + upSpeed)) ||
        isAbove());
  }

  @override
  bool isBlocked() {
    bool isBlocked = false;
    for (var others in Stage().characters) {
      if (others != this) {
        switch (facing) {
          case 'LEFT':
            isBlocked = others.bbox
                .contains(Offset(bbox.left - speed, bbox.bottom - 1));
            break;
          case 'RIGHT':
            isBlocked = others.bbox
                .contains(Offset(bbox.right + speed, bbox.bottom - 1));
            break;
          default:
            break;
        }
      }
    }
    if ((bbox.left - speed <= 0 && facing == 'LEFT') ||
        (bbox.right + speed >= Constant().w && facing == 'RIGHT')) {
      isBlocked = true;
    }

    return isBlocked;
  }

  @override
  ui.Image abilityImage() => abilityImages[abilityImagesOffset];

  @override
  Rect abilityRange() => abilityInProgress.range(bbox, facing);

  @override
  int abilityDamage() => abilityInProgress.power;

  @override
  void getDamage(int damage) => health -= damage;

  @override
  void attack({bool quick = false, bool dodge = false}) {
    if (!usingAbility) {
      usingAbility = true;
      abilityInProgress = determineAttack(quick, dodge);
      abilityImages = abilityInProgress.images;
      abilityFramesPerImage = (abilityInProgress.duration /
          (framerate.toDouble() * abilityImages.length.toDouble()))
          .round();
    }
  }

  @override
  bool isAbove() {
    bool isAbove = false;
    for (var others in Stage().characters) {
      if (others != this) {
        isAbove =
            others.bbox.contains(Offset(bbox.left, bbox.bottom + upSpeed)) ||
                others.bbox.contains(Offset(bbox.right, bbox.bottom + upSpeed));
      }
    }
    return isAbove;
  }

  final Constant _constant = Constant();
  @override
  void resetBbox(){
    setJumpSpeed(0);
    setMovement(false);
    bbox = (Rect.fromLTWH(_constant.w / 4, _constant.h / 2, _constant.w / 20,
        _constant.w / 20 * _constant.gokuRatio));
  }
}

class StickMan2 extends Character {
  @override
  StickMan2({
    required this.bbox,
    required this.speed,
    required this.facing,
    required this.framerate,
  }) {
    image = Loader().imgMap[AssetList.character2Img]!;
    _dodge = LightDodge();
    _quickAttack = LightQuick();
    _airAttack = LightAir();
    _staticAttack = LightStatic();
    _horizontalAttack = LightHorizontal();
    _floorAttack = LightFloor();
  }

  late int framerate;
  @override
  int health = 100;
  @override
  int id = 1;
  @override
  late ui.Image image;
  @override
  Rect bbox;
  @override
  double speed = 5;
  @override
  String facing;
  double upSpeed = 0;
  @override
  bool usingAbility = false;
  late Ability abilityInProgress;
  late List<ui.Image> abilityImages;
  late int abilityFramesPerImage;
  int abilityImagesOffset = 0;
  late int abilityImageFramesOffset = 0;

  final Constant constant = Constant();

  @override
  Rect hatBbox = (Rect.fromLTWH((Constant().w / 4)+6, (Constant().h / 2)-14, Constant().w / 30,
      Constant().w / 60 * Constant().gokuRatio));
  @override
  Rect bodyBbox = (Rect.fromLTWH((Constant().w / 4)+5, (Constant().h / 2)+15, Constant().w / 30,
      Constant().w / 60 * Constant().gokuRatio));
  @override
  Rect footBbox = (Rect.fromLTWH((Constant().w / 4)+5, (Constant().h / 2)+35, Constant().w / 30,
      Constant().w / 60 * Constant().gokuRatio));

  int price = 1;
  int strength = 0;
  int aS = 0;
  int resistance = 0;
  String imageDir = "assets/images/GenericGuy.png";
  String name = "Stickman2";



  @override
  String getImageDir() {
    return imageDir;
  }

  @override
  int getPrice() {
    return price;
  }

  @override
  int getStrength() {
    return strength;
  }

  @override
  int getAS() {
    return aS;
  }

  @override
  int getResistance() {
    return resistance;
  }

  @override
  double getSpeed() {
    return speed;
  }

  @override
  String getName() {
    return name;
  }

  @override
  void setStrength(int mod) {
    strength = strength + mod;
  }

  @override
  void setAS(int mod) {
    aS = aS + mod;
  }

  @override
  void setResistance(int mod) {
    resistance = resistance + mod;
  }

  @override
  void setSpeed(int mod) {
    speed = speed + mod;
  }

  @override
  void setDirection(String direction) {
    facing = direction;
  }

  @override
  void setMovement(bool move) {
    isMoving = move;
  }

  @override
  void move() {
    if (isGrounded() & (upSpeed >= 0)) {
      setJumpSpeed(0);
    } else {
      setJumpSpeed(upSpeed + 0.1);
    }
    bbox =
        Rect.fromLTWH(bbox.left, bbox.top + upSpeed, bbox.width, bbox.height);
    hatBbox = Rect.fromLTWH(hatBbox.left, hatBbox.top + upSpeed, hatBbox.width, hatBbox.height);
    bodyBbox = Rect.fromLTWH(bodyBbox.left, bodyBbox.top + upSpeed, bodyBbox.width, bodyBbox.height);
    footBbox = Rect.fromLTWH(footBbox.left, footBbox.top + upSpeed, footBbox.width, footBbox.height);
    if (isMoving && !isBlocked()) {
      switch (facing) {
        case 'RIGHT':
          bbox = Rect.fromLTWH(
              bbox.left + speed, bbox.top, bbox.width, bbox.height);
          hatBbox = Rect.fromLTWH(
              hatBbox.left + speed, hatBbox.top, hatBbox.width, hatBbox.height);
          bodyBbox = Rect.fromLTWH(
              bodyBbox.left + speed, bodyBbox.top, bodyBbox.width, bodyBbox.height);
          footBbox = Rect.fromLTWH(
              footBbox.left + speed, footBbox.top, footBbox.width, footBbox.height);
          break;
        case 'LEFT':
          bbox = Rect.fromLTWH(
              bbox.left - speed, bbox.top, bbox.width, bbox.height);
          hatBbox = Rect.fromLTWH(
              hatBbox.left - speed, hatBbox.top, hatBbox.width, hatBbox.height);
          bodyBbox = Rect.fromLTWH(
              bodyBbox.left - speed, bodyBbox.top, bodyBbox.width, bodyBbox.height);
          footBbox = Rect.fromLTWH(
              footBbox.left - speed, footBbox.top, footBbox.width, footBbox.height);
          break;
        default:
          return;
      }
    }
    if (usingAbility) {
      if (abilityImageFramesOffset < abilityFramesPerImage) {
        abilityImageFramesOffset++;
      } else {
        abilityImageFramesOffset = 0;
        abilityImagesOffset++;
        if (abilityImagesOffset == abilityImages.length) {
          usingAbility = false;
          abilityImagesOffset = 0;
        }
      }
    }
    return;
  }

  @override
  void update() {
    move();
  }

  @override
  void setJumpSpeed(double value) {
    upSpeed = value;
  }

  @override
  bool isGrounded() {
    return (Stage().isGround(Offset(bbox.right, bbox.bottom + upSpeed),
            Offset(bbox.left, bbox.bottom + upSpeed)) ||
        isAbove());
  }

  @override
  bool isBlocked() {
    bool isBlocked = false;
    for (var others in Stage().characters) {
      if (others != this) {
        switch (facing) {
          case 'LEFT':
            isBlocked = others.bbox
                .contains(Offset(bbox.left - speed, bbox.bottom - 1));
            break;
          case 'RIGHT':
            isBlocked = others.bbox
                .contains(Offset(bbox.right + speed, bbox.bottom - 1));
            break;
          default:
            return false;
        }
      }
    }
    return isBlocked;
  }

  @override
  ui.Image abilityImage() => abilityImages[abilityImagesOffset];

  @override
  Rect abilityRange() => abilityInProgress.range(bbox, facing);

  @override
  int abilityDamage() => abilityInProgress.power;

  @override
  void getDamage(int damage) => health -= damage;

  @override
  void attack({bool quick = false, bool dodge = false}) {
    if (!usingAbility) {
      usingAbility = true;
      abilityInProgress = determineAttack(quick, dodge);
      abilityImages = abilityInProgress.images;
      abilityFramesPerImage = (abilityInProgress.duration /
              (framerate.toDouble() * abilityImages.length.toDouble()))
          .round();
    }
  }

  @override
  bool isAbove() {
    bool isAbove = false;
    for (var others in Stage().characters) {
      if (others != this) {
        isAbove =
            others.bbox.contains(Offset(bbox.left, bbox.bottom + upSpeed)) ||
                others.bbox.contains(Offset(bbox.right, bbox.bottom + upSpeed));
      }
    }
    return isAbove;
  }

  final Constant _constant = Constant();
  @override
  void resetBbox(){
    setJumpSpeed(0);
    setMovement(false);
    bbox = (Rect.fromLTWH(_constant.w / 4, _constant.h / 2, _constant.w / 20,
        _constant.w / 20 * _constant.gokuRatio));
  }
}

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.c});
  final Character c;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(c.getImageDir(), width: 70),
        Text(c.getName()),
        const SizedBox(width: 20)
      ],
    );
  }
}

class PopUpChar extends StatelessWidget {
  const PopUpChar({super.key, required this.c});
  final Character c;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(c.getImageDir(),width: 150,),
          Text("Speed: ${c.getSpeed()}\n"
              "Resistance:${c.getResistance()}\n"
              "Attack Speed: ${c.getAS()}\n"
              "Strength: ${c.getStrength()}\n"),
        ],
      ),
    );
  }
}