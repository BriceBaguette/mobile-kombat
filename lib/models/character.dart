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
      required this.framerate}) {
    image = Loader().imgMap[AssetList.characterImg]!;
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
  ui.Image abilityImage() => abilityImages[abilityImagesOffset];

  @override
  Rect abilityRange() => abilityInProgress.range(bbox, facing);

  @override
  int abilityDamage() => abilityInProgress.power;

  @override
  void getDamage(int damage) => health -= damage;

  @override
  void attack({bool quick = false}) {
    if (!usingAbility) {
      usingAbility = true;
      abilityInProgress = determineAttack(quick);
      abilityImages = abilityInProgress.images;
      abilityFramesPerImage = (abilityInProgress.duration /
              (framerate.toDouble() * abilityImages.length.toDouble()))
          .round();
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

  get reversedImage => null;

  get image => null;

  get bbox => null;

  get upspeed => null;

  get usingAbility => null;

  bool isMoving = false;

  bool isFloor = false;

  late Ability _quickAttack;

  late Ability _airAttack;

  late Ability _staticAttack;

  late Ability _horizontalAttack;

  late Ability _floorAttack;

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
  void attack({bool quick = false});

  Ability determineAttack(bool quick) {
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
}
