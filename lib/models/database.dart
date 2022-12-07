import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
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
              },
              {
                "userId": userId,
                "userName": _player.username,
                "character": jsonChar,
              }
            ]
          });
          return room.roomId;
        }
      }
    }
    print("create room");
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
    if (user.character.facing == 'LEFT') {
      character.setDirection('LEFT');
      character.setPosition(_constant.secondPlayerPosition);
      print(_constant.firstPlayerPosition);
      print(_constant.secondPlayerPosition);
    }
    return character;
  }

  Future<UserDb?> getOpponent(String roomId, String currentUserId) async {
    Room? room = await waitOpponent(roomId);
    while (room == null) {
      Future.delayed(const Duration(milliseconds: 500));
      room = await waitOpponent(roomId);
    }
    for (var user in room.users) {
      if (user.userId != currentUserId) {
        return user;
      }
    }
    return null;
  }
}
