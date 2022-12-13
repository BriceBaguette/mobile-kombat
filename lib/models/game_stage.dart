import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mobile_kombat/models/constant.dart';

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/opponent.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/room.dart';
import 'package:mobile_kombat/views/canvas.dart';

import 'custom_buttons.dart';
import 'ground.dart';
import 'loader.dart';

class Stage extends ChangeNotifier {
  static Stage? _stage;
  var environmentImage = Loader().imgMap[AssetList.environmentImg]!;
  var characters = <Character>[];
  var buttons = <Button>[];
  var grounds = <Ground>[];
  var transparentGrounds = <Ground>[];
  Opponent? opponent;
  var _loading = true;
  var _ready = false;
  late Timer gameTimer;
  late int displayTime;
  Room? room;
  bool gameOver = false;
  bool get ready => _ready && !_loading;

  factory Stage() {
    _stage ??= Stage._hidden();
    return _stage!;
  }

  Stage._hidden();

  void _updateScreen() {
    if (ready) {
      notifyListeners();
    }
  }

  void _stageSetup(imgMap) {
    _ready = true;
    gameTimer =
        Timer.periodic(Duration(milliseconds: Constant().framerate), (timer) {
      _stage!.updateGame();
    });
    displayTime = Constant().time;
    print(displayTime);
    characters
      ..add(Player().character)
      ..add(opponent!.character);
    buttons
      ..add(MovingButton(
          dir: 'LEFT',
          img: imgMap[AssetList.leftButtonImg]!,
          bbox: Constant().leftButtonPosition))
      ..add(MovingButton(
          dir: 'RIGHT',
          img: imgMap[AssetList.rightButtonImg]!,
          bbox: Constant().rightButtonPosition))
      ..add(JumpButton(
          img: imgMap[AssetList.jumpButtonImg]!,
          bbox: Constant().jumpButtonPosition))
      ..add(FloorButton(
          img: imgMap[AssetList.floorButtonImg]!,
          bbox: Constant().floorButtonPosition))
      ..add(AttackButton(
          img: imgMap[AssetList.heavyAttackButtonImg]!,
          bbox: Constant().attackButtonPosition))
      ..add(QuickAttackButton(
          img: imgMap[AssetList.quickAttackButtonImg]!,
          bbox: Constant().quickAttackButtonPosition))
      ..add(DodgeButton(
          img: imgMap[AssetList.dodgeButtonImg]!,
          bbox: Constant().dodgeButtonPosition));
    grounds.add(Ground(bbox: Constant().leftPlatformBox));
    grounds.add(Ground(bbox: Constant().rightPlatformBox));
    grounds.add(Ground(bbox: Constant().middlePlatformBox));
    grounds.add(Ground(bbox: Constant().upperPlatformBox));
    transparentGrounds.add(grounds[grounds.length - 1]);
    _loading = false;
    _stage!._updateScreen();
  }

  void reset() {
    gameOver = false;
    displayTime = Constant().time;
    _loading = true;
    _stageSetup(Loader().imgMap);
  }

  void setRoom(Room newRoom) {
    room = newRoom;
  }

  void move(Character character, String dir, bool isMoving) {
    character.setDirection(dir);
    character.setMovement(isMoving);
  }

  void updateGame() {
    if (Stage().ready) {
      opponent!.getActions();
      for (var character in _stage!.characters) {
        for (var other in _stage!.characters) {
          if (other != character &&
              other.usingAbility &&
              other.abilityDamage() > 0 &&
              !character.isInvincible &&
              character.getHitBox().overlaps(other.abilityRange())) {
            int invincibilityFrame = other.remainingAbilityDuration();
            String fromDirection = 'LEFT';
            if (character.getHitBox().left < other.getHitBox().left) {
              fromDirection = 'RIGHT';
            }
            character.getDamage(other.abilityDamage(), invincibilityFrame,
                other.abilityRecoil(), fromDirection, false);
            if (character.health <= 0) {
              endGame();
              _updateScreen();
            }
          }
        }
        if (character.getImageBox().top > Constant().h) {
          character.getDamage(character.maxHealth, 0, 0, 'RIGHT', true);
          endGame();
          _updateScreen();
        }
        character.update();
      }
      _updateTimer();
      if (displayTime <= 0) {
        endGame();
      }
      _updateScreen();
    }
  }

  void _updateTimer() {
    displayTime -= Constant().framerate;
  }

  Button? getButton(Offset pointerPos) {
    for (var button in buttons) {
      if (button.bbox.contains(pointerPos)) return button;
    }
    return null;
  }

  bool isGround(Offset charPosLeft, Offset charPosRight) {
    for (var ground in grounds) {
      if (ground.bbox.contains(charPosLeft) ||
          ground.bbox.contains(charPosRight)) return true;
    }
    return false;
  }

  void setReady(bool bool) {
    _ready = bool;
  }

  void endGame() {
    characters.removeRange(0, characters.length);
    grounds.removeRange(0, grounds.length);
    buttons.removeRange(0, buttons.length);
    gameTimer.cancel();
    gameOver = true;
  }

  List<Character> getChar() {
    return [Player().character, opponent!.character];
  }

  Rect getPlayerPosition() {
    return Player().character.getHitBox();
  }

  void setOpponent(Opponent newOpponent) {
    opponent = newOpponent;
  }
}
