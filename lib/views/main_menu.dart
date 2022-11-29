import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/opponent.dart';
import 'package:mobile_kombat/models/player.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Player player = Player();
    Character character = StickMan(
        bbox: Rect.fromLTWH(Constant().w / 4, Constant().h / 2,
            Constant().w / 20, Constant().w / 20 * Constant().gokuRatio),
        speed: 3,
        facing: 'RIGHT',
        framerate: Constant().framerate);
    player.setCharacter(character);
    Opponent opponent;
    return Row(
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
                      Navigator.pushNamed(context, 'inventory')),
              //}),
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900]),
                  child: const Text('Shop'),
                  onPressed: () => Navigator.pushNamed(context, 'shop')),
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900]),
                  child: const Text('Stats'),
                  onPressed: () => Navigator.pushNamed(context, 'statistics')),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('./assets/images/GenericGuy.png', scale: 2.5),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 275,
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
                              title: const Text("Select game mode"),
                              actions: [
                                Align(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () => {
                                              opponent = DummyBot(
                                                  character: StickMan(
                                                      bbox: Rect.fromLTWH(
                                                          Constant().w -
                                                              Constant().w / 4,
                                                          Constant().h / 2,
                                                          Constant().w / 20,
                                                          Constant().w /
                                                              20 *
                                                              Constant()
                                                                  .gokuRatio),
                                                      speed: 3,
                                                      facing: 'LEFT',
                                                      framerate: Constant()
                                                          .framerate)),
                                              Stage().setOpponent(opponent),
                                              Navigator.of(ctx).pop(),
                                              Navigator.pushNamed(
                                                  context, 'gamestage')
                                            },
                                        child: const Text("Training")),
                                    ElevatedButton(
                                        onPressed: () => {
                                              opponent = SmartBot(
                                                  character: StickMan(
                                                      bbox: Rect.fromLTWH(
                                                          Constant().w -
                                                              Constant().w / 4,
                                                          Constant().h / 2,
                                                          Constant().w / 20,
                                                          Constant().w /
                                                              20 *
                                                              Constant()
                                                                  .gokuRatio),
                                                      speed: 3,
                                                      facing: 'LEFT',
                                                      framerate: Constant()
                                                          .framerate)),
                                              Stage().setOpponent(opponent),
                                              Navigator.of(ctx).pop(),
                                              Navigator.pushNamed(
                                                  context, 'gamestage')
                                            },
                                        child: const Text("Play vs bot")),
                                    ElevatedButton(
                                        onPressed: () => {
                                              opponent = DummyBot(
                                                  character: StickMan(
                                                      bbox: Rect.fromLTWH(
                                                          Constant().w -
                                                              Constant().w / 4,
                                                          Constant().h / 2,
                                                          Constant().w / 20,
                                                          Constant().w /
                                                              20 *
                                                              Constant()
                                                                  .gokuRatio),
                                                      speed: 3,
                                                      facing: 'LEFT',
                                                      framerate: Constant()
                                                          .framerate)),
                                              Stage().setOpponent(opponent),
                                              Navigator.of(ctx).pop(),
                                              Navigator.pushNamed(
                                                  context, 'gamestage')
                                            },
                                        child: const Text("Play online"))
                                  ],
                                ))
                              ]))),
            )
          ],
        ),
      ],
    );
  }
}
