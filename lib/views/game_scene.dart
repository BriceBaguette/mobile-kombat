import 'package:flutter/material.dart';
import 'package:mobile_kombat/controller.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:mobile_kombat/views/canvas.dart';
import 'package:mobile_kombat/views/ending_screen.dart';
import 'package:provider/provider.dart';

import '../models/game_stage.dart';

class GameScene extends StatelessWidget {
  const GameScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2(
        builder: (context, Stage scene, ControllerInventory data, _) {
      if (scene.gameOver) {
        scene.setReady(false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EndingScreen(
                    characters: scene.getChar(),
                    op: scene.opponent!,
                  )));
        });
      }
      return Listener(
          onPointerDown: (details) => Controller().onTapStart(details),
          onPointerMove: (details) => Controller().onDrag(details),
          onPointerUp: (details) => Controller().onTapStop(details),
          child: CustomPaint(
              size: Size.infinite,
              painter: ScenePainter(scene.environmentImage, scene.characters,
                  scene.buttons, scene.grounds)));
    });
  }
}
