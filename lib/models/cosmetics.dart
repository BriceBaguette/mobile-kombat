import 'package:flutter/material.dart';
import 'dart:ui' as ui;
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
  final ui.Image image;
  final int id;
  const Cosmetics(this._name, this._modifiers, this._spriteDir, this._bodyPart,
      this._set, this._price, this.image, this.id,
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



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 20),
        Image.asset(_spriteDir, width: 40),
        const SizedBox(width: 20),
        Text(_name),
        const SizedBox(width: 20)
      ],
    );
  }
}

class PopUpCosmetic extends StatelessWidget {
  const PopUpCosmetic({super.key, required this.c});
  final Cosmetics c;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(c.getImage(), width: 150,),
          Text("Set: ${c.getSet()}\n"
              "Speed: ${c.getModifiers()[0]}\n"
              "Resistance:${c.getModifiers()[1]}\n"
              "Attack Speed: ${c.getModifiers()[2]}\n"
              "Strength: ${c.getModifiers()[3]}\n"),
      ],
    ),
  );
}
}