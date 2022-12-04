import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/cosmetics.dart';

class Player {
  static Player? _player;

  factory Player() {
    _player ??= Player._hidden();
    return _player!;
  }
  late Character character;
  late List<Cosmetics> cosmetics;
  late String username;
  double health = 100;

  Player._hidden() {
    resetHealth();
  }

  setCharacter(character) {
    this.character = character;
  }

  setCosmetics(cosmetics) {
    this.cosmetics = cosmetics;
  }

  resetHealth() {
    health = 100;
  }
}