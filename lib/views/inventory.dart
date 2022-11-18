import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/cosmetics.dart';

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

  final Map<String, Cosmetics> equipped = {
    "H": Cosmetics(
        key: const ObjectKey('test1'),
        'test1',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        "F",
        "gen",
        100,
        true),
  };

  final List<Cosmetics> articles = [
    Cosmetics(
        key: const ObjectKey('test1'),
        'test1',
        const [1, 0, -1, 0],
        'assets/images/R.png',
        "H",
        "gen",
        100,
        true),
    Cosmetics(
        key: const ObjectKey('test2'),
        'test2',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        true),
    Cosmetics(
        key: const ObjectKey('test3'),
        'test3',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        true),
    Cosmetics(
        key: const ObjectKey('test4'),
        'test4',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        true),
    Cosmetics(
        key: const ObjectKey('test5'),
        'test5',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        true),
    Cosmetics(
        key: const ObjectKey('test6'),
        'test6',
        const [0, 0, 0, 0],
        'assets/images/R.png',
        'H',
        "gen",
        100,
        true),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: Row(children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).popAndPushNamed('menu');
              });
            },
            tooltip: 'Inventory',
          ),
        ]),
        actions: const [],
        title: const Text("Inventory"),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (equipped['H'] == null)
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      border: Border.all(
                        color: Colors.blueGrey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset(
                      'assets/images/R.png',
                      scale: 2.5,
                      color: Colors.blueGrey.withOpacity(0.5),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  )
                else
                  Container(
                    alignment: AlignmentDirectional.center,
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      border: Border.all(
                        color: Colors.blueGrey.shade300,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset(
                      equipped['H']?.getImage() ?? "",
                      scale: 10,
                    ),
                  ),
                if (equipped['B'] == null)
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        border: Border.all(
                          color: Colors.blueGrey.shade300,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Image.asset(
                      'assets/images/2806248.png',
                      scale: 2.5,
                      color: Colors.blueGrey.withOpacity(0.5),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  )
                else
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        border: Border.all(
                          color: Colors.blueGrey.shade300,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Image.asset(
                      equipped['B']?.getImage() ?? "",
                      scale: 10,
                    ),
                  ),
                if (equipped['F'] == null)
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        border: Border.all(
                          color: Colors.blueGrey.shade300,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Image.asset(
                      'assets/images/919490.png',
                      scale: 10,
                      color: Colors.blueGrey.withOpacity(0.5),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  )
                else
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        border: Border.all(
                          color: Colors.blueGrey.shade300,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Image.asset(
                      equipped['F']?.getImage() ?? "",
                      scale: 10,
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 350,
              child: Expanded(
                child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Center(
                                          child:
                                              Text(articles[index].getName())),
                                      content: Row(
                                        children: [
                                          Image.asset(
                                              articles[index].getImage()),
                                          Text(
                                              "Set: ${articles[index].getSet()}\n"
                                              "Speed: ${articles[index].getModifiers()[0]}\n"
                                              "Resistance:${articles[index].getModifiers()[1]}\n"
                                              "Attack Speed: ${articles[index].getModifiers()[2]}\n"
                                              "Strength: ${articles[index].getModifiers()[3]}"),
                                        ], //0:speed / 1:resistance / 2:attack speed / 3:strength
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _equipping(articles[index], index);
                                          },
                                          child: const Text('Equip'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueGrey.shade300,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (articles[index].key !=
                                        equipped[articles[index].getBodyPart()]
                                            ?.key) ...[
                                      articles[index],
                                      ElevatedButton(
                                        child: const Text('Equip'),
                                        onPressed: () {
                                          _equipping(articles[index], index);
                                        },
                                      ),
                                    ] else ...[
                                      articles[index],
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightGreen),
                                        child: const Text('Unequip'),
                                        onPressed: () {
                                          _equipping(articles[index], index);
                                        },
                                      ),
                                    ]
                                  ],
                                ),
                              )));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _equipping(Cosmetics c, int index) {
    /*String _dir = c.getImage();
    String _bp = c.getBodyPart();
    if (equipped[_bp] != null) {
      //unequip(old)
    }
    equipped[_bp] = c;*/
    /*switch(_bp){
      case 'H':
        //update upper widget
        //notify
        break;
      case 'B':
      //update middle widget
        break;
      case 'F':
      //update lower widget
        break;
    }*/
  }

  /*void _unequipping(Cosmetics c, int index) {

  }*/

}
