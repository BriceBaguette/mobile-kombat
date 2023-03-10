import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_kombat/models/auth.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/cosmetics.dart';
import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/room.dart';

class Database {
  final db = FirebaseFirestore.instance;

  final Loader _loader = Loader();
  void addUser(UserCredential cred, String nickname) {
    List<int> characterShop = [1];
    List<int> cosmeticShop = [0, 1, 2, 3];
    List<int> characterList = [0];
    List<int> cosmeticList = [];
    List<int> stats = [0, 0, 0, 0, 1, 0];

    db.collection('users').doc(cred.user!.uid).set({
      'ownedCharacter': characterList,
      'nickname': nickname,
      'ownedCosmetic': cosmeticList,
      'gold': 800,
      'shopCharacter': characterShop,
      'shopCosmetic': cosmeticShop,
      'NumChar': 1,
      'NumCosm': 0,
      'TotalGold': 800,
      'TotalTime': 0,
      'TotalTimeChar1': 0,
      'TotalTimeChar2': 0,
    });
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
    List<int> characterList = data!['shopCharacter'].cast<int>();
    for (int i in characterList) {
      characters.add(_loader.characterList[i]); //not that list
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
      "gold": FieldValue.increment(n),
    });
    if (n > 0) {
      updateStats(userUid, 0, 0, 0, n, 0, 0);
    }
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
      "ownedCosmetic": FieldValue.arrayUnion([n]),
    });
    db.collection('users').doc(userUid).update({
      "shopCosmetic": FieldValue.arrayRemove([n]),
    });
  }

  buyCharacter(String userUid, int n) async {
    db.collection('users').doc(userUid).update({
      "ownedCharacter": FieldValue.arrayUnion([n]),
    });
    db.collection('users').doc(userUid).update({
      "shopCharacter": FieldValue.arrayRemove([n]),
    });
  }

  updateStats(String userUid, double time, double tc1, double tc2, int gold,
      int nch, int nco) async {
    db
        .collection('users')
        .doc(userUid)
        .update({"TotalTime": FieldValue.increment(time)});
    db
        .collection('users')
        .doc(userUid)
        .update({"TotalTimeChar1": FieldValue.increment(tc1)});
    db
        .collection('users')
        .doc(userUid)
        .update({"TotalTimeChar2": FieldValue.increment(tc2)});
    db
        .collection('users')
        .doc(userUid)
        .update({"TotalGold": FieldValue.increment(gold)});
    db
        .collection('users')
        .doc(userUid)
        .update({"NumChar": FieldValue.increment(nch)});
    db
        .collection('users')
        .doc(userUid)
        .update({"NumCosm": FieldValue.increment(nco)});
  }

  Future<List<int>> getStats(String userUid) async {
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    List<int> stats = [];
    stats.add(data!["TotalTime"].toInt());
    stats.add(data["TotalTimeChar1"].toInt());
    stats.add(data["TotalTimeChar2"].toInt());
    stats.add(data["TotalGold"].toInt());
    stats.add(data["NumCosm"].toInt());
    stats.add(data["NumChar"].toInt());
    return stats;
  }
}

class RealTimeDB {
  final Constant _constant = Constant();
  final db = FirebaseDatabase.instance;
  final Loader _loader = Loader();
  DatabaseReference ref = FirebaseDatabase.instance.ref('newRoom');
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
      print(snapshot.value);
      String jsonString = snapshotToJsonString(snapshot.value.toString());
      Map<String, dynamic> json =
          jsonDecode(jsonString) as Map<String, dynamic>;
      print(json);
      for (var room in json['rooms']) {
        rooms.add(Room.fromJson(room));
      }
      for (Room room in rooms) {
        print(room);
        if ((room.users.length < 2)) {
          var index = rooms.indexOf(room);
          DatabaseReference refRoom =
              FirebaseDatabase.instance.ref('/newRoom/rooms/$index');
          var jsonChar = jsonEncode(
              CharacterDb.fromCharacter(_player.character, second: true));
          print("update");
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
          print('done');
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
      _player.character.setDirection('RIGHT');
      _player.character.setMovement(false);
      _player.character.setPosition(_constant.firstPlayerPosition);
    } else {
      character.setDirection('RIGHT');
      character.setPosition(_constant.firstPlayerPosition);
      _player.character.setDirection('LEFT');
      _player.character.setMovement(false);
      _player.character.setPosition(_constant.secondPlayerPosition);
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
          'left': room.users[0].character.left,
          'top': room.users[0].character.top,
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
          'left': room.users[1].character.left,
          'top': room.users[1].character.top,
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
      double jumpSpeed = double.parse(snapshot.value as String);
      Stage().opponent!.character.setJumpSpeed(jumpSpeed);
    });
    DatabaseReference listenAttack =
        FirebaseDatabase.instance.ref('${room.roomId}/$id/character/attack');
    listenAttack.onValue.listen((event) {
      var snapshot = event.snapshot;
      switch (snapshot.value as String) {
        case 'dodge':
          Stage().opponent!.character.attack(dodge: true);
          break;
        case 'normal':
          Stage().opponent!.character.attack();
          break;
        case 'quick':
          Stage().opponent!.character.attack(quick: true);
          break;
      }
    });
    DatabaseReference listenLeft =
        FirebaseDatabase.instance.ref('${room.roomId}/$id/character/left');
    listenLeft.onValue.listen((event) {
      var snapshot = event.snapshot;
      double left = double.parse(snapshot.value as String);
      Rect hitbox = Stage().opponent!.character.getHitBox();
      Stage().opponent!.character.setPosition(
          Rect.fromLTWH(left, hitbox.top, hitbox.width, hitbox.height));
    });
    DatabaseReference listenTop =
        FirebaseDatabase.instance.ref('${room.roomId}/$id/character/top');

    listenTop.onValue.listen((event) {
      var snapshot = event.snapshot;
      double top = double.parse(snapshot.value as String);
      Rect hitbox = Stage().opponent!.character.getHitBox();
      Stage().opponent!.character.setPosition(
          Rect.fromLTWH(hitbox.left, top, hitbox.width, hitbox.height));
    });
  }

  setMovement(bool move) async {
    if (Stage().room != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref('${Stage().room!.roomId}/${Auth().currentUser!.uid}/character');
      ref.update({"isMoving": move.toString()});
    }
  }

  setJump(int jump) async {
    if (Stage().room != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref('${Stage().room!.roomId}/${Auth().currentUser!.uid}/character');
      await ref.update({"upSpeed": "0"});
      ref.update({"upSpeed": jump.toString()});
    }
  }

  setDirection(String facing) async {
    if (Stage().room != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref('${Stage().room!.roomId}/${Auth().currentUser!.uid}/character');
      ref.update({"facing": facing});
    }
  }

  setAttack(String attack) async {
    if (Stage().room != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref('${Stage().room!.roomId}/${Auth().currentUser!.uid}/character');
      ref.update({"attack": attack});
      Future.delayed(const Duration(milliseconds: 10));
      ref.update({"attack": ''});
    }
  }

  setHealth(int health) async {
    if (Stage().room != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref('${Stage().room!.roomId}/${Auth().currentUser!.uid}/character');
      ref.update({"health": health});
    }
  }

  setPosition(Rect hitBox) async {
    if (Stage().room != null) {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref('${Stage().room!.roomId}/${Auth().currentUser!.uid}/character');
      ref.update({"left": hitBox.left});
      ref.update({"top": hitBox.top});
    }
  }
}
