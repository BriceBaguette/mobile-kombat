import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/constant.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/models/player.dart';
import 'package:mobile_kombat/views/game_scene.dart';
import 'package:mobile_kombat/views/loading_screen.dart';
import 'package:mobile_kombat/views/main_menu.dart';
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
      'inventory': (context) => Inventory(),
      'shop': (context) => Shop()
    });
  }
}
