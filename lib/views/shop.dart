import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_kombat/models/cosmetics.dart';
import 'package:mobile_kombat/models/character.dart';

import 'package:mobile_kombat/controller_inventory.dart';
import 'package:provider/provider.dart';

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
            tooltip: 'Shop',
          ),
        ]),
        actions: const [],
        title: const Text("Shop"),
        centerTitle: true,
      ),
      body: Consumer<ControllerInventory>(
          builder: (_, data, __) => Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    /*SizedBox(
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("GenericName1"),
                      Image.asset('assets/images/GenericGuy.png'),
                      Container()
                    ],
                  )),*/
                    SizedBox(
                      width: 300,
                      child: SizedBox(
                        //CHARACTER PART TO MODIFY
                        child: ListView.builder(
                            itemCount: data.getArticlesChar().length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Center(
                                                  child: Text(data
                                                      .getArticlesChar()[index]
                                                      .getName())),
                                              content: PopUpShopChar(
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
                                                    data.addItemChar(
                                                        data.getArticlesChar()[
                                                            index]);
                                                    data.deleteArticleChar(
                                                        index);
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
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CharacterWidget(
                                                c: data.getArticlesChar()[
                                                    index]), //Make widget for character
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
                                                data.addItemChar(data
                                                    .getArticlesChar()[index]);
                                                data.deleteArticleChar(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      )));
                            }),
                      ),
                    ),
                    SizedBox(
                      //COSMETIC PART ISOK
                      width: 300,
                      child: SizedBox(
                        child: ListView.builder(
                            itemCount: data.getArticlesCosmetics().length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Center(
                                                  child: Text(data
                                                      .getArticlesCosmetics()[
                                                          index]
                                                      .getName())),
                                              content: PopUpShopCosmetic(
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
                                                    data.addItem(
                                                        data.getArticlesCosmetics()[
                                                            index]);
                                                    data.deleteArticle(index);
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
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            data.getArticlesCosmetics()[index],
                                            Text(data
                                                .getArticlesCosmetics()[index]
                                                .getPrice()
                                                .toString()),
                                            Image.asset(
                                                "assets/images/Coins.png",
                                                scale: 5),
                                            ElevatedButton(
                                              child: const Text('Buy'),
                                              onPressed: () {
                                                data.addItem(
                                                    data.getArticlesCosmetics()[
                                                        index]);
                                                data.deleteArticle(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      )));
                            }),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
/*
* ==Sandbox======================================================
* Testing stuff and ideas
* ===============================================================
*/

class PopUpShopCosmetic extends StatelessWidget {
  const PopUpShopCosmetic({super.key, required this.c});
  final Cosmetics c;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(c.getImage()),
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

class PopUpShopChar extends StatelessWidget { //in inventory, add stats of the equipped items
  const PopUpShopChar({super.key, required this.c});
  final Character c;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(c.getImageDir()),
          Text("Speed: ${c.getSpeed()}\n"
              "Resistance:${c.getResistance()}\n"
              "Attack Speed: ${c.getAS()}\n"
              "Strength: ${c.getStrength()}\n"),
        ],
      ),
    );
  }
}
