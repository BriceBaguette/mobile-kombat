import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mobile_kombat/models/constant.dart';

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/opponent.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/room.dart';

import 'custom_buttons.dart';
import 'ground.dart';
import 'loader.dart';

class Stage extends ChangeNotifier {
  static Stage? _stage;
  var characters = <Character>[];
  var buttons = <Button>[];
  var grounds = <Ground>[];
  Opponent? _opponent;
  var _loading = true;
  var _ready = false;
  late Timer gameTimer;
  late int displayTime;
  late Room room;
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
    characters
      ..add(Player().character)
      ..add(_opponent!.character);
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
          img: imgMap[AssetList.heavyAttackImg]!,
          bbox: Constant().attackButtonPosition))
      ..add(QuickAttackButton(
          img: imgMap[AssetList.quickAttackImg]!,
          bbox: Constant().quickAttackButtonPosition))
      ..add(DodgeButton(
          img: imgMap[AssetList.dodgeImg]!,
          bbox: Constant().dodgeButtonPosition));
    grounds.add(Ground(
        bbox: Rect.fromLTWH(
            0,
            Constant().h / 2 + _stage!.characters[0].bbox.height,
            Constant().w,
            Constant().h / 10),
        groundImg: imgMap[AssetList.baseGround]!));
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
      _opponent!.getActions();
      for (var character in _stage!.characters) {
        for (var other in _stage!.characters) {
          if (other != character &&
              other.usingAbility &&
              character.bbox.overlaps(other.abilityRange())) {
            character.getDamage(other.abilityDamage());
          }
        }
        character.update();
      }
      _updateTimer();
      if (displayTime <= 0) {
        characters.removeRange(0, characters.length);
        grounds.removeRange(0, grounds.length);
        buttons.removeRange(0, buttons.length);
        gameTimer.cancel();
        gameOver = true;
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

  Rect getPlayerPosition() {
    return Player().character.bbox;
  }

  void setOpponent(Opponent opponent) {
    _opponent = opponent;
  }
}
