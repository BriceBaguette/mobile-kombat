import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/*
import 'dart:ffi';
*/
import 'package:mobile_kombat/models/cosmetics.dart';
/*
import 'characters.dart';
import 'inventory.dart';
*/

/*
*== SHOP ========================================================
*
* When buying check list of already bought items/characters(abi)
* If not in the list
*   possibility to check stats modifiers etc/or abilities
*   buying option
*   if buy
*     update firebase
*     update abi using firebase
*   else return to the list
* else
*   green "V"
*   "already bought" message
*
* ===============================================================
*/

class Shop extends StatelessWidget {
  Shop({super.key});

  final List<Cosmetics> articles = [
    Cosmetics(
        key: const ObjectKey('test1'),
        'test1',
        const [1, 0, -1, 0],
        'assets/images/R.png',
        "H",
        "gen",
        100,
        false),
    Cosmetics(
        key: const ObjectKey('test2'),
        'test2',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        false),
    Cosmetics(
        key: const ObjectKey('test3'),
        'test3',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        false),
    Cosmetics(
        key: const ObjectKey('test4'),
        'test4',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        false),
    Cosmetics(
        key: const ObjectKey('test5'),
        'test5',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        false),
    Cosmetics(
        key: const ObjectKey('test6'),
        'test6',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        false),
    Cosmetics(
        key: const ObjectKey('test7'),
        'test7',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        false),
    Cosmetics(
        key: const ObjectKey('test8'),
        'test8',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        false),
  ];


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(context,);
                },
                tooltip: 'Shop',
              ),
            ]
        ),
        actions: const [],
        title: const Text("Shop"),
        centerTitle: true,


      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
                width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("GenericName1"),
                    Image.asset('assets/images/10522.png'),
                    Container()
                  ],
                )),
            SizedBox(
              width: 350,
              child:
              Expanded(
                child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Center(child: Text(articles[index].getName())),
                                  content: Padding(padding: const EdgeInsets.all(10), child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(articles[index].getImage()),
                                      Text("Set: ${articles[index].getSet()}\n"
                                          "Speed: ${articles[index].getModifiers()[0]}\n"
                                          "Resistance:${articles[index].getModifiers()[1]}\n"
                                          "Attack Speed: ${articles[index].getModifiers()[2]}\n"
                                          "Strength: ${articles[index].getModifiers()[3]}\n"),
                                    ],
                                  ),),
                                  actions: [
                                    Text("Price: ${articles[index].getPrice()}"),
                                    Image.asset("assets/images/2152687.png", scale: 5,),
                                    const SizedBox(width: 40,),
                                    ElevatedButton(
                                      onPressed: () {
                                        _buy(articles[index]);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Buy'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                )
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueGrey.shade300,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child:
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                      articles[index],
                                      Text(articles[index].getPrice().toString()),
                                      Image.asset("assets/images/2152687.png", scale: 5),
                                      ElevatedButton(
                                        child: const Text('Buy'),
                                        onPressed: () {
                                          _buy(articles[index]);
                                        },
                                      ),
                                  ],
                                ),
                              )
                          )
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buy(Cosmetics c){}
}
/*
* ==Sandbox======================================================
* Testing stuff and ideas
* ===============================================================
*/
