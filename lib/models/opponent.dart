import 'dart:math';
import 'dart:ui';

import 'package:mobile_kombat/models/cosmetics.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/game_stage.dart';

class DummyBot extends Opponent {
  DummyBot({
    required super.character,
    /*required super.cosmetics*/
  });

  @override
  void getActions() {}
}

class SmartBot extends Opponent {
  Random random = Random();
  int moveTimer = 0;
  int attackTimer = 0;
  SmartBot({
    required super.character,
    /*required super.cosmetics*/
  });

  @override
  void getActions() {
    Rect playerBbox = Stage().getPlayerPosition();
    defineFacing(playerBbox);
    makeJump();
    useAbility(playerBbox);
  }

  void makeJump() {
    if (random.nextDouble() < 0.005 && character.isGrounded()) {
      character.jump(-6);
    }
  }

  void useAbility(playerBbox) {
    if (random.nextDouble() < 1 / (getCharacterDistance(playerBbox) / 5)) {
      character.attack();
    }
  }

  void defineFacing(Rect playerBbox) {
    if (moveTimer <= 0) {
      if (random.nextDouble() < 0.95) {
        character.setMovement(true);
        if (character.getHitBox().right < playerBbox.left &&
            character.getFacing() == 'RIGHT') {
          if (random.nextDouble() < 0.95) {
            character.setDirection('RIGHT');
          } else {
            character.setDirection('LEFT');
          }
        } else if (character.getHitBox().left > playerBbox.right &&
            character.getFacing() == 'LEFT') {
          if (random.nextDouble() < 0.95) {
            character.setDirection('LEFT');
          } else {
            character.setDirection('RIGHT');
          }
        } else {
          if (random.nextDouble() < 0.5) {
            character.setDirection('RIGHT');
          } else {
            character.setDirection('LEFT');
          }
        }
      } else {
        character.setMovement(false);
      }
      moveTimer = 15;
    } else {
      moveTimer--;
    }
  }

  double getCharacterDistance(playerBbox) {
    return (character.getHitBox().center - playerBbox.center).distance;
  }
}

class RealPlayer extends Opponent {
  String username;
  RealPlayer({required this.username, required super.character});
  @override
  void getActions() {}
}

abstract class Opponent {
  String username = '';
  Character character;
  //Cosmetics cosmetics;
  Opponent({
    required this.character,
    /*required this.cosmetics*/
  });
  void getActions();
}
