import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_kombat/models/auth.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/room.dart';

class Database {
  final db = FirebaseFirestore.instance;

  final Loader _loader = Loader();
  void addUser(UserCredential cred, String nickname) {
    List<int> characterList = [];
    characterList.add(0);
    db
        .collection('users')
        .doc(cred.user!.uid)
        .set({'ownedCharacter': characterList, 'nickname': nickname});
  }

  Future<List<Character>> getCharacterFromUser(String userUid) async {
    List<Character> characters = [];
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    List<int> characterList = data!["ownedCharacter"].cast<int>();
    for (int i in characterList) {
      characters.add(_loader.characterList[i]);
    }
    return characters;
  }

  Future<String> getUserName(userId) async {
    var docSnap = await db.collection('users').doc(userId).get();
    var data = docSnap.data();
    return data!["nickname"] as String;
  }
}

class RealTimeDB {
  final Constant _constant = Constant();
  final db = FirebaseDatabase.instance;
  final Loader _loader = Loader();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final userDatabase = Database();
  final _player = Player();

  Future<String> createRoom(userId) async {
    var jsonChar = jsonEncode(CharacterDb.fromCharacter(_player.character));
    await ref.set({
      "rooms": [
        {
          "roomId": userId,
          "users": [
            {
              "userId": userId,
              "userName": _player.username,
              "character": jsonChar,
            }
          ]
        }
      ]
    });
    return (userId);
  }

  Future<String> joinRoom(userId) async {
    List<Room> rooms = [];
    final snapshot = await ref.get();
    if (snapshot.exists) {
      String jsonString = snapshotToJsonString(snapshot.value.toString());
      Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      for (var room in json['rooms']) {
        rooms.add(Room.fromJson(room));
      }
      for (Room room in rooms) {
        if ((room.users.length < 2)) {
          var index = rooms.indexOf(room);
          DatabaseReference refRoom =
              FirebaseDatabase.instance.ref('/rooms/$index');
          var jsonChar = jsonEncode(
              CharacterDb.fromCharacter(_player.character, second: true));
          refRoom.update({
            'users': [
              {
                "userId": room.users[0].userId,
                "userName": room.users[0].userName,
                "character": jsonEncode(room.users[0].character),
                "first": true
              },
              {
                "userId": userId,
                "userName": _player.username,
                "character": jsonChar,
                "first": false
              }
            ]
          });
          return room.roomId;
        }
      }
    }
    return await createRoom(userId);
  }

  updateData() {}

  String snapshotToJsonString(String string) {
    string = string.replaceAll(' ', '');
    string = string.replaceAll('"', '');
    string = string.replaceAll('{', '{"');
    string = string.replaceAll(':', '":');
    string = string.replaceAll(',', ',"');
    var index = string.indexOf(RegExp(r':[A-Z]', caseSensitive: false));
    while (index > -1) {
      string =
          '${string.substring(0, index + 1)}"${string.substring(index + 1, string.length)}';
      index = string.indexOf(RegExp(r':[A-Z]', caseSensitive: false));
    }
    index = string.indexOf(RegExp(r'[A-Z],', caseSensitive: false));
    while (index > -1) {
      string =
          '${string.substring(0, index + 1)}"${string.substring(index + 1, string.length)}';
      index = string.indexOf(RegExp(r'[A-Z],', caseSensitive: false));
    }
    index = string.indexOf(RegExp(r':[0-9]', caseSensitive: false));
    while (index > -1) {
      string =
          '${string.substring(0, index + 1)}"${string.substring(index + 1, string.length)}';
      index = string.indexOf(RegExp(r':[0-9]', caseSensitive: false));
    }
    index = string.indexOf(RegExp(r'[0-9],', caseSensitive: false));
    while (index > -1) {
      string =
          '${string.substring(0, index + 1)}"${string.substring(index + 1, string.length)}';
      index = string.indexOf(RegExp(r'[0-9],', caseSensitive: false));
    }
    index = string.indexOf(RegExp(r'[0-9]}', caseSensitive: false));
    while (index > -1) {
      string =
          '${string.substring(0, index + 1)}"${string.substring(index + 1, string.length)}';
      index = string.indexOf(RegExp(r'[0-9]}', caseSensitive: false));
    }
    index = string.indexOf(RegExp(r'[A-Z]}', caseSensitive: false));
    while (index > -1) {
      string =
          '${string.substring(0, index + 1)}"${string.substring(index + 1, string.length)}';
      index = string.indexOf(RegExp(r'[A-Z]}', caseSensitive: false));
    }

    string = string.replaceAll(',"{', ',{');
    return string;
  }

