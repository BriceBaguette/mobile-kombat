import 'package:flutter/material.dart';

/*
* == Cosmetics ==================================================
*
* speedModification: int
* resistanceModification: int
* attackSpeedModification: int
* strengthModification: int
* bodyPart: char: H/B/F
* set: String
* price: int
*
*================================================================
*/
class Cosmetics extends StatelessWidget {
  final List<int>
      _modifiers; //0:speed / 1:resistance / 2:attack speed / 3:strength
  final String _spriteDir;
  final String _bodyPart;
  final String _set;
  final int _price;
  final String _name;
  bool _inventory;

  Cosmetics(this._name, this._modifiers, this._spriteDir, this._bodyPart,
      this._set, this._price, this._inventory,
      {super.key});

  List<int> getModifiers() {
    return _modifiers;
  }

  String getBodyPart(){
    return _bodyPart;
  }

  String getName(){
    return _name;
  }

  String getImage(){
    return _spriteDir;
  }

  String getSet(){
    return _set;
  }

  int getPrice(){
    return _price;
  }

  bool getInventory(){
    return _inventory;
  }

  void setInventory(){
    _inventory = true;
  }

  @override
  Widget build(BuildContext context){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 20,),
          Image.asset(_spriteDir, scale: 20),
          const SizedBox(width: 30,),
          Text(_name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const []
          )
        ],
    );
  }
}
