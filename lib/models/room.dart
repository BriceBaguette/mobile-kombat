import 'package:mobile_kombat/models/character.dart';

class Room {
  String roomId = '';
  List<UserDb> users = [];

  Room.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    for (Map<String, dynamic> user in json['users']) {
      users.add(UserDb.fromJson(user));
    }
  }
}

class UserDb {
  String userId = '';
  String userName = '';
  late CharacterDb character;
  UserDb.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    character = CharacterDb.fromJson(json['character']);
  }
}

class CharacterDb {
  String facing = '';
  int health = 100;
  int id = -1;
  double upSpeed = 0;

  CharacterDb.fromJson(json) {
    facing = json['facing'];
    health = json['health'];
    id = json['id'];
    upSpeed = json['upSpeed'];
  }

  Map<String, dynamic> toJson() {
    return {'facing': facing, 'health': health, 'id': id, 'upSpeed': upSpeed};
  }

  CharacterDb.fromCharacter(Character character) {
    facing = character.getFacing();
    health = character.health;
    id = 0;
    upSpeed = character.getUpSpeed();
  }
}
