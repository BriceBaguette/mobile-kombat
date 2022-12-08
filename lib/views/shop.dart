import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:mobile_kombat/models/cosmetics.dart';
import 'package:mobile_kombat/models/character.dart';

import 'package:mobile_kombat/controller_inventory.dart';

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
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Consumer<ControllerInventory>(
        builder: (_, data, __) => Center(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red[900],
                  toolbarHeight: 40,
                  leading: Row(children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('menu');
                      },
                      tooltip: 'Shop',
                    ),
                  ]),
                  actions: const [],
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const Text("Shop"),
                        Row(children: [
                          Text(data.getGold().toString()),
                          const Text("   "),
                          Image.asset("./assets/images/Coins.png", width: 20)
                        ])
                      ]),
                  centerTitle: true,
                ),
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(children: [
                          Container(
                            height: 40,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.red[900]!,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Center(
                                child: Text(
                              "Characters",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                          SizedBox(
                            width: 300,
                            height: MediaQuery.of(context).size.height - 120,
                            child: SizedBox(
                              child: ListView.builder(
                                  itemCount: data.getArticlesChar().length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) =>
                                                      AlertDialog(
                                                        title: Center(
                                                            child: Text(data
                                                                .getArticlesChar()[
                                                                    index]
                                                                .getName())),
                                                        content: PopUpChar(
                                                            c: data.getArticlesChar()[
                                                                index]),
                                                        actions: [
                                                          Text(
                                                              "Price: ${data.getArticlesChar()[index].getPrice()}"),
                                                          Image.asset(
                                                            "assets/images/Coins.png",
                                                            scale: 5,
                                                          ),
                                                          const SizedBox(
                                                            width: 40,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              if (data.getGold() >=
                                                                  data
                                                                      .getArticlesChar()[
                                                                          index]
                                                                      .getPrice()) {
                                                                data.updateGold(-data
                                                                    .getArticlesChar()[
                                                                        index]
                                                                    .getPrice());
                                                                data.addItemChar(
                                                                    data.getArticlesChar()[
                                                                        index]);
                                                                data.deleteArticleChar(
                                                                    index);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              } else {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                          title:
                                                                              const Center(child: Text("Unable to buy this character")),
                                                                          content: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: const [
                                                                                Center(
                                                                                    child: Text(
                                                                                  "Not enough money",
                                                                                  style: TextStyle(color: Colors.red),
                                                                                )),
                                                                              ]),
                                                                          actions: [
                                                                            ElevatedButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text("Close"))
                                                                          ],
                                                                        ));
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Buy'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Close'),
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
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CharacterWidget(
                                                      c: data.getArticlesChar()[
                                                          index]),
                                                  //Make widget for character
                                                  Text(data
                                                      .getArticlesChar()[index]
                                                      .getPrice()
                                                      .toString()),
                                                  Image.asset(
                                                      "assets/images/Coins.png",
                                                      scale: 5),
                                                  ElevatedButton(
                                                    child: const Text('Buy'),
                                                    onPressed: () {
                                                      if (data.getGold() >=
                                                          data
                                                              .getArticlesChar()[
                                                                  index]
                                                              .getPrice()) {
                                                        data.updateGold(-data
                                                            .getArticlesChar()[
                                                                index]
                                                            .getPrice());
                                                        data.addItemChar(
                                                            data.getArticlesChar()[
                                                                index]);
                                                        data.deleteArticleChar(
                                                            index);
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  title: const Center(
                                                                      child: Text(
                                                                          "Unable to buy this character")),
                                                                  content: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: const [
                                                                        Center(
                                                                            child:
                                                                                Text(
                                                                          "Not enough money",
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        )),
                                                                      ]),
                                                                  actions: [
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Close"))
                                                                  ],
                                                                ));
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )));
                                  }),
                            ),
                          ),
                        ])),
                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(children: [
                          Container(
                            height: 40,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.red[900]!,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: const Center(
                                child: Text(
                              "Cosmetics",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                          SizedBox(
                            width: 300,
                            height: MediaQuery.of(context).size.height - 120,
                            child: SizedBox(
                              child: ListView.builder(
                                  itemCount: data.getArticlesCosmetics().length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) =>
                                                      AlertDialog(
                                                        title: Center(
                                                            child: Text(data
                                                                .getArticlesCosmetics()[
                                                                    index]
                                                                .getName())),
                                                        content: PopUpCosmetic(
                                                            c: data.getArticlesCosmetics()[
                                                                index]),
                                                        actions: [
                                                          Text(
                                                              "Price: ${data.getArticlesCosmetics()[index].getPrice()}"),
                                                          Image.asset(
                                                            "assets/images/Coins.png",
                                                            scale: 5,
                                                          ),
                                                          const SizedBox(
                                                            width: 40,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              if (data.getGold() >=
                                                                  data
                                                                      .getArticlesCosmetics()[
                                                                          index]
                                                                      .getPrice()) {
                                                                data.updateGold(-data
                                                                    .getArticlesCosmetics()[
                                                                        index]
                                                                    .getPrice());
                                                                data.addItem(
                                                                    data.getArticlesCosmetics()[
                                                                        index]);
                                                                data.deleteArticle(
                                                                    index);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              } else {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                          title:
                                                                              const Center(child: Text("Unable to buy this item")),
                                                                          content: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: const [
                                                                                Center(
                                                                                    child: Text(
                                                                                  "Not enough money",
                                                                                  style: TextStyle(color: Colors.red),
                                                                                )),
                                                                              ]),
                                                                          actions: [
                                                                            ElevatedButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text("Close"))
                                                                          ],
                                                                        ));
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Buy'),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Close'),
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
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  data.getArticlesCosmetics()[
                                                      index],
                                                  Text(data
                                                      .getArticlesCosmetics()[
                                                          index]
                                                      .getPrice()
                                                      .toString()),
                                                  Image.asset(
                                                      "assets/images/Coins.png",
                                                      scale: 5),
                                                  ElevatedButton(
                                                    child: const Text('Buy'),
                                                    onPressed: () {
                                                      if (data.getGold() >=
                                                          data
                                                              .getArticlesCosmetics()[
                                                                  index]
                                                              .getPrice()) {
                                                        data.updateGold(-data
                                                            .getArticlesCosmetics()[
                                                                index]
                                                            .getPrice());
                                                        data.addItem(
                                                            data.getArticlesCosmetics()[
                                                                index]);
                                                        data.deleteArticle(
                                                            index);
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  title: const Center(
                                                                      child: Text(
                                                                          "Unable to buy this item")),
                                                                  content: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: const [
                                                                        Center(
                                                                            child:
                                                                                Text(
                                                                          "Not enough money",
                                                                          style:
                                                                              TextStyle(color: Colors.red),
                                                                        )),
                                                                      ]),
                                                                  actions: [
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Close"))
                                                                  ],
                                                                ));
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )));
                                  }),
                            ),
                          )
                        ])),
                  ],
                ),
              ),
            ));
  }
}
