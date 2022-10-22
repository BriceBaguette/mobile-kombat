import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ffi';

import 'cosmetics.dart';
import 'characters.dart';

/*
*== Inventory ===================================================
*
* Get List from firebase
* onclick show stats/abilities etc
* If equipped
*   unequip option
* else
*   equip option
* (maybe drag n drop if not too complicated)
*
* ===============================================================
*/

class Inventory extends StatelessWidget {
  Inventory({super.key});

  final List<Widget> articles = [
    Cosmetics('test1', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test2', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test3', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test4', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test5', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test6', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test7', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test8', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test9', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test10', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test11', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
    Cosmetics('test12', [0,0,0], 'assets/images/R.png', 'H', "gen", 100),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: Container(
          child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pop(context,);
                  },
                  tooltip: 'Inventory',
                ),
              ]
          ),
        ),
        actions: [],
        title: Text("Inventory"),
        centerTitle: true,


      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Text("GenericName1"), Image.asset('assets/images/10522.png'), Container()],
                )),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Container(
                alignment: AlignmentDirectional.center,
                height:80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade200,
                  border: Border.all(
                    color: Colors.blueGrey.shade300,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  'hi',
                  style: Theme.of(context).textTheme.headline4,
                  textScaleFactor: 0.8,
                  textAlign: TextAlign.center,

                ),
              ),
                Container(
                  height:80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      border: Border.all(
                        color: Colors.blueGrey.shade300,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Image.asset('assets/images/2806248.png',scale: 2.5, color: Colors.blueGrey.withOpacity(0.5), colorBlendMode: BlendMode.modulate,),
                ),
                Container(
                  height:80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      border: Border.all(
                        color: Colors.blueGrey.shade300,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Image.asset('assets/images/919490.png',scale: 10, color: Colors.blueGrey.withOpacity(0.5), colorBlendMode: BlendMode.modulate,),
                ),
              ],

            ),
            Container(
              width: 350,
              child:
              Expanded(
                  child: ListView(
                    children: articles,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
/*
* ==Sandbox======================================================
* Testing stuff and ideas
* ===============================================================
*/

/*class _Inventory{
  List<Cosmetics> _cosmeticlist = [];
  List<Characters> _characterlist = [];

  void updateInventory(){
    _cosmeticlist = [];//get firebase cosmeticList
    _characterlist = [];//get firebase characterList
  }

  void equip(Cosmetics cosm, Characters hero){
    List<int> newherostats = [];
    List<int> stats = hero.getStats();
    List<int> mod = cosm.getModifiers();
    for(int i=0; i<stats.length; i++){
      newherostats[i] = stats[i]*mod[i];
    }
    hero.setStats(newherostats);
  }

  void unequip(Cosmetics cosm, Characters hero){
    List<int> newherostats = [];
    List<int> stats = hero.getStats();
    List<int> mod = cosm.getModifiers();
    for(int i=0; i<stats.length; i++){
      newherostats[i] = stats[i]*mod[i];
    }
    hero.setStats(newherostats);
  }

  void changeCharacter(Characters oldhero, Characters newhero){
    oldhero.reset();
    //select newhero
  }
}
*/