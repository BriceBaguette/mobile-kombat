import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/ability.dart';

class StickMan extends Character {
  @override
  StickMan(
      {required this.image,
      required this.bbox,
      required this.speed,
      required this.facing,
      required mainAbilityImage,
      required this.framerate}) {
    mainAbility = SwordStrike(images: [mainAbilityImage]);
  }

  late int framerate;
  @override
  int health = 100;
  @override
  ui.Image image;
  @override
  Rect bbox;
  @override
  double speed = 5;
  @override
  String facing = 'RIGHT';
  double upSpeed = 0;
  var isMoving = false;
  late Ability mainAbility;
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
    if (isGrounded() & (upSpeed >= 0)) {
      setJumpSpeed(0);
    } else {
      setJumpSpeed(upSpeed + 0.1);
    }
    bbox =
        Rect.fromLTWH(bbox.left, bbox.top + upSpeed, bbox.width, bbox.height);
    if (isMoving) {
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
    if (Stage().isGround(Offset(bbox.left + bbox.width, bbox.top + bbox.height),
        Offset(bbox.left, bbox.top + bbox.height))) return true;
    return false;
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
  void attack() {
    usingAbility = true;
    abilityInProgress = mainAbility;
    abilityImages = abilityInProgress.images;
    abilityFramesPerImage = (abilityInProgress.duration /
            (framerate.toDouble() * abilityImages.length.toDouble()))
        .round();
  }
}

abstract class Character {
  get health => null;

  get speed => null;

  get image => null;

  get bbox => null;

  get facing => null;

  get upspeed => null;

  get usingAbility => null;

  bool isGrounded();
  void update();
  void setMovement(bool move);
  void setDirection(String direction);
  void setJumpSpeed(double value);
  void move();
  ui.Image abilityImage();
  Rect abilityRange();
  int abilityDamage();
  void getDamage(int damage);
  void attack();

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
