import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/views/game_scene.dart';
import 'package:mobile_kombat/views/loading_screen.dart';
import 'package:mobile_kombat/views/main_menu.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:mobile_kombat/views/statistics.dart';
import 'package:provider/provider.dart';
import 'models/game_stage.dart';
import 'views/inventory.dart';
import 'views/shop.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Loader()),
        ChangeNotifierProvider(create: (BuildContext context) => Stage()),
        ChangeNotifierProvider(create: (BuildContext context) => ControllerInventory()),
      ],
      child:
      const MaterialApp(title: 'Mobile Kombat', home: LaunchingScreen())));
}

class LaunchingScreen extends StatelessWidget {
  const LaunchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: 'loader', routes: {
      'loader': (context) => const LoaderScreen(),
      'menu': (context) => const Scaffold(body: MainMenu()),
      'gamestage': (context) => const Scaffold(body: GameScene()),
      'inventory': (context) => const Inventory(),
      'shop': (context) => const Shop(),
      'statistics': (context) => Statistics()
    });
  }
}















/*Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Stage(),
        ),
        ChangeNotifierProvider(create: (BuildContext context) => ControllerInventory()),
      ],
          child: const MaterialApp(title: 'Mobile Kombat', home: MainMenu()))
      
      

  );
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
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Inventory()),
                          )),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                      child: const Text('Shop'),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Shop()),
                          )),
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Statistics'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Statistics()),
                    ),
                  ),
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
                      child: const Text('Play'),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                const Scaffold(body: GameScene())),
                          ))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
