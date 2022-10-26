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
        if (scene.gameOver) {
          scene.reset();
        }
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ]));
      } else {
        if (scene.gameOver) {
          scene.setReady(false);
          Navigator.of(
            context,
            rootNavigator: true,
          ).pop(
            context,
          );
        }
        return Listener(
            onPointerDown: (details) => Controller().onTapStart(details),
            onPointerMove: (details) => Controller().onDrag(details),
            onPointerUp: (details) => Controller().onTapStop(details),
            child: CustomPaint(
                size: Size.infinite,
                painter: ScenePainter(
                    scene.characters, scene.buttons, scene.grounds)));
      }
    });
  }
}
