import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller.dart';
import 'package:flutter_application_1/views/canvas.dart';
import 'package:provider/provider.dart';

import '../models/game_stage.dart';

class GameScene extends StatelessWidget {
  const GameScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Stage scene, _) {
      if (!scene.ready) {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ]));
      } else {
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
