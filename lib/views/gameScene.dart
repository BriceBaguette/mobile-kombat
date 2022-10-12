import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller.dart';
import 'package:flutter_application_1/views/canvas.dart';
import 'package:provider/provider.dart';

import '../models/CustomButtons.dart';
import '../models/gameStage.dart';

class GameScene extends StatelessWidget {
  const GameScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Stage scene, _) {
      if (!scene.ready) {
        return Container(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ])));
      } else {
        Timer gameTimer =
            Timer.periodic(const Duration(milliseconds: 50), (timer) {
          scene.updateGame();
        });
        return GestureDetector(
            onTapDown: (details) => Controller().onTapStart(details),
            onTapUp: (_) => Controller().onTapStop(),
            child: SafeArea(
                child: CustomPaint(
              size: Size.infinite,
              painter: ScenePainter(scene.characters, scene.buttons),
            )));
      }
    });
  }
}
