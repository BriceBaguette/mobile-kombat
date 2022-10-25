import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kombat/views/game_scene.dart';
import 'package:provider/provider.dart';
import 'models/game_stage.dart';
import 'views/inventory.dart';
//import 'game.dart';
//import 'stats.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MaterialApp(title: 'Mobile Kombat', home: MainMenu()));
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Inventory()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Shop'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Inventory()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Stats'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Inventory()),
                      );
                    },
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChangeNotifierProvider(
                                    create: (BuildContext context) => Stage(),
                                    child: const Scaffold(body: GameScene())),
                          ));
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
