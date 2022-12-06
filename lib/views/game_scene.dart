import 'package:flutter/material.dart';
import 'package:mobile_kombat/controller.dart';
import 'package:mobile_kombat/controller_inventory.dart';
import 'package:mobile_kombat/views/canvas.dart';
import 'package:provider/provider.dart';
import '../views/ending_screen.dart';
import '../models/game_stage.dart';

class GameScene extends StatelessWidget {
  const GameScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (context, Stage scene, ControllerInventory data, _) {
      if (!scene.ready) {
        scene.reset();
      } else if (scene.gameOver) {
        scene.setReady(false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
          if (scene.getChar()[0].health>scene.getChar()[1].health){
            data.updateGold(50);
          }else{
            data.updateGold(20);
          }
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EndingScreen(characters: scene.getChar(), op: scene.getOp(),)));//, scene.getCosm1, scene.getCosm2
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
