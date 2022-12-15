import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:provider/provider.dart';

import '../controller_inventory.dart';
import '../models/constant.dart';
import '../models/game_stage.dart';
import '../models/opponent.dart';

class EndingScreen extends StatelessWidget {
  late List<Character> characters;
  late Opponent op;
  EndingScreen({required this.characters, required this.op, super.key});

  bool checkHealth() {
    return characters[0].health > characters[1].health;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: checkHealth()
            ? Winner(
                characters: characters,
                op: op,
              )
            : Loser(
                characters: characters,
                op: op,
              ));
  }
}

class Winner extends StatelessWidget {
  late List<Character> characters;
  late Opponent op;

  Winner({required this.characters, required this.op, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("./assets/images/environment3.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: SizedBox(
                                    width: 300,
                                    height: Constant().h - 150,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Winner",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            Player().getUsername(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),

                                          //Player1.cosmetics,
                                          Stack(
                                            children: [
                                              Image.asset(
                                                characters[0].getImageDir(),
                                                height: Constant().h / 2 - 20,
                                              ),
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[0].id == 1) ...[
                                                Positioned(
                                                  top: -20,
                                                  left: 5,
                                                  child: Image.asset(
                                                      characters[0]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      width: 70),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[0].id == 0) ...[
                                                Positioned(
                                                  top: -25,
                                                  left: 34,
                                                  child: Image.asset(
                                                      characters[0]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      width: 80),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[0].id == 1) ...[
                                                Positioned(
                                                  top: 90,
                                                  left: 5,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 50,
                                                  ),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[0].id == 0) ...[
                                                Positioned(
                                                  top: 80,
                                                  left: 20,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 70,
                                                  ),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[0].id == 1) ...[
                                                Positioned(
                                                  top: 45,
                                                  left: 0,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 60,
                                                  ),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[0].id == 0) ...[
                                                Positioned(
                                                  top: 35,
                                                  left: 15,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 80,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ]))),
                            Center(
                                child: SizedBox(
                                    width: 300,
                                    height: Constant().h - 150,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Loser",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 35,
                                            ),
                                          ),
                                          Text(op.username,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          Stack(
                                            children: [
                                              Image.asset(
                                                characters[1].getImageDir(),
                                                height: Constant().h / 2 - 20,
                                                color: Colors.blueGrey
                                                    .withOpacity(0.5),
                                              ),
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[1].id == 1) ...[
                                                Positioned(
                                                  top: -20,
                                                  left: 5,
                                                  child: Image.asset(
                                                      characters[1]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      color: Colors.blueGrey
                                                          .withOpacity(0.5),
                                                      width: 70),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[1].id == 0) ...[
                                                Positioned(
                                                  top: -25,
                                                  left: 34,
                                                  child: Image.asset(
                                                      characters[1]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      color: Colors.blueGrey
                                                          .withOpacity(0.5),
                                                      width: 80),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[1].id == 1) ...[
                                                Positioned(
                                                  top: 90,
                                                  left: 5,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 50,
                                                  ),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[1].id == 0) ...[
                                                Positioned(
                                                  top: 80,
                                                  left: 20,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 70,
                                                  ),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[1].id == 1) ...[
                                                Positioned(
                                                  top: 45,
                                                  left: 0,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 60,
                                                  ),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[1].id == 0) ...[
                                                Positioned(
                                                  top: 35,
                                                  left: 15,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 80,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ]))),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 50),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                      child: Text("Earned gold: 50     ",
                                          style:
                                              TextStyle(color: Colors.white))),
                                  Image.asset(
                                    "assets/images/Coins.png",
                                    width: 20,
                                  )
                                ]),
                            Consumer2(
                                builder: (context, Stage scene,
                                        ControllerInventory val, _) =>
                                    IconButton(
                                      iconSize: 50,
                                      icon: const Icon(Icons.play_arrow,
                                          size: 75, color: Colors.white),
                                      onPressed: () {
                                        val.updateTimeStat(Player().character,
                                            15000 - scene.displayTime);
                                        val.updateGold(50);
                                        Navigator.of(context)
                                            .popAndPushNamed('menu');
                                      },
                                    ))
                          ])
                    ])))));
  }
}

class Loser extends StatelessWidget {
  late List<Character> characters;
  late Opponent op;

