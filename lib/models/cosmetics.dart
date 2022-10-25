import 'package:flutter/material.dart';

/*
* == Cosmetics ==================================================
*
* speedModification: int
* resistanceModification: int
* attackSpeedModification: int
* strengthModification: int
* bodypart: char: H/B/F
* set: String
* price: int
*
*================================================================
*/
class Cosmetics extends StatelessWidget{
  late List<int> _modifiers;//0:speed / 1:resistance / 2:attack speed / 3:strength
  late String _spriteDir;
  late String _bodypart;
  late String _set;
  late int _price;
  late String _name;

  Cosmetics(this. _name, this._modifiers, this._spriteDir, this._bodypart, this._set, this._price);

  List<int> getModifiers(){
    return _modifiers;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey.shade300,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Image.asset(_spriteDir, scale: 20),
          Text(_name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('$_price   '),
              Image.asset('assets/images/2152687.png', scale: 5),
              Text('      '),
            ],
          )
        ],
      ),
    );
  }
}
