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
    health = 100;
    _staticImages = [Loader().imgMap[AssetList.characterImg]!];
    _movingImages = [Loader().imgMap[AssetList.characterImg]!];
    _jumpingImages = [Loader().imgMap[AssetList.characterImg]!];
    _staticDuration = 500;
    _movingDuration = 500;
    _jumpingDuration = 500;
    _setAction(_staticImages, _staticDuration);
    image = _staticImages[_actionImagesOffset];
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
  Rect bbox;
  @override
  double speed;
  @override
  String facing;
}

class Light extends Character {
  @override
  Light(
      {required this.bbox,
      required this.speed,
      required this.facing,
      required this.framerate}) {
    health = 100;
    _staticImages = [Loader().imgMap[AssetList.characterImg]!];
    _movingImages = [Loader().imgMap[AssetList.characterImg]!];
    _jumpingImages = [Loader().imgMap[AssetList.characterImg]!];
    _staticDuration = 500;
    _movingDuration = 500;
    _jumpingDuration = 500;
    _setAction(_staticImages, _staticDuration);
    image = _staticImages[_actionImagesOffset];
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
  Rect bbox;
  @override
  double speed;
  @override
  String facing;
}

class Heavy extends Character {
  @override
  Heavy(
      {required this.bbox,
      required this.speed,
      required this.facing,
      required this.framerate}) {
    health = 100;
    _staticImages = [Loader().imgMap[AssetList.characterImg]!];
    _movingImages = [Loader().imgMap[AssetList.characterImg]!];
    _jumpingImages = [Loader().imgMap[AssetList.characterImg]!];
    _staticDuration = 500;
    _movingDuration = 500;
    _jumpingDuration = 500;
    _setAction(_staticImages, _staticDuration);
    image = _staticImages[_actionImagesOffset];
    _dodge = HeavyDodge();
    _quickAttack = HeavyQuick();
    _airAttack = HeavyAir();
    _staticAttack = HeavyStatic();
    _horizontalAttack = HeavyHorizontal();
    _floorAttack = HeavyFloor();
  }

  @override
  late int framerate;
  @override
  Rect bbox;
  @override
  double speed;
  @override
  String facing;
}

abstract class Character {
  late int framerate;

  late ui.Image image;
  late Rect bbox;

  late int health;
  late double speed;
  double _upSpeed = 0;

  late String facing;
  bool isMoving = false;
  bool isFloor = false;
  bool usingAbility = false;
  bool isInvincible = false;

  late List<ui.Image> _staticImages;
  late List<ui.Image> _movingImages;
  late List<ui.Image> _jumpingImages;
  late double _staticDuration;
  late double _movingDuration;
  late double _jumpingDuration;

  late Ability _quickAttack;
  late Ability _airAttack;
  late Ability _staticAttack;
  late Ability _horizontalAttack;
  late Ability _floorAttack;
  late Ability _dodge;

  late Ability _abilityInProgress;
  late List<ui.Image> _actionImages;
  late int _actionFramesPerImage;
  int _actionImagesOffset = 0;
  int _actionImageFramesOffset = 0;

  double _invincibilityDuration = 0;

  void setDirection(String direction) {
    facing = direction;
  }

  void setMovement(bool move) {
    isMoving = move;
    if (move) {
      _actionImagesOffset = 0;
      _actionImageFramesOffset = 0;
      _setAction(_movingImages, _movingDuration);
      image = _actionImages[_actionImagesOffset];
    }
  }

  void setJumpSpeed(double value) {
    _upSpeed = value;
    _actionImagesOffset = 0;
    _actionImageFramesOffset = 0;
    _setAction(_jumpingImages, _jumpingDuration);
    image = _actionImages[_actionImagesOffset];
  }

  void update() {
    bool actionLoopBack = _updateImage();
    if (usingAbility) {}
    if (actionLoopBack && usingAbility) {
      usingAbility = false;
      _setAction(_staticImages, _staticDuration);
    }
    image = _actionImages[_actionImagesOffset];

    move();

    if (isInvincible) {
      _invincibilityDuration -= framerate;
      if (_invincibilityDuration <= 0) {
        isInvincible = false;
        _invincibilityDuration = 0;
      }
    }
  }

  void move() {
    if (isGrounded() && (_upSpeed > 0.0)) {
      setJumpSpeed(0.0);
    }
    if (!isGrounded() && !usingAbility) {
      setJumpSpeed(_upSpeed + 0.1);
    }
    bbox =
        Rect.fromLTWH(bbox.left, bbox.top + _upSpeed, bbox.width, bbox.height);
    if (isMoving && !_isBlocked()) {
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

  Rect getBox() {
    if (usingAbility) {
      return Rect.fromLTWH(
          bbox.left,
          bbox.top,
          bbox.width * _abilityInProgress.bboxWidthRatio,
          bbox.height * _abilityInProgress.bboxHeightRatio);
    }
    return bbox;
  }

  void attack({bool quick = false, bool dodge = false}) {
    if (!usingAbility) {
      usingAbility = true;
      _upSpeed = 0;
      isMoving = false;
      _actionImagesOffset = 0;
      _actionImageFramesOffset = 0;
      _abilityInProgress = _determineAttack(quick, dodge);
      _setAction(_abilityInProgress.images, _abilityInProgress.duration);
    }
  }

  void _setAction(List<ui.Image> images, double duration) {
    _actionImages = images;
    _actionFramesPerImage =
        (duration / (framerate.toDouble() * _actionImages.length.toDouble()))
            .round();
  }

  Ability _determineAttack(bool quick, bool dodge) {
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

  bool isGrounded() {
    return (Stage().isGround(Offset(bbox.right, bbox.bottom + _upSpeed),
            Offset(bbox.left, bbox.bottom + _upSpeed)) ||
        _isAbove());
  }

  bool _isAbove() {
    return (Stage()
            .characters[1]
            .bbox
            .contains(Offset(bbox.left, bbox.bottom + _upSpeed)) ||
        Stage()
            .characters[1]
            .bbox
            .contains(Offset(bbox.right, bbox.bottom + _upSpeed)));
  }

  bool _isBlocked() {
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

  bool _updateImage() {
    _actionImageFramesOffset++;
    if (_actionImageFramesOffset >= _actionFramesPerImage) {
      _actionImageFramesOffset = 0;
      _actionImagesOffset++;
      if (_actionImagesOffset >= _actionImages.length) {
        _actionImagesOffset = 0;
        return true;
      }
    }
    return false;
  }

  double remainingAbilityDuration() {
    if (!usingAbility) {
      return 0.0;
    }
    return framerate.toDouble() *
        ((_actionFramesPerImage - _actionImageFramesOffset) +
                (_actionFramesPerImage *
                    (_actionImages.length - _actionImagesOffset)))
            .toDouble();
  }

  void getDamage(int damage) => health -= damage;

  void setInvincibilityFrame(double duration) {
    isInvincible = true;
    _invincibilityDuration = duration;
  }

  Rect abilityRange() => _abilityInProgress.range(bbox, facing);

  int abilityDamage() => _abilityInProgress.power;
}
