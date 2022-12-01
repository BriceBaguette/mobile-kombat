import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/ability.dart';
import 'loader.dart';

class StickMan extends Character {
  @override
  StickMan(
      {required this.bbox,
      required this.speed,
      required this.facing,
      required fr}) {
    framerate = fr;
    staticImages = [Loader().imgMap[AssetList.characterImg]!];
    movingImages = [Loader().imgMap[AssetList.characterImg]!];
    jumpingImages = [Loader().imgMap[AssetList.characterImg]!];
    staticDuration = 500;
    movingDuration = 500;
    jumpingDuration = 500;
    setAction(staticImages, staticDuration);
    image = staticImages[actionImagesOffset];
    _dodge = LightDodge();
    _quickAttack = LightQuick();
    _airAttack = LightAir();
    _staticAttack = LightStatic();
    _horizontalAttack = LightHorizontal();
    _floorAttack = LightFloor();
  }

  @override
  late int framerate;
  @override
  int health = 100;
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

  @override
  void setDirection(String direction) {
    facing = direction;
  }

  @override
  void setMovement(bool move) {
    isMoving = move;
    if (move) {
      actionImagesOffset = 0;
      actionImageFramesOffset = 0;
      setAction(movingImages, movingDuration);
      image = actionImages[actionImagesOffset];
    }
  }

  @override
  void move() {
    /* 
    BUG TO FIX:
    Can glitch in the ground.
    */
    if (isGrounded() & (upSpeed >= 0)) {
      setJumpSpeed(0);
    } else {
      setJumpSpeed(upSpeed + 0.1);
    }
    bbox =
        Rect.fromLTWH(bbox.left, bbox.top + upSpeed, bbox.width, bbox.height);
    if (isMoving && !isBlocked()) {
      switch (facing) {
        case 'RIGHT':
          bbox = Rect.fromLTWH(
              bbox.left + speed, bbox.top, bbox.width, bbox.height);
          break;
        case 'LEFT':
          bbox = Rect.fromLTWH(
              bbox.left - speed, bbox.top, bbox.width, bbox.height);
          break;
        default:
          return;
      }
    }
    return;
  }

  @override
  void update() {
    bool actionLoopBack = updateImage();
    if (actionLoopBack && usingAbility) {
      usingAbility = false;
      setAction(staticImages, staticDuration);
    }
    image = actionImages[actionImagesOffset];

    move();
  }

  @override
  void setJumpSpeed(double value) {
    upSpeed = value;
    actionImagesOffset = 0;
    actionImageFramesOffset = 0;
    setAction(jumpingImages, jumpingDuration);
    image = actionImages[actionImagesOffset];
  }

  @override
  bool isGrounded() {
    return (Stage().isGround(Offset(bbox.right, bbox.bottom + upSpeed),
            Offset(bbox.left, bbox.bottom + upSpeed)) ||
        isAbove());
  }

  @override
  bool isBlocked() {
    switch (facing) {
      case 'LEFT':
        return Stage()
            .characters[1]
            .bbox
            .contains(Offset(bbox.left - speed, bbox.bottom - 1));
      case 'RIGHT':
        return Stage()
            .characters[1]
            .bbox
            .contains(Offset(bbox.right + speed, bbox.bottom - 1));
      default:
        return false;
    }
  }

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
      setAction(abilityInProgress.images, abilityInProgress.duration);
    }
  }

  @override
  bool isAbove() {
    return (Stage()
            .characters[1]
            .bbox
            .contains(Offset(bbox.left, bbox.bottom + upSpeed)) ||
        Stage()
            .characters[1]
            .bbox
            .contains(Offset(bbox.right, bbox.bottom + upSpeed)));
  }
}

abstract class Character {
  get health => null;

  get speed => null;

  get facing => null;

  get image => null;

  get bbox => null;

  get upspeed => null;

  get usingAbility => null;

  late int framerate;

  bool isMoving = false;

  bool isFloor = false;

  late List<ui.Image> staticImages;

  late List<ui.Image> movingImages;

  late List<ui.Image> jumpingImages;

  late int staticDuration;

  late int movingDuration;

  late int jumpingDuration;

  late Ability _quickAttack;

  late Ability _airAttack;

  late Ability _staticAttack;

  late Ability _horizontalAttack;

  late Ability _floorAttack;

  late Ability _dodge;

  late Ability abilityInProgress;

  late List<ui.Image> actionImages;

  late int actionFramesPerImage;

  int actionImagesOffset = 0;

  int actionImageFramesOffset = 0;

  bool isGrounded();
  bool isBlocked();
  bool isAbove();
  void update();
  void setMovement(bool move);
  void setDirection(String direction);
  void setJumpSpeed(double value);
  void move();
  Rect abilityRange();
  int abilityDamage();
  void getDamage(int damage);
  void attack({bool quick = false, bool dodge = false});

  Rect getBox() {
    if (usingAbility) {
      return Rect.fromLTWH(
          bbox.left,
          bbox.top,
          bbox.width * abilityInProgress.bboxWidthRatio,
          bbox.height * abilityInProgress.bboxHeightRatio);
    }
    return bbox;
  }

  void setAction(List<ui.Image> images, int duration) {
    actionImages = images;
    actionFramesPerImage =
        (duration / (framerate.toDouble() * actionImages.length.toDouble()))
            .round();
  }

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

  List<int> allocateFramesToImages(
      int imageNb, double duration, double framerate) {
    double framesPerImage = framerate * duration / imageNb.toDouble();
    List<int> framesList = <int>[];
    for (; imageNb > 0; imageNb--) {
      framesList.add(framesPerImage.round());
    }
    return framesList;
  }

  bool updateImage() {
    if (actionImageFramesOffset < actionFramesPerImage) {
      actionImageFramesOffset++;
    } else {
      actionImageFramesOffset = 0;
      actionImagesOffset++;
      if (actionImagesOffset == actionImages.length) {
        actionImagesOffset = 0;
        return true;
      }
    }
    return false;
  }
}
