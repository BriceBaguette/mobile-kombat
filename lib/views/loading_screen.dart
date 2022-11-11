import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/game_stage.dart';
import 'package:mobile_kombat/models/loader.dart';
import 'package:provider/provider.dart';

import 'package:mobile_kombat/views/game_scene.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Loader loader, _) {
      if (loader.ready) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => const Scaffold(body: GameScene())),
              ));
        });
        Navigator.of(context, rootNavigator: true).pop(context);
      }
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ]));
    });
  }
}
