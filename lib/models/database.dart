import 'dart:core';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/loader.dart';

class Database {
  final db = FirebaseFirestore.instance;

  final Loader _loader = Loader();
  void addUser(UserCredential cred) {
    List<int> _characterList = [];
    _characterList.add(0);
    db
        .collection('users')
        .doc(cred.user!.uid)
        .set({'ownedCharacter': _characterList});
  }

  getCharacterFromUser(String userUid) async {
    List<Character> characters = [];
    var docSnap = await db.collection('users').doc(userUid).get();
    var data = docSnap.data();
    List<int> characterList = data!["ownedCharacter"].cast<int>();
    for (int i in characterList) {
      characters.add(_loader.characterList[i]);
    }
    return characters;
  }
}
