import 'package:flutter/cupertino.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/cosmetics.dart';
import 'package:mobile_kombat/models/database.dart';
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
    @override
    Rect hatBbox = (Rect.fromLTWH((Constant().w / 4) + 6, (Constant().h / 2),
        Constant().w / 30, Constant().w / 60 * Constant().gokuRatio));
    @override
    Rect bodyBbox = (Rect.fromLTWH(
        (Constant().w / 4) + 6,
        (Constant().h / 2) + 25,
        Constant().w / 30,
        Constant().w / 60 * Constant().gokuRatio));
    @override
    Rect footBbox = (Rect.fromLTWH(
        (Constant().w / 4) + 6,
        (Constant().h / 2) + 35,
        Constant().w / 30,
        Constant().w / 60 * Constant().gokuRatio));
    _price = 0;

    _framerate = framerate;

    _bbox = bbox;
    _name = "Stickman";
    _imageDir = "./assets/images/goku.png";

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

  @override
  StickMan duplicate() {
    return StickMan(
        bbox: _bbox, framerate: _framerate, facing: _facing, speed: _speed);
  }
}

class Light extends Character {
  @override
  Light(
      {required int framerate,
      required Rect bbox,
      required String facing,
      required double speed}) {
    @override
    Rect hatBbox = (Rect.fromLTWH((Constant().w / 4) + 6, (Constant().h / 2),
        Constant().w / 30, Constant().w / 60 * Constant().gokuRatio));
    @override
    Rect bodyBbox = (Rect.fromLTWH(
        (Constant().w / 4) + 6,
        (Constant().h / 2) + 25,
        Constant().w / 30,
        Constant().w / 60 * Constant().gokuRatio));
    @override
    Rect footBbox = (Rect.fromLTWH(
        (Constant().w / 4) + 6,
        (Constant().h / 2) + 35,
        Constant().w / 30,
        Constant().w / 60 * Constant().gokuRatio));
    _price = 0;

    _framerate = framerate;

    _bbox = bbox;
    _name = "Light";
    _imageDir = "./assets/images/light/light_static_1.png";

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

  @override
  Light duplicate() {
    return Light(
        bbox: _bbox, framerate: _framerate, facing: _facing, speed: _speed);
  }
}

class Heavy extends Character {
  @override
  Heavy(
      {required int framerate,
      required Rect bbox,
      required String facing,
      required double speed}) {
    _price = 0;

    _framerate = framerate;

    _bbox = bbox;
    _name = "Heavy";
    _imageDir = "./assets/images/heavy/heavy_static_1.png";

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

  @override
  Heavy duplicate() {
    return Heavy(
        bbox: _bbox, framerate: _framerate, facing: _facing, speed: _speed);
  }
}

abstract class Character {
  int id = 0;
  late Rect hatBbox;

  late Rect bodyBbox;

  late Rect footBbox;
  late int _price;

  late int _framerate;

  late ui.Image image;
  late Rect _bbox;
  late String _name;
  late String _imageDir;

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

  String getImageDir() => _imageDir;

  Map<String, Cosmetics> equippedCosmetics = {};
  void equipCosmetic(Cosmetics c) {
    String bp = c.getBodyPart();
    equippedCosmetics[bp] = c;
  }

  void removeCosmetic(String s) {
    equippedCosmetics.remove(s);
  }

  int getPrice() {
    return _price;
  }

  int getStrength() {
    return _powerModificator;
  }

  int getAS() {
    return _attackSpeedModificator.round();
  }

  int getResistance() {
    return _resistanceModificator;
  }

  double getSpeed() {
    return _speed;
  }

  double getUpSpeed() => _upSpeed;

  String getName() {
    return _name;
  }

  void setJumpSpeed(double jumpSpeed) {
    _upSpeed = jumpSpeed;
  }

  void setStrength(int mod) {
    _powerModificator = mod;
  }

  void setAS(int mod) {
    _attackSpeedModificator = mod.toDouble();
  }

  void setResistance(int mod) {
    _resistanceModificator = mod;
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
    hatBbox = Rect.fromLTWH(
        hatBbox.left, hatBbox.top + _upSpeed, hatBbox.width, hatBbox.height);
    bodyBbox = Rect.fromLTWH(bodyBbox.left, bodyBbox.top + _upSpeed,
        bodyBbox.width, bodyBbox.height);
    footBbox = Rect.fromLTWH(footBbox.left, footBbox.top + _upSpeed,
        footBbox.width, footBbox.height);
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
          hatBbox = Rect.fromLTWH(
              hatBbox.left + speed, hatBbox.top, hatBbox.width, hatBbox.height);
          bodyBbox = Rect.fromLTWH(bodyBbox.left + speed, bodyBbox.top,
              bodyBbox.width, bodyBbox.height);
          footBbox = Rect.fromLTWH(footBbox.left + speed, footBbox.top,
              footBbox.width, footBbox.height);
          break;
        case 'LEFT':
          _bbox = Rect.fromLTWH(
              _bbox.left - speed, _bbox.top, _bbox.width, _bbox.height);
          hatBbox = Rect.fromLTWH(
              hatBbox.left - speed, hatBbox.top, hatBbox.width, hatBbox.height);
          bodyBbox = Rect.fromLTWH(bodyBbox.left - speed, bodyBbox.top,
              bodyBbox.width, bodyBbox.height);
          footBbox = Rect.fromLTWH(footBbox.left - speed, footBbox.top,
              footBbox.width, footBbox.height);
          break;
        default:
          return;
      }
    }
    return;
  }

  void jump(double speed) {
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
      _abilityInProgress = _determineAttack(quick, floor, dodge);
      _setAction(_abilityInProgress.images, getImageBox(),
          _abilityInProgress.duration - _attackSpeedModificator);
    }
  }

  Ability _determineAttack(bool quick, bool floor, bool dodge) {
    if (dodge) {
      _usingStaticAbility = false;
      hasJumped = false;
      isInvincible = true;
      _invincibilityDuration = (_dodge.duration / _framerate).round();
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
    _actionImagesOffset = 0;
    _actionImageFramesOffset = 0;
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
    return (Stage().isGround(Offset(_bbox.right, _bbox.bottom + _upSpeed),
            Offset(_bbox.left, _bbox.bottom + _upSpeed)) &&
        _upSpeed >= 0);
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

  void setPosition(Rect position) {
    _bbox = position;
  }

  Character duplicate();
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
          Image.asset(
            c.getImageDir(),
            width: 150,
          ),
          Text("Speed: ${c.getSpeed()}\n"
              "Resistance:${c.getResistance()}\n"
              "Attack Speed: ${c.getAS()}\n"
              "Strength: ${c.getStrength()}\n"),
        ],
      ),
    );
  }
}
