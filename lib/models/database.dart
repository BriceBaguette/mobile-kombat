import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/room.dart';

class Database {
  final db = FirebaseFirestore.instance;

  final Loader _loader = Loader();
  void addUser(UserCredential cred, String nickname) {
    List<int> _characterList = [];
    _characterList.add(0);
    db
        .collection('users')
        .doc(cred.user!.uid)
        .set({'ownedCharacter': _characterList, 'nickname': nickname});
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
    return data!["nickname"].cast<String>();
  }
}

class RealTimeDB {
  final db = FirebaseDatabase.instance;
  final Loader _loader = Loader();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final userDatabase = Database();
  final _player = Player();

  Future createRoom(userId) async {
    await ref.set({
      "rooms": [
        {
          "roomId": userId,
          "users": [
            {
              "userId": userId,
              "userName": _player.username,
              "character":
                  jsonEncode(CharacterDb.fromCharacter(_player.character)),
            }
          ]
        }
      ]
    });
  }

  Future joinRoom(userId) async {
    List<Room> rooms = [];
    final snapshot = await ref.get();
    print(snapshot);
    if (snapshot.exists) {
      Map<String, dynamic> json = snapshot.value! as Map<String, dynamic>;
      for (var room in json['rooms']) {
        rooms.add(Room.fromJson(room));
      }
    }
    print(rooms);
  }

  updateData() {}
}
