import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:mobile_kombat/controller_inventory.dart';

import '../models/cosmetics.dart';
import '../models/character.dart';

import '../views/changing_characters.dart';

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
  static int k = 0;
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
          builder: (_, val, __) => Center(
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
                                          val.getEquippedChar().getName())),
                                  content: PopUpChar(c: val.getEquippedChar()),
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
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(val.getEquippedChar().getName(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 80,
                                  left: 30,
                                  child: Image.asset(
                                      val.getEquippedChar().getImageDir(),
                                      height: 150),
                                ),
                                if (val.getEquippedItems()["H"] != null) ...[
                                  Positioned(
                                    top: 45,
                                    right: 66,
                                    child: Image.asset(
                                        val
                                                .getEquippedItems()["H"]
                                                ?.getImage() ??
                                            "",
                                        height: 80),
                                  ),
                                ],
                                if (val.getEquippedItems()["F"] != null) ...[
                                  Positioned(
                                    top: 170,
                                    right: 80,
                                    child: Image.asset(
                                      val.getEquippedItems()["F"]?.getImage() ??
                                          "",
                                      scale: 10.5,
                                    ),
                                  ),
                                ],
                                if (val.getEquippedItems()["B"] != null) ...[
                                  Positioned(
                                    top: 128,
                                    right: 73,
                                    child: Image.asset(
                                      val.getEquippedItems()["B"]?.getImage() ??
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
                    if (val.getEquippedItems()['H'] == null) ...[
                      DragTarget<String>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
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
                        );
                      }, onWillAccept: (data) {
                        return data == 'H';
                      }, onAccept: (data) {
                        val.equipItem(val.getItemsInv()[k]);
                      }),
                    ] else ...[
                      DragTarget<String>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
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
                            val.getEquippedItems()['H']?.getImage() ?? "",
                            scale: 10,
                          ),
                        );
                      }, onWillAccept: (data) {
                        return data == 'H';
                      }, onAccept: (data) {
                        val.unequipItem(val.getEquippedItems()['H']!);
                        val.equipItem(val.getItemsInv()[k]);
                      })
                    ],
                    if (val.getEquippedItems()['B'] == null)
                      DragTarget<String>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
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
                        );
                      }, onWillAccept: (data) {
                        return data == 'B';
                      }, onAccept: (data) {
                        val.equipItem(val.getItemsInv()[k]);
                      })
                    else
                      DragTarget<String>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
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
                            val.getEquippedItems()['B']?.getImage() ?? "",
                            scale: 10,
                          ),
                        );
                      }, onWillAccept: (data) {
                        return data == 'B';
                      }, onAccept: (data) {
                        val.unequipItem(val.getEquippedItems()['B']!);
                        val.equipItem(val.getItemsInv()[k]);
                      }),
                    if (val.getEquippedItems()['F'] == null)
                      DragTarget<String>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
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
                        );
                      }, onWillAccept: (data) {
                        return data == 'F';
                      }, onAccept: (data) {
                        val.equipItem(val.getItemsInv()[k]);
                      })
                    else
                      DragTarget<String>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Container(
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
                            val.getEquippedItems()['F']?.getImage() ?? "",
                            scale: 10,
                          ),
                        );
                      }, onWillAccept: (data) {
                        return data == 'F';
                      }, onAccept: (data) {
                        val.unequipItem(val.getEquippedItems()['F']!);
                        val.equipItem(val.getItemsInv()[k]);
                      }),
                  ],
                ),
                SizedBox(
                  width: 350,
                  child: SizedBox(
                    child: ListView.builder(
                        itemCount: val.getItemsInv().length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: Center(
                                              child: Text(val
                                                  .getItemsInv()[index]
                                                  .getName())),
                                          content: Row(
                                            children: [
                                              PopUpCosmetic(
                                                  c: val.getItemsInv()[index])
                                            ], //0:speed / 1:resistance / 2:attack speed / 3:strength
                                          ),
                                          actions: [
                                            if (val.getItemsInv()[index].key !=
                                                val
                                                    .getEquippedItems()[val
                                                        .getItemsInv()[index]
                                                        .getBodyPart()]
                                                    ?.key) ...[
                                              ElevatedButton(
                                                onPressed: () {
                                                  val.equipItem(
                                                      val.getItemsInv()[index]);
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
                                                  val.unequipItem(
                                                      val.getItemsInv()[index]);
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
                                        if (val.getItemsInv()[index].key !=
                                            val
                                                .getEquippedItems()[val
                                                    .getItemsInv()[index]
                                                    .getBodyPart()]
                                                ?.key) ...[
                                          Draggable<String>(
                                              data: val
                                                  .getItemsInv()[index]
                                                  .getBodyPart(),
                                              feedback: SizedBox(
                                                  height: 80,
                                                  width: 80,
                                                  child: Image.asset(val
                                                      .getItemsInv()[index]
                                                      .getImage())),
                                              onDragStarted: () {
                                                k = index;
                                              },
                                              child: val.getItemsInv()[index]),
                                          ElevatedButton(
                                            child: const Text('Equip'),
                                            onPressed: () {
                                              val.equipItem(
                                                  val.getItemsInv()[index]);
                                            },
                                          ),
                                        ] else ...[
                                          val.getItemsInv()[index],
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.lightGreen),
                                            child: const Text('Unequip'),
                                            onPressed: () {
                                              val.unequipItem(
                                                  val.getItemsInv()[index]);
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
