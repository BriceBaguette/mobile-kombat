import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/cosmetics.dart';

import 'auth.dart';
import 'database.dart';

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
  int gold = 0;

  void updateGold(int mod){
    gold = gold + mod;
  }

  void setGoldPlayer(int n){
    gold = n;
  }

  Player._hidden() {
    resetHealth();
  }

  setCharacter(character) {
    this.character = character;
  }

  setCosmetics(cosmetics) {
    this.cosmetics = cosmetics;
  }

  String getUsername(){
    return "alouette";//username
  }

  resetHealth() {
    health = 100;
  }
}
