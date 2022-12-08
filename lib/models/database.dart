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

import 'cosmetics.dart';

class Database {
  final db = FirebaseFirestore.instance;
  final Loader _loader = Loader();

  void addUser(UserCredential cred, String nickname) {
    List<int> characterShop = [1];
    List<int> cosmeticShop = [0,1,2];
    List<int> characterList = [0];
    List<int> cosmeticList = [];
    List<int> stats = [0,0,0,0,1,0];

    db
        .collection('users')
        .doc(cred.user!.uid)
        .set({'ownedCharacter': characterList,
              'nickname': nickname,
              'ownedCosmetic': cosmeticList,
              'gold': 0,
              'shopCharacter': characterShop,
              'shopCosmetic': cosmeticShop,
              'Statistics': stats});
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

  Future<List<Character>> getCharacterForShop(String userUid) async {
    List<Character> characters = [];
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    List<int> characterList = data!["shopCharacter"].cast<int>();
    for (int i in characterList) {
      characters.add(_loader.characterList[i]);//not that list
    }
    return characters;
  }

  getGoldFromUser(String userUid) async {
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    int gold = data!["gold"] as int;
    return gold;
  }
  updateGold(String userUid, int n) async {
    db.collection('users').doc(userUid).update({
      "gold" : FieldValue.increment(n),
    });
  }

  Future<List<Cosmetics>> getCosmeticFromUser(String userUid) async {
    List<Cosmetics> cosmetics = [];
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    List<int> cosmeticList = data!["ownedCosmetic"].cast<int>();
    for (int i in cosmeticList) {
      cosmetics.add(_loader.cosmeticList[i]);
    }
    return cosmetics;
  }

  Future<List<Cosmetics>> getCosmeticForShop(String userUid) async {
    List<Cosmetics> cosmetics = [];
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    List<int> cosmeticList = data!["shopCosmetic"].cast<int>();
    for (int i in cosmeticList) {
      cosmetics.add(_loader.cosmeticList[i]);
    }
    return cosmetics;
  }

  buyCosmetic(String userUid, int n) async {
    db.collection('users').doc(userUid).update({
      "ownedCosmetic" : FieldValue.arrayUnion(["$n"]),
    });
    db.collection('users').doc(userUid).update({
      "shopCosmetic" : FieldValue.arrayRemove(["$n"]),
    });
  }

  buyCharacter(String userUid, int n) async {
    db.collection('users').doc(userUid).update({
      "ownedCharacter" : FieldValue.arrayUnion(["$n"]),
    });
    db.collection('users').doc(userUid).update({
      "shopCharacter" : FieldValue.arrayRemove(["$n"]),
    });
  }

  updateStats(String userUid, int time, int tc1, int tc2, int gold, int nch, int nco) async {
    db.collection('users').doc(userUid).update(
        {"Statistics.0": FieldValue.increment(time)});
    db.collection('users').doc(userUid).update(
        {"Statistics.1": FieldValue.increment(tc1)});
    db.collection('users').doc(userUid).update(
        {"Statistics.2": FieldValue.increment(tc2)});
    db.collection('users').doc(userUid).update(
        {"Statistics.3": FieldValue.increment(gold)});
    db.collection('users').doc(userUid).update(
        {"Statistics.4": FieldValue.increment(nch)});
    db.collection('users').doc(userUid).update(
        {"Statistics.5": FieldValue.increment(nco)});
  }

  getStats(String userUid) async {
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    List<int> stats = data!["Statistics"].cast<int>();
    return stats;
  }
}


class RealTimeDB {
  final db = FirebaseDatabase.instance;
  final Loader _loader = Loader();
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final userDatabase = Database();
  final _player = Player();

  Future<String> createRoom(userId) async {
    CharacterDb character = CharacterDb.fromCharacter(_player.character);
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
      print(snapshot.value!.toString());
      Map<String, dynamic> json = jsonDecode(snapshot.value!.toString());
      print(json['rooms']);
      for (var room in json['rooms']) {
        print(room);
        rooms.add(Room.fromJson(room));
      }
    }
    return userId;
  }

  updateData() {}
}

