import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:mobile_kombat/controller_inventory.dart';
import '../models/cosmetics.dart';
import '../models/character.dart';
import '../views/shop.dart';
import '../models/constant.dart';
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
* => onWillAccept check HBF avec la dragTarget
*
* ===============================================================
*/

class Inventory extends StatelessWidget {
  static const List<String> _tab = ["H", "B", "F"];

  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          toolbarHeight: 40,
          leading: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).popAndPushNamed('menu');
              },
              tooltip: 'Inventory',
            ),
          ]),
          actions: const [],
          title: const Text("Inventory"),
          centerTitle: true,
        ),
        body: Consumer<ControllerInventory>(
          builder: (_, data, __) => Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Center(
                                      child: Text(
                                          data.getEquippedChar().getName())),
                                  content:
                                      PopUpShopChar(c: data.getEquippedChar()),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChangingCharacters()),
                                        );
                                      },
                                      child: const Text('Change character'),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(data.getEquippedChar().getName()),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 80,
                                  left: 30,
                                  child: Image.asset(
                                      data.getEquippedChar().getImageDir(),
                                      height: 150),
                                ),
                                if (data.getEquippedItems()["H"] != null) ...[
                                  Positioned(
                                    top: 45,
                                    right: 66,
                                    child: Image.asset(
                                        data
                                                .getEquippedItems()["H"]
                                                ?.getImage() ??
                                            "",
                                        height: 80),
                                  ),
                                ],
                                if (data.getEquippedItems()["F"] != null) ...[
                                  Positioned(
                                    top: 170,
                                    right: 80,
                                    child: Image.asset(
                                      data
                                              .getEquippedItems()["F"]
                                              ?.getImage() ??
                                          "",
                                      scale: 10.5,
                                    ),
                                  ),
                                ],
                                if (data.getEquippedItems()["B"] != null) ...[
                                  Positioned(
                                    top: 128,
                                    right: 73,
                                    child: Image.asset(
                                      data
                                              .getEquippedItems()["B"]
                                              ?.getImage() ??
                                          "",
                                      scale: 8,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (data.getEquippedItems()['H'] == null) ...[
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade200,
                          border: Border.all(
                            color: Colors.blueGrey.shade300,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Image.asset(
                          'assets/images/ClassyHat.png',
                          scale: 2.5,
                          color: Colors.blueGrey.withOpacity(0.5),
                          colorBlendMode: BlendMode.modulate,
                        ),
                      )
                    ] else ...[
                      Container(
                        alignment: AlignmentDirectional.center,
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade200,
                          border: Border.all(
                            color: Colors.blueGrey.shade300,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Image.asset(
                          data.getEquippedItems()['H']?.getImage() ?? "",
                          scale: 10,
                        ),
                      )
                    ],
                    if (data.getEquippedItems()['B'] == null)
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
                          'assets/images/TShirt.png',
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
                          data.getEquippedItems()['B']?.getImage() ?? "",
                          scale: 10,
                        ),
                      ),
                    if (data.getEquippedItems()['F'] == null)
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
                          'assets/images/Short.png',
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
                          data.getEquippedItems()['F']?.getImage() ?? "",
                          scale: 10,
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  width: 350,
                  child: SizedBox(
                    child: ListView.builder(
                        itemCount: data.getItemsInv().length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Center(
                                              child: Text(data
                                                  .getItemsInv()[index]
                                                  .getName())),
                                          content: Row(
                                            children: [
                                              Image.asset(data
                                                  .getItemsInv()[index]
                                                  .getImage()),
                                              Text(
                                                  "Set: ${data.getItemsInv()[index].getSet()}\n"
                                                  "Speed: ${data.getItemsInv()[index].getModifiers()[0]}\n"
                                                  "Resistance:${data.getItemsInv()[index].getModifiers()[1]}\n"
                                                  "Attack Speed: ${data.getItemsInv()[index].getModifiers()[2]}\n"
                                                  "Strength: ${data.getItemsInv()[index].getModifiers()[3]}"),
                                            ], //0:speed / 1:resistance / 2:attack speed / 3:strength
                                          ),
                                          actions: [
                                            if (data.getItemsInv()[index].key !=
                                                data
                                                    .getEquippedItems()[data
                                                        .getItemsInv()[index]
                                                        .getBodyPart()]
                                                    ?.key) ...[
                                              ElevatedButton(
                                                onPressed: () {
                                                  data.equipItem(data
                                                      .getItemsInv()[index]);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Equip'),
                                              ),
                                            ] else ...[
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.lightGreen),
                                                onPressed: () {
                                                  data.unequipItem(data
                                                      .getItemsInv()[index]);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Unequip'),
                                              ),
                                            ],
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (data.getItemsInv()[index].key !=
                                            data
                                                .getEquippedItems()[data
                                                    .getItemsInv()[index]
                                                    .getBodyPart()]
                                                ?.key) ...[
                                          data.getItemsInv()[index],
                                          ElevatedButton(
                                            child: const Text('Equip'),
                                            onPressed: () {
                                              data.equipItem(
                                                  data.getItemsInv()[index]);
                                            },
                                          ),
                                        ] else ...[
                                          data.getItemsInv()[index],
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.lightGreen),
                                            child: const Text('Unequip'),
                                            onPressed: () {
                                              data.unequipItem(
                                                  data.getItemsInv()[index]);
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
        ));
  }
}

class ChangingCharacters extends StatelessWidget {
  const ChangingCharacters({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          toolbarHeight: 40,
          leading: Row(children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: 'changingcharacters',
            ),
          ]),
          actions: const [],
          title: const Text("Characters owned"),
          centerTitle: true,
        ),
        body: Consumer<ControllerInventory>(
            builder: (_, data, __) => Center(
                    child: Column(children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width - 10,
                      child: ListView.builder(
                          itemCount: data.getItemsInvChar().length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Center(
                                                child: Text(data
                                                    .getItemsInvChar()[index]
                                                    .getName())),
                                            content: PopUpShopChar(
                                                c: data
                                                    .getItemsInvChar()[index]),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  data.equipChar(
                                                      data.getItemsInvChar()[
                                                          index]);
                                                  Navigator.of(context).pop();
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
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blueGrey.shade300,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CharacterWidget(
                                              c: data.getItemsInvChar()[index]),
                                          //Make widget for character
                                          ElevatedButton(
                                            onPressed: () {
                                              data.equipChar(data
                                                  .getItemsInvChar()[index]);
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Equip'),
                                          ),
                                        ],
                                      ),
                                    )));
                          }))
                ]))));
  }
}
