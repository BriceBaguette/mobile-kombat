import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/views/game_scene.dart';
import 'package:mobile_kombat/views/inventory.dart';
import 'package:mobile_kombat/views/shop.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Player player = Player();
    Character character = StickMan(
        image: Loader().imgMap[AssetList.characterImg]!,
        bbox: Rect.fromLTWH(Constant().w / 4, Constant().h / 2,
            Constant().w / 20, Constant().w / 20 * Constant().gokuRatio),
        speed: 3,
        facing: 'RIGHT',
        mainAbilityImage: Loader().imgMap[AssetList.swordImg]!,
        framerate: Constant().framerate);
    player.setCharacter(character);
    return MaterialApp(
      home: Scaffold(
        body: Row(
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
                    child: const Text('Inventory'),
                    onPressed: () =>
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Inventory()));
                    }),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                      child: const Text('Shop'),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Shop()),
                          )),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Stats'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Inventory()),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('./assets/images/10522.png', scale: 2.5),
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
                      child: const Text('Play'),
                      onPressed: () =>
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) =>
                                  const Scaffold(body: GameScene())),
                            ));
                      }),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
