import 'package:mobile_kombat/models/constant.dart';
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
  String _username = '';
  double health = 100;
  int gold = 0;

  void updateGold(int mod) {
    gold = gold + mod;
  }

  void setGoldPlayer(int n) {
    gold = n;
  }

  Player._hidden() {
    health = 100;
  }
  set username(nickname) => _username = nickname;
  get username => _username;

  setCharacter(character) {
    this.character = character;
  }

  setCosmetics(cosmetics) {
    this.cosmetics = cosmetics;
  }

  resetCharacter() {
    character.setPosition(Constant().firstPlayerPosition);
    character.health = character.maxHealth;
    character.hasJumped = false;
    character.setMovement(false);
    character.isFloor = false;
    character.isGettingDamage = false;
    character.isInvincible = false;
  }

  getUsername() {
    return username;
  }
}