  Future<Room?> waitOpponent(String roomId) async {
    final snapshot = await ref.get();
    if (snapshot.exists) {
      String jsonString = snapshotToJsonString(snapshot.value.toString());
      Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      for (var room in json['rooms']) {
        Room newRoom = Room.fromJson(room);
        if (roomId == newRoom.roomId) {
          if (newRoom.users.length == 2) {
            return newRoom;
          }
        }
      }
    }
    return null;
  }

  Future<Character?> getOpponentCharacter(
      UserDb user, String currentUserId) async {
    Character character = _loader.characterList[user.character.id].duplicate();
    if (user.first == false) {
      character.setDirection('LEFT');
      character.setPosition(_constant.secondPlayerPosition);
      Player().character.setDirection('RIGHT');
      Player().character.setPosition(_constant.firstPlayerPosition);
    } else {
      character.setDirection('RIGHT');
      character.setPosition(_constant.firstPlayerPosition);
      Player().character.setDirection('LEFT');
      Player().character.setPosition(_constant.secondPlayerPosition);
    }
    return character;
  }

  Future<Room?> getRoom(roomId) async {
    Room? room = await waitOpponent(roomId);
    while (room == null) {
      Future.delayed(const Duration(milliseconds: 500));
      room = await waitOpponent(roomId);
    }
    return room;
  }

  Future<UserDb?> getOpponent(Room room, String currentUserId) async {
    for (var user in room.users) {
      if (user.userId != currentUserId) {
        return user;
      }
    }
    return null;
  }

  Future createGameRoom(Room room) async {
    DatabaseReference roomRef =
        FirebaseDatabase.instance.ref(room.roomId.toString());
    roomRef.set({
      room.users[0].userId: {
        'character': {
          'facing': room.users[0].character.facing,
          'health': room.users[0].character.health,
          'id': room.users[0].character.id,
          'upSpeed': room.users[0].character.upSpeed,
          'isMoving': room.users[0].character.isMoving.toString(),
          'attack': '',
        }
      },
      room.users[1].userId: {
        'character': {
          'facing': room.users[1].character.facing,
          'health': room.users[1].character.health,
          'id': room.users[1].character.id,
          'upSpeed': room.users[1].character.upSpeed,
          'isMoving': room.users[1].character.isMoving.toString(),
          'attack': '',
        }
      }
    });
  }

  void initListener(Room room, userId) {
    String id = '';
    if (room.users[0].userId == userId) {
      id = room.users[1].userId;
    } else {
      id = room.users[0].userId;
    }
    DatabaseReference listenFacing =
        FirebaseDatabase.instance.ref('${room.roomId}/$id/character/facing');
    listenFacing.onValue.listen((event) {
      var snapshot = event.snapshot;
      Stage().opponent!.character.setDirection(snapshot.value as String);
    });
    DatabaseReference listenMove =
        FirebaseDatabase.instance.ref('${room.roomId}/$id/character/isMoving');
    listenMove.onValue.listen((event) {
      var snapshot = event.snapshot;
      bool move = false;
      if ((snapshot.value as String) == 'true') {
        move = true;
      }
      Stage().opponent!.character.setMovement(move);
    });
    DatabaseReference listenJump =
        FirebaseDatabase.instance.ref('${room.roomId}/$id/character/upSpeed');
    listenJump.onValue.listen((event) {
      var snapshot = event.snapshot;
      Stage()
          .opponent!
          .character
          .setJumpSpeed(double.parse(snapshot.value as String));
    });
    DatabaseReference listenAttack =
        FirebaseDatabase.instance.ref('${room.roomId}/$id/character/attack');
    listenAttack.onValue.listen((event) {
      var snapshot = event.snapshot;
      switch (snapshot as String) {
        case 'dodge':
          Stage().opponent!.character.attack(dodge: true);
          break;
        case 'floor':
          Stage().opponent!.character.attack(floor: true);
          break;
        case 'quick':
          Stage().opponent!.character.attack(quick: true);
          break;
      }
    });
  }

  setMovement(bool move) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('${Stage().room.roomId}/${Auth().currentUser!.uid}/character');
    ref.update({"isMoving": move.toString()});
  }

  setJump(bool move) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('${Stage().room.roomId}/${Auth().currentUser!.uid}/character');
    ref.update({"isMoving": move.toString()});
  }

  setDirection(String facing) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('${Stage().room.roomId}/${Auth().currentUser!.uid}/character');
    ref.update({"facing": facing});
  }

  setAttack(String attack) async {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref('${Stage().room.roomId}/${Auth().currentUser!.uid}/character');
    ref.update({"attack": attack});
  }
}
