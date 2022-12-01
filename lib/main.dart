import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kombat/firebase_options.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:mobile_kombat/views/game_scene.dart';
import 'package:mobile_kombat/views/loading_screen.dart';
import 'package:mobile_kombat/views/login_page.dart';
import 'package:mobile_kombat/views/main_menu.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:mobile_kombat/views/register_page.dart';
import 'package:mobile_kombat/views/statistics.dart';
import 'package:provider/provider.dart';
import 'models/game_stage.dart';
import 'views/inventory.dart';
import 'views/shop.dart';

Future main() async {
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Loader()),
        ChangeNotifierProvider(create: (BuildContext context) => Stage()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ControllerInventory()),
      ],
      child:
          const MaterialApp(title: 'Mobile Kombat', home: LaunchingScreen())));
}

class LaunchingScreen extends StatelessWidget {
  const LaunchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: 'loader', routes: {
      'login': (context) => const Scaffold(body: LoginPage()),
      'register': (context) => const Scaffold(body: RegisterPage()),
      'loader': (context) => const LoaderScreen(),
      'menu': (context) => const Scaffold(body: MainMenu()),
      'gamestage': (context) => const Scaffold(body: GameScene()),
      'inventory': (context) => const Inventory(),
      'shop': (context) => const Shop(),
      'statistics': (context) => Statistics()
    });
  }
}
