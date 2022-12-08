import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/auth.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/database.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/models/room.dart';
import 'package:mobile_kombat/views/game_scene.dart';
import 'package:mobile_kombat/views/inventory.dart';
import 'package:mobile_kombat/views/shop.dart';
import 'package:provider/provider.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:mobile_kombat/models/opponent.dart';

import '../models/game_stage.dart';

class MainMenu extends StatelessWidget {
  MainMenu({super.key});

  final User? user = Auth().currentUser;
  final _database = Database();
  final _rtDb = RealTimeDB();
  final _player = Player();
  late Opponent opponent;
  @override
  Widget build(BuildContext context) {
    return Consumer<ControllerInventory>(
        builder: (_, data, __) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 50,
                      height: 200,
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900]),
                          child: const Text('Inventory'),
                          onPressed: () =>
                              //WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.popAndPushNamed(context, 'inventory')),
                      //}),
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900]),
                          child: const Text('Shop'),
                          onPressed: () =>
                              Navigator.pushNamed(context, 'shop')),
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900]),
                          child: const Text('Stats'),
                          onPressed: () =>
                              Navigator.pushNamed(context, 'statistics')),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 10,
                  width: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 180,
                        left: 50,
                        child: Image.asset(data.getEquippedChar().getImageDir(),
                            height: 150),
                      ),
                      if (data.getEquippedItems()["H"] != null) ...[
                        Positioned(
                          top: 145,
                          right: 66,
                          child: Image.asset(
                              data.getEquippedItems()["H"]?.getImage() ?? "",
                              height: 80),
                        ),
                      ],
                      if (data.getEquippedItems()["F"] != null) ...[
                        Positioned(
                          top: 270,
                          right: 80,
                          child: Image.asset(
                            data.getEquippedItems()["F"]?.getImage() ?? "",
                            scale: 10.5,
                          ),
                        ),
                      ],
                      if (data.getEquippedItems()["B"] != null) ...[
                        Positioned(
                          top: 228,
                          right: 73,
                          child: Image.asset(
                            data.getEquippedItems()["B"]?.getImage() ?? "",
                            scale: 8,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[900]),
                            child: const Text('disconnect'),
                            onPressed: () => {
                                  Auth().signout(),
                                  Navigator.of(context).popAndPushNamed('login')
                                })),
                    Container(
                      height: 200,
                    ),
                    SizedBox(
                      width: 150,
                      height: 75,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[900]),
                          child: const Text('Play'),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (BuildContext ctx) => AlertDialog(
                                      title: const Center(
                                          child: Text("Select game mode")),
                                      actions: [
                                        Align(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red[900]),
                                                  onPressed: () => {
                                                        opponent = DummyBot(
                                                            character: StickMan(
                                                                bbox: Rect.fromLTWH(
                                                                    Constant()
                                                                            .w -
                                                                        Constant()
                                                                                .w /
                                                                            4,
                                                                    Constant()
                                                                            .h /
                                                                        2,
                                                                    Constant()
                                                                            .w /
                                                                        20,
                                                                    Constant()
                                                                            .w /
                                                                        20 *
                                                                        Constant()
                                                                            .gokuRatio),
                                                                speed: 3,
                                                                facing: 'LEFT',
                                                                framerate:
                                                                    Constant()
                                                                        .framerate)),
                                                        Stage().setOpponent(
                                                            opponent),
                                                        Navigator.of(ctx).pop(),
                                                        Navigator.pushNamed(
                                                            context,
                                                            'gamestage')
                                                      },
                                                  child:
                                                      const Text("Training")),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red[900]),
                                                  onPressed: () => {
                                                        opponent = SmartBot(
                                                            character: StickMan(
                                                                bbox: Rect.fromLTWH(
                                                                    Constant()
                                                                            .w -
                                                                        Constant()
                                                                                .w /
                                                                            4,
                                                                    Constant()
                                                                            .h /
                                                                        2,
                                                                    Constant()
                                                                            .w /
                                                                        20,
                                                                    Constant()
                                                                            .w /
                                                                        20 *
                                                                        Constant()
                                                                            .gokuRatio),
                                                                speed: 3,
                                                                facing: 'LEFT',
                                                                framerate:
                                                                    Constant()
                                                                        .framerate)),
                                                        Stage().setOpponent(
                                                            opponent),
                                                        Navigator.of(ctx).pop(),
                                                        Navigator.pushNamed(
                                                            context,
                                                            'gamestage')
                                                      },
                                                  child: const Text(
                                                      "Play vs bot")),
                                            ),
                                            SizedBox(
                                                width: 150,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .red[900]),
                                                    onPressed: () => {
                                                          Navigator.of(ctx)
                                                              .pop(),
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                          ctx) =>
                                                                      AlertDialog(
                                                                        title: const Center(
                                                                            child:
                                                                                Text("Looking for opponent")),
                                                                        actions: [
                                                                          FutureBuilder(
                                                                            future: startGame().then((_) =>
                                                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                                  Navigator.pushNamed(context, 'gamestage');
                                                                                })),
                                                                            builder:
                                                                                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                                              return const Center(child: CircularProgressIndicator());
                                                                            },
                                                                          ),
                                                                        ],
                                                                      )),
                                                        },
                                                    child: const Text(
                                                        "Play online")))
                                          ],
                                        ))
                                      ]))),
                    )
                  ],
                ),
              ],
            ));
  }

  Future startGame() async {
    String roomId = await _rtDb.joinRoom(user!.uid);
    Room? room = await _rtDb.getRoom(roomId);
    UserDb? opponentUser = await _rtDb.getOpponent(room!, user!.uid);
    if (opponentUser!.first == false) {
      await _rtDb.createGameRoom(room);
    }
    Character? opponentChar =
        await _rtDb.getOpponentCharacter(opponentUser, user!.uid);
    _rtDb.initListener(room, user!.uid);
    opponent =
        RealPlayer(username: opponentUser.userName, character: opponentChar!);
    Stage().setOpponent(opponent);
    Stage().setRoom(room);
    Future.delayed(const Duration(seconds: 1));
    return opponent;
  }
}
