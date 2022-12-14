import 'package:flutter/cupertino.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/cosmetics.dart';
import 'models/auth.dart';
import 'models/database.dart';
import 'models/player.dart';

class ControllerInventory extends ChangeNotifier {
  final Map<String, Cosmetics> _equippedCosmetics = {};
  int _gold = 0;
  double _totalTimePlayed = 0;
  double _timePlayedAsChar1 = 0;
  double _timePlayedAsChar2 = 0;
  int _totalGold = 0;
  int _numberCosmetic = 0;
  int _numberCharacter = 1;
  List<Character> _articlesCharacters = [];
  List<Character> _itemsInvChar = [];
  List<Cosmetics> _articlesCosmetics = [];
  List<Cosmetics> _itemsInvCosmetics = [];
  static Character _equippedChar = Player().character;



  Future init() async {
    _gold = await Database().getGoldFromUser(Auth().currentUser!.uid);
    _itemsInvChar =
    await Database().getCharacterFromUser(Auth().currentUser!.uid);
    _articlesCharacters =
    await Database().getCharacterForShop(Auth().currentUser!.uid);
    _articlesCosmetics =
    await Database().getCosmeticForShop(Auth().currentUser!.uid);
    _itemsInvCosmetics =
    await Database().getCosmeticFromUser(Auth().currentUser!.uid);
    Player().setGoldPlayer(_gold);
    List<int> stats = await Database().getStats(Auth().currentUser!.uid);
    _totalTimePlayed = stats[0].toDouble();
    _timePlayedAsChar1 = stats[1].toDouble();
    _timePlayedAsChar2 = stats[2].toDouble();
    _totalGold = stats[3];
    _numberCosmetic = stats[4];
    _numberCharacter = stats[5];

  }

  List<Cosmetics> getArticlesCosmetics() {
    return _articlesCosmetics;
  }

  List<Cosmetics> getItemsInv() {
    return _itemsInvCosmetics;
  }

  Map<String, Cosmetics> getEquippedItems() {
    return _equippedCosmetics;
  }

  List<Character> getArticlesChar() {
    return _articlesCharacters;
  }

  List<Character> getItemsInvChar() {
    return _itemsInvChar;
  }

  Character getEquippedChar() {
    return _equippedChar;
  }

  int getGold() {
    return _gold;
  }

  double getTotTime(){
    return _totalTimePlayed;
  }
  double getTimeChar1() {
    return _timePlayedAsChar1;
  }
  double getTimeChar2() {
    return _timePlayedAsChar2;
  }
  int getTotGold() {
    return _totalGold;
  }
  int getNumCosm(){
    return _numberCosmetic;
  }
  int getNumChar(){
    return _numberCharacter;
  }

  void updateTotTime(double n){
    _totalTimePlayed += n;
  }
  void updateTimeChar1(double n) {
    _timePlayedAsChar1 += n;
  }
  void updateTimeChar2(double n) {
    _timePlayedAsChar2 += n;
  }
  void updateTotGold(int n) {
    _totalGold += n;
  }
  void updateNumCosm(){
    _numberCosmetic += 1;
  }
  void updateNumChar(){
    _numberCharacter += 1;
  }

  void updateGold(int mod) async {
    _gold = _gold + mod;
    if(mod>0){
      _totalGold += mod;
    }
    await Database().updateGold(Auth().currentUser!.uid, mod);
    notifyListeners();
  }

  void addItem(Cosmetics c) async {
    _itemsInvCosmetics.add(c);
    await Database().buyCosmetic(Auth().currentUser!.uid, c.id);
    _numberCosmetic += 1;
    await Database().updateStats(Auth().currentUser!.uid, 0, 0, 0, 0, 0, 1);
    notifyListeners();
  }

  void deleteArticle(index) {
    _articlesCosmetics.removeAt(index);
    notifyListeners();
  }

  void addStat(Cosmetics c) {
    _equippedChar.setStrength(c.getModifiers()[3]);
    _equippedChar.setResistance(c.getModifiers()[1]);
    _equippedChar.setSpeed(c.getModifiers()[0]);
    _equippedChar.setAS(c.getModifiers()[2]);
  }

  void removeStat(Cosmetics c) {
    _equippedChar.setStrength(-c.getModifiers()[3]);
    _equippedChar.setResistance(-c.getModifiers()[1]);
    _equippedChar.setSpeed(-c.getModifiers()[0]);
    _equippedChar.setAS(-c.getModifiers()[2]);
  }

  void equipItem(Cosmetics c) {
    String bp = c.getBodyPart();
    if (_equippedCosmetics[bp] != null) {
      removeStat(_equippedCosmetics[bp]!);
      unequipItem(_equippedCosmetics[bp]!);
    }
    _equippedCosmetics[bp] = c;
    _equippedChar.equipCosmetic(c);
    addStat(_equippedCosmetics[bp]!);
    notifyListeners();
  }

  void unequipItem(Cosmetics c) {
    String bp = c.getBodyPart();
    removeStat(_equippedCosmetics[bp]!);
    _equippedCosmetics.remove(bp);
    _equippedChar.removeCosmetic(bp);
    notifyListeners();
  }

  void updateTimeStat(Character c, time) async {
    int id = c.id;
    updateTotTime(time/1000);
    if (id == 0) {
      updateTimeChar1(time/1000);
      await Database().updateStats(
          Auth().currentUser!.uid,
          time/1000,
          time/1000,
          0,
          0,
          0,
          0);
    }else {
      updateTimeChar2(time/1000);
      await Database().updateStats(
          Auth().currentUser!.uid,
          time/1000,
          0,
          time/1000,
          0,
          0,
          0);
    }
  }

  void addItemChar(Character c) async {
    _itemsInvChar.add(c);
    await Database().buyCharacter(Auth().currentUser!.uid, c.id);
    _numberCharacter += 1;
    await Database().updateStats(Auth().currentUser!.uid, 0, 0, 0, 0, 1, 0);
    notifyListeners();
  }

  void deleteArticleChar(index) {
    _articlesCharacters.removeAt(index);
    notifyListeners();
  }

  void equipChar(Character c) {
    _equippedCosmetics.remove("H");
    _equippedCosmetics.remove("B");
    _equippedCosmetics.remove("F");
    _equippedChar.removeCosmetic("H");
    _equippedChar.removeCosmetic("B");
    _equippedChar.removeCosmetic("F");
    _equippedChar = c;
    Player().setCharacter(c);
    notifyListeners();
  }
}
