import 'package:flutter/material.dart';
import 'package:mobile_kombat/controller.dart';
import 'package:mobile_kombat/views/canvas.dart';
import 'package:provider/provider.dart';

import '../models/game_stage.dart';

class GameScene extends StatelessWidget {
  const GameScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Stage scene, _) {
      if (!scene.ready) {
        scene.reset();
      } else if (scene.gameOver) {
        scene.setReady(false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).popAndPushNamed('menu');
        });
      }
      return Listener(
          onPointerDown: (details) => Controller().onTapStart(details),
          onPointerMove: (details) => Controller().onDrag(details),
          onPointerUp: (details) => Controller().onTapStop(details),
          child: CustomPaint(
              size: Size.infinite,
              painter: ScenePainter(
                  scene.characters, scene.buttons, scene.grounds)));
    });
  }
}