  Loser({required this.characters, required this.op, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("./assets/images/environment3.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: SizedBox(
                                    width: 300,
                                    height: Constant().h - 150,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Loser",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 35,
                                            ),
                                          ),
                                          Text(Player().getUsername(),
                                              style: const TextStyle(
                                                  color: Colors.white)),

                                          //Player1.cosmetics,
                                          Stack(
                                            children: [
                                              Image.asset(
                                                characters[0].getImageDir(),
                                                height: Constant().h / 2 - 20,
                                                color: Colors.blueGrey
                                                    .withOpacity(0.5),
                                              ),
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[0].id == 1) ...[
                                                Positioned(
                                                  top: -20,
                                                  left: 5,
                                                  child: Image.asset(
                                                      characters[0]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      color: Colors.blueGrey
                                                          .withOpacity(0.5),
                                                      width: 70),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[0].id == 0) ...[
                                                Positioned(
                                                  top: -25,
                                                  left: 34,
                                                  child: Image.asset(
                                                      characters[0]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      color: Colors.blueGrey
                                                          .withOpacity(0.5),
                                                      width: 80),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[0].id == 1) ...[
                                                Positioned(
                                                  top: 90,
                                                  left: 5,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 50,
                                                  ),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[0].id == 0) ...[
                                                Positioned(
                                                  top: 80,
                                                  left: 20,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 70,
                                                  ),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[0].id == 1) ...[
                                                Positioned(
                                                  top: 45,
                                                  left: 0,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 60,
                                                  ),
                                                ),
                                              ],
                                              if (characters[0]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[0].id == 0) ...[
                                                Positioned(
                                                  top: 35,
                                                  left: 15,
                                                  child: Image.asset(
                                                    characters[0]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    color: Colors.blueGrey
                                                        .withOpacity(0.5),
                                                    width: 80,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ]))),
                            Center(
                                child: SizedBox(
                                    width: 300,
                                    height: Constant().h - 150,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            "Winner",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 35,
                                            ),
                                          ),
                                          Text(op.username,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          Stack(
                                            children: [
                                              Image.asset(
                                                characters[1].getImageDir(),
                                                height: Constant().h / 2 - 20,
                                              ),
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[1].id == 1) ...[
                                                Positioned(
                                                  top: -20,
                                                  left: 5,
                                                  child: Image.asset(
                                                      characters[1]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      width: 70),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "H"] !=
                                                      null &&
                                                  characters[1].id == 0) ...[
                                                Positioned(
                                                  top: -25,
                                                  left: 34,
                                                  child: Image.asset(
                                                      characters[1]
                                                              .equippedCosmetics[
                                                                  "H"]
                                                              ?.getImage() ??
                                                          "",
                                                      width: 80),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[1].id == 1) ...[
                                                Positioned(
                                                  top: 90,
                                                  left: 5,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 50,
                                                  ),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "F"] !=
                                                      null &&
                                                  characters[1].id == 0) ...[
                                                Positioned(
                                                  top: 80,
                                                  left: 20,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "F"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 70,
                                                  ),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[1].id == 1) ...[
                                                Positioned(
                                                  top: 45,
                                                  left: 0,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 60,
                                                  ),
                                                ),
                                              ],
                                              if (characters[1]
                                                              .equippedCosmetics[
                                                          "B"] !=
                                                      null &&
                                                  characters[1].id == 0) ...[
                                                Positioned(
                                                  top: 35,
                                                  left: 15,
                                                  child: Image.asset(
                                                    characters[1]
                                                            .equippedCosmetics[
                                                                "B"]
                                                            ?.getImage() ??
                                                        "",
                                                    width: 80,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ]))),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 50),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                      child: Text("Earned gold: 20     ",
                                          style:
                                              TextStyle(color: Colors.white))),
                                  Image.asset(
                                    "assets/images/Coins.png",
                                    width: 20,
                                  )
                                ]),
                            Consumer2(
                                builder: (context, Stage scene,
                                        ControllerInventory val, _) =>
                                    IconButton(
                                      iconSize: 50,
                                      icon: const Icon(Icons.play_arrow,
                                          size: 75, color: Colors.white),
                                      onPressed: () {
                                        val.updateTimeStat(Player().character,
                                            15000 - scene.displayTime);
                                        val.updateGold(20);
                                        Navigator.of(context)
                                            .popAndPushNamed('menu');
                                      },
                                    ))
                          ])
                    ])))));
  }
}
