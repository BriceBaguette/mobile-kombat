import 'package:flutter/cupertino.dart';

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/cosmetics.dart';

class ControllerInventory extends ChangeNotifier {
  final List<Cosmetics> _articlesCosmetics = [
    Cosmetics(key: const ObjectKey('test1'), 'test1', const [1, 0, -1, 0], 'assets/images/ClassyHat.png', "H", "gen", 100, false),
    Cosmetics(key: const ObjectKey('test2'), 'test2', const [0, 0, -1, 0], 'assets/images/GenericGuy.png', "H", "gen", 100, false),
    Cosmetics(key: const ObjectKey('test3'), 'test3', const [2, 0, 0, 0], 'assets/images/hawaiian-shirt.png', "B", "gen", 100, false),
    Cosmetics(key: const ObjectKey('test4'), 'test4', const [1, 1, -2, 0], 'assets/images/swimwear.png', "F", "gen", 100, false),

  ]; //get shop from Firebase
  final List<Cosmetics> _itemsInvCosmetics = []; // get inventory from Firebase
  final Map<String, Cosmetics> _equippedCosmetics = {}; //get equipped from Firebase

  final List<Character> _articlesCharacters = []; //get shop from Firebase
  final List<Character> _itemsInvChar = []; // get inventory from Firebase
  //static Character _equippedChar = StickMan(image: image, bbox: bbox, speed: speed, facing: facing, mainAbImage: mainAbImage); //get equipped from Firebase

  List<Cosmetics> getArticlesCosmetics(){
    return _articlesCosmetics;
  }
  List<Cosmetics> getItemsInv(){
    return _itemsInvCosmetics;
  }
  Map<String, Cosmetics> getEquippedItems(){
    return _equippedCosmetics;
  }

  List<Character> getArticlesChar(){
    return _articlesCharacters;
  }
  List<Character> getItemsInvChar(){
    return _itemsInvChar;
  }
  /*Character getEquippedChar(){
    return _equippedChar;
  }*/

  void addItem(Cosmetics c){
    _itemsInvCosmetics.add(c);
    // add to Firebase inventory
    // +1 to cosmetics count
    notifyListeners();
  }
  void deleteArticle(index){
    _articlesCosmetics.removeAt(index);
    // remove from firebase shop
    notifyListeners();
  }
  void equipItem(Cosmetics c){
    String bp = c.getBodyPart();
    if (_equippedCosmetics[bp] != null) {
      unequipItem(_equippedCosmetics[bp]!);
    }
    _equippedCosmetics[bp] = c;
    //update firebase equipped
    notifyListeners();
  }
  void unequipItem(Cosmetics c){
    String bp = c.getBodyPart();
    _equippedCosmetics.remove(bp);
    //remove from Firebase equipped
    notifyListeners();
  }

  void addItemChar(StickMan c){
    _itemsInvChar.add(c);
    // add to Firebase inventory
    // +1 to cosmetics count
    notifyListeners();
  }
  void deleteArticleChar(index){
    _articlesCharacters.removeAt(index);
    // remove from firebase shop
    notifyListeners();

  }
  /*void equipChar(StickMan c){
    _equippedChar = c;
    //update firebase equipped
    notifyListeners();
  }
*/

}