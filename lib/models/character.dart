import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/ability.dart';
import 'loader.dart';

class StickMan extends Character {
  @override
  StickMan(
      {required int framerate,
      required Rect bbox,
      required String facing,
      required double speed}) {
    _framerate = framerate;
    _bbox = bbox;

    health = 100;
    maxHealth = 100;
    _speed = speed;

    _facing = facing;

    _staticImages = [Loader().imgMap[AssetList.characterImg]!];
    _movingImages = [Loader().imgMap[AssetList.characterImg]!];
    _jumpingImages = [Loader().imgMap[AssetList.characterImg]!];
    _getDamageImages = [Loader().imgMap[AssetList.characterImg]!];
    _staticBbox = bbox;
    _movingBbox = bbox;
    _jumpingBbox = bbox;
    _getDamageBbox = bbox;
    _staticDuration = 500;
    _movingDuration = 500;
    _jumpingDuration = 500;
    _setAction(_staticImages, _staticBbox, _staticDuration);

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
      {required int framerate,
      required Rect bbox,
      required String facing,
      required double speed}) {
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
    _getDamageImages = [Loader().imgMap[AssetList.characterImg]!];
    _staticBbox = bbox;
    _movingBbox = bbox;
    _jumpingBbox = bbox;
    _getDamageBbox = bbox;
    _staticDuration = 500;
    _movingDuration = 500;
    _jumpingDuration = 500;
    _setAction(_staticImages, _staticBbox, _staticDuration);

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
      {required int framerate,
      required Rect bbox,
      required String facing,
      required double speed}) {
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
    _getDamageImages = [Loader().imgMap[AssetList.characterImg]!];
    _staticBbox = bbox;
    _movingBbox = bbox;
    _jumpingBbox = bbox;
    _getDamageBbox = bbox;
    _staticDuration = 1500;
    _movingDuration = 750;
    _jumpingDuration = 500;
    _setAction(_staticImages, _staticBbox, _staticDuration);

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
  late double _attackSpeedModificator = 0;
  late int _powerModificator = 0;
  late int _resistanceModificator = 0;

  final double _gravity = 0.1;

  late String _facing;
  bool hasJumped = false;
  bool isMoving = false;
  bool usingAbility = false;
  bool _usingStaticAbility = false;
  bool isInvincible = false;
  bool isGettingDamage = false;

  late List<ui.Image> _staticImages;
  late List<ui.Image> _movingImages;
  late List<ui.Image> _jumpingImages;
  late List<ui.Image> _getDamageImages;
  late Rect _staticBbox;
  late Rect _movingBbox;
  late Rect _jumpingBbox;
  late Rect _getDamageBbox;
  late double _staticDuration;
  late double _movingDuration;
  late double _jumpingDuration;
  late double _getDamageDuration;

  late Ability _quickAttack;
  late Ability _airAttack;
  late Ability _staticAttack;
  late Ability _horizontalAttack;
  late Ability _floorAttack;
  late Ability _dodge;

  final double _dodgeCooldown = 3000;
  late double dodgeRemainingCooldown = 0;

  late Ability _abilityInProgress;
  late List<ui.Image> _actionImages;
  late int _actionFramesPerImage;
  int _actionImagesOffset = 0;
  int _actionImageFramesOffset = 0;

  int _invincibilityDuration = 0;

  double recoilSpeed = 10;

  int price = 0;
  int strength = 0;
  int aS = 0;
  int resistance = 0;
  String imageDir = "assets/images/GenericGuy.png";
  String name = "Stickman2";

  String getImageDir() => imageDir;

  int getPrice() {
    return price;
  }

  int getStrength() {
    return _powerModificator;
  }

  int getAS() {
    return aS;
  }

  int getResistance() {
    return resistance;
  }

  double getSpeed() {
    return _speed;
  }

  double getUpSpeed() => _upSpeed;

  String getName() {
    return name;
  }

  void setStrength(int mod) {
    _powerModificator = mod;
  }

  void setAS(int mod) {
    _attackSpeedModificator = mod.toDouble();
  }

  void setResistance(int mod) {
    resistance = resistance + mod;
  }

  void setSpeed(int mod) {
    _speed = _speed + mod;
  }

  void setDirection(String direction) {
    _facing = direction;
  }

  void update() {
    if (dodgeRemainingCooldown > 0) {
      dodgeRemainingCooldown -= _framerate;
    }
    bool actionLoopBack = _updateImage();
    image = _actionImages[_actionImagesOffset];
    if (actionLoopBack && usingAbility) {
      if (_abilityInProgress == _dodge) {
        dodgeRemainingCooldown = _dodgeCooldown;
      }
      usingAbility = false;
      _usingStaticAbility = false;
      var move = isMoving;
      setMovement(move);
    }
    if (actionLoopBack && isGettingDamage) {
      isGettingDamage = false;
      isMoving = false;
      _setAction(_staticImages, _staticBbox, _staticDuration);
    }

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
    if (isGrounded() && _upSpeed > 0.0 && !isGettingDamage) {
      _upSpeed = 0;
      hasJumped = false;
      if (!usingAbility) {
        var move = isMoving;
        setMovement(move);
      }
    }
    if (!isGrounded() && !_usingStaticAbility && !isGettingDamage) {
      if (_upSpeed == 0 && !usingAbility) {
        jump(_gravity);
      }
      _upSpeed += _gravity;
    }
    _bbox = Rect.fromLTWH(
        _bbox.left, _bbox.top + _upSpeed, _bbox.width, _bbox.height);
    if (isMoving && !_isBlocked() && !_usingStaticAbility) {
      var speed = _speed;
      if (isGettingDamage) {
        speed = -recoilSpeed;
      }
      switch (_facing) {
        case 'RIGHT':
          _bbox = Rect.fromLTWH(
              _bbox.left + speed, _bbox.top, _bbox.width, _bbox.height);
          break;
        case 'LEFT':
          _bbox = Rect.fromLTWH(
              _bbox.left - speed, _bbox.top, _bbox.width, _bbox.height);
          break;
        default:
          return;
      }
    }
    return;
  }

  void jump(double speed) {
    _actionImagesOffset = 0;
    _actionImageFramesOffset = 0;
    if (speed == 0.0) {
      if (isMoving) {
        _setAction(_movingImages, _movingBbox, _movingDuration);
      } else {
        _setAction(_staticImages, _staticBbox, _staticDuration);
      }
    } else {
      if (_upSpeed != 0.0) {
        hasJumped = true;
      }
      _setAction(_jumpingImages, _jumpingBbox, _jumpingDuration);
    }

    _upSpeed = speed;
  }

  void setMovement(bool move) {
    isMoving = move;

    if (isGrounded()) {
      _actionImagesOffset = 0;
      _actionImageFramesOffset = 0;
      if (move) {
        _setAction(_movingImages, _movingBbox, _movingDuration);
      } else {
        _setAction(_staticImages, _staticBbox, _staticDuration);
      }
    } else {
      _setAction(_jumpingImages, _jumpingBbox, _jumpingDuration);
    }
  }

  bool _isBlocked() {
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

  String getFacing() => _facing;

  Rect getImageBox() {
    if (usingAbility) {
      return Rect.fromLTWH(
          _bbox.left,
          _bbox.top,
          _bbox.width * _abilityInProgress.imageBoxWidthRatio,
          _bbox.height * _abilityInProgress.imageBoxHeightRatio);
    }
    return _bbox;
  }

  void attack({bool quick = false, bool floor = false, bool dodge = false}) {
    if (!usingAbility && !isGettingDamage) {
      usingAbility = true;
      isMoving = false;
      _actionImagesOffset = 0;
      _actionImageFramesOffset = 0;
      _abilityInProgress = _determineAttack(quick, floor, dodge);
      _setAction(_abilityInProgress.images, getImageBox(),
          _abilityInProgress.duration - _attackSpeedModificator);
    }
  }

  Ability _determineAttack(bool quick, bool floor, bool dodge) {
    if (dodge) {
      _usingStaticAbility = false;
      hasJumped = false;
      return _dodge;
    }
    if (quick) {
      _usingStaticAbility = true;
      return _quickAttack;
    }
    if (!isGrounded()) {
      _usingStaticAbility = false;
      return _airAttack;
    }
    if (floor) {
      _usingStaticAbility = true;
      return _floorAttack;
    }
    if (isMoving) {
      _usingStaticAbility = false;
      return _horizontalAttack;
    }
    _usingStaticAbility = true;
    return _staticAttack;
  }

  void _setAction(List<ui.Image> images, Rect bbox, double duration) {
    _actionImages = images;
    _actionFramesPerImage =
        ((duration / (_framerate.toDouble()) / _actionImages.length.toDouble()))
            .round();
    image = _actionImages[_actionImagesOffset];
    _adjustBbox(bbox);
  }

  void _adjustBbox(Rect bbox) {
    var widthDiff = _bbox.width - bbox.width;
    var heightDiff = _bbox.height - bbox.height;
    _bbox = Rect.fromLTWH(_bbox.left + widthDiff / 2, _bbox.top + heightDiff,
        bbox.width, bbox.height);
  }

  bool isGrounded() {
    return Stage().isGround(Offset(_bbox.right, _bbox.bottom + _upSpeed),
        Offset(_bbox.left, _bbox.bottom + _upSpeed));
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

  int remainingAbilityDuration() {
    if (!usingAbility) {
      return 0;
    }
    return (_actionFramesPerImage - _actionImageFramesOffset) +
        (_actionFramesPerImage *
            (_actionImages.length - (_actionImagesOffset + 1)));
  }

  Rect getHitBox() {
    if (usingAbility) {
      return Rect.fromLTWH(
          _bbox.left + _abilityInProgress.hitBoxLeftOffset,
          _bbox.top + _abilityInProgress.hitBoxTopOffset,
          _bbox.width,
          _bbox.height);
    }
    return _bbox;
  }

  void getDamage(int damage, int invincibilityFrame, int recoilDistance,
      String fromDirection, bool absolute) {
    if (absolute || !isInvincible) {
      health -= damage - _resistanceModificator;
      _getDamageDuration = recoilDistance / recoilSpeed * _framerate;
      _setInvincibilityFrame(invincibilityFrame);
      _actionImagesOffset = 0;
      _actionImageFramesOffset = 0;
      _setAction(_getDamageImages, _getDamageBbox, _getDamageDuration);
      usingAbility = false;
      isMoving = true;
      _upSpeed = 0;
      isGettingDamage = true;
      _facing = fromDirection;
    }
  }

  void _setInvincibilityFrame(int duration) {
    isInvincible = true;
    _invincibilityDuration = duration;
  }

  Rect abilityRange() => _abilityInProgress.range(_bbox, _facing);

  int abilityDamage() => _abilityInProgress.power + _powerModificator;

  int abilityRecoil() => _abilityInProgress.recoilDistance;
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
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [])
      ],
    );
  }
}
