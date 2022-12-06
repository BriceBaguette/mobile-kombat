import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/ability.dart';
import 'loader.dart';

class StickMan extends Character {
  @override
  StickMan(
      {required Rect bbox,
      required double speed,
      required String facing,
      required int framerate}) {
    _framerate = framerate;
    _bbox = bbox;
    health = 100;
    maxHealth = 100;
    _speed = speed;
    _facing = facing;
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
}

class Light extends Character {
  @override
  Light(
      {required Rect bbox,
      required double speed,
      required String facing,
      required int framerate}) {
    _framerate = framerate;
    _bbox = bbox;
    health = 100;
    maxHealth = 100;
    _speed = speed;
    _facing = facing;
    _staticImages = [
      Loader().imgMap[AssetList.lightStatic_1]!,
      Loader().imgMap[AssetList.lightStatic_2]!
    ];
    _movingImages = [
      Loader().imgMap[AssetList.lightMoving_1]!,
      Loader().imgMap[AssetList.lightMoving_2]!,
      Loader().imgMap[AssetList.lightMoving_3]!,
      Loader().imgMap[AssetList.lightMoving_4]!
    ];
    _jumpingImages = [
      Loader().imgMap[AssetList.lightJumping_1]!,
      Loader().imgMap[AssetList.lightJumping_2]!
    ];
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
}

class Heavy extends Character {
  @override
  Heavy(
      {required Rect bbox,
      required double speed,
      required String facing,
      required int framerate}) {
    _framerate = framerate;
    _bbox = bbox;
    health = 100;
    maxHealth = 100;
    _speed = speed;
    _facing = facing;
    _staticImages = [
      Loader().imgMap[AssetList.heavyStatic_1]!,
      Loader().imgMap[AssetList.heavyStatic_2]!
    ];
    _movingImages = [
      Loader().imgMap[AssetList.heavyMoving_1]!,
      Loader().imgMap[AssetList.heavyMoving_2]!,
      Loader().imgMap[AssetList.heavyMoving_3]!,
      Loader().imgMap[AssetList.heavyMoving_4]!
    ];
    _jumpingImages = [
      Loader().imgMap[AssetList.heavyJumping_1]!,
      Loader().imgMap[AssetList.heavyJumping_2]!
    ];
    _staticDuration = 1000;
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
}

abstract class Character {
  late int _framerate;

  late ui.Image image;
  late Rect _bbox;

  late int health;
  late int maxHealth;
  late double _speed;
  double _upSpeed = 0;

  late String _facing;
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
    _facing = direction;
  }

  void setMovement(bool move) {
    isMoving = move;

    if (isGrounded()) {
      _actionImagesOffset = 0;
      _actionImageFramesOffset = 0;
      if (move) {
        _setAction(_movingImages, _movingDuration);
      } else {
        _setAction(_staticImages, _staticDuration);
      }
      image = _actionImages[_actionImagesOffset];
    }
  }

  void setJumpSpeed(double value) {
    _upSpeed = value;

    _actionImagesOffset = 0;
    _actionImageFramesOffset = 0;
    if (value == 0.0) {
      if (isMoving) {
        _setAction(_movingImages, _movingDuration);
      } else {
        _setAction(_staticImages, _staticDuration);
      }
    } else {
      _setAction(_jumpingImages, _jumpingDuration);
    }
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
      _invincibilityDuration -= 1;
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
    _bbox = Rect.fromLTWH(
        _bbox.left, _bbox.top + _upSpeed, _bbox.width, _bbox.height);
    if (isMoving && !_isBlocked()) {
      switch (_facing) {
        case 'RIGHT':
          _bbox = Rect.fromLTWH(
              _bbox.left + _speed, _bbox.top, _bbox.width, _bbox.height);
          break;
        case 'LEFT':
          _bbox = Rect.fromLTWH(
              _bbox.left - _speed, _bbox.top, _bbox.width, _bbox.height);
          break;
        default:
          return;
      }
    }
    return;
  }

  String getFacing() => _facing;

  Rect getImageBox() {
    if (usingAbility) {
      return Rect.fromLTWH(
          _bbox.left,
          _bbox.top,
          _bbox.width * _abilityInProgress.bboxWidthRatio,
          _bbox.height * _abilityInProgress.bboxHeightRatio);
    }
    return _bbox;
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
        (duration / (_framerate.toDouble() * _actionImages.length.toDouble()))
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
    return (Stage().isGround(Offset(_bbox.right, _bbox.bottom + _upSpeed),
            Offset(_bbox.left, _bbox.bottom + _upSpeed)) ||
        _isAbove());
  }

  bool _isAbove() {
    return (Stage()
            .characters[1]
            ._bbox
            .contains(Offset(_bbox.left, _bbox.bottom + _upSpeed)) ||
        Stage()
            .characters[1]
            ._bbox
            .contains(Offset(_bbox.right, _bbox.bottom + _upSpeed)));
  }

  bool _isBlocked() {
    if (bboxIntersect(Stage().characters[1]._bbox)) {
      return true;
    }
    for (var ground in Stage().grounds) {
      if (bboxIntersect(ground.bbox)) {
        return true;
      }
    }
    return false;
  }

  bool bboxIntersect(Rect otherBox) {
    switch (_facing) {
      case 'LEFT':
        return otherBox.contains(Offset(_bbox.left - _speed, _bbox.bottom - 1));
      case 'RIGHT':
        return otherBox
            .contains(Offset(_bbox.right + _speed, _bbox.bottom - 1));
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
    return (_actionFramesPerImage - _actionImageFramesOffset) +
        (_actionFramesPerImage * (_actionImages.length - _actionImagesOffset))
            .toDouble();
  }

  Rect getHitBox() => _bbox;

  void getDamage(int damage, bool absolute) {
    if (absolute || !isInvincible) {
      health -= damage;
    }
  }

  void setInvincibilityFrame(double duration) {
    isInvincible = true;
    _invincibilityDuration = duration;
  }

  Rect abilityRange() => _abilityInProgress.range(_bbox, _facing);

  int abilityDamage() => _abilityInProgress.power;
}
