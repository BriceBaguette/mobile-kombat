import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/cosmetics.dart';

class Player {
  Player(
      {required this.character,
      required this.cosmetics,
      required this.username,
      required this.health});

  Character character;
  List<Cosmetics> cosmetics;
  String username;
  double health;
}
