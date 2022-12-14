import 'package:flutter/material.dart';

import 'package:mobile_kombat/models/constant.dart';

import 'package:mobile_kombat/models/custom_buttons.dart';
import 'package:mobile_kombat/models/ground.dart';

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/game_stage.dart';

import 'dart:ui' as ui;

class ScenePainter extends CustomPainter {
  ui.Image environment;
  List<Character> characterList;
  List<Button> buttonList;
  List<Ground> groundList;

  ScenePainter(
      this.environment, this.characterList, this.buttonList, this.groundList);

  @override
  void paint(Canvas canvas, Size size) {
    paintImage(
        canvas: canvas,
        image: environment,
        rect: Rect.fromLTWH(0, 0, Constant().w, Constant().h),
        fit: BoxFit.fill);

    double i = 0;
    for (var element in characterList) {
      var health = element.health;
      var maxHealth = element.maxHealth;
      var ratio = (health / maxHealth).toDouble();
      if (ratio < 0) {
        ratio = 0;
      }
      var paint = Paint()
        ..color = Color.fromARGB(255, 99, 8, 8)
        ..style = PaintingStyle.fill;
      var barBox = Rect.fromLTWH(
          Constant().healthBarLeft,
          Constant().healthBarTop + i,
          Constant().healthBarMaxWidth * ratio,
          Constant().healthBarHeight);
      canvas.drawRect(barBox, paint);
      bool flip = element.getFacing() == 'LEFT' ? true : false;
      paintImage(
          canvas: canvas,
          image: element.image,
          rect: element.getImageBox(),
          flipHorizontally: flip,
          fit: BoxFit.fill);

      i += Constant().healthBarTop + Constant().healthBarHeight;
      if (element.equippedCosmetics["H"] != null) {
        paintImage(
            canvas: canvas,
            image: element.equippedCosmetics["H"]!.image,
            rect: element.hatBbox,
            flipHorizontally: flip,
            fit: BoxFit.fill);
      }
      if (element.equippedCosmetics["F"] != null) {
        paintImage(
            canvas: canvas,
            image: element.equippedCosmetics["F"]!.image,
            rect: element.footBbox,
            flipHorizontally: flip,
            fit: BoxFit.fill);
      }
      if (element.equippedCosmetics["B"] != null) {
        paintImage(
            canvas: canvas,
            image: element.equippedCosmetics["B"]!.image,
            rect: element.bodyBbox,
            flipHorizontally: flip,
            fit: BoxFit.fill);
      }
    }
    for (var element in buttonList) {
      paintImage(
          canvas: canvas,
          image: element.img,
          rect: element.bbox,
          fit: BoxFit.fill);
    }
    paintText(canvas, size);
  }

  void paintText(Canvas canvas, Size size) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
    );
    TextSpan textSpan;
    if (((Stage().displayTime ~/ 1000) % 60) < 10) {
      textSpan = TextSpan(
          text:
              "${Stage().displayTime ~/ 60000}:0${(Stage().displayTime ~/ 1000) % 60}",
          style: textStyle);
    } else {
      textSpan = TextSpan(
          text:
              "${Stage().displayTime ~/ 60000}:${(Stage().displayTime ~/ 1000) % 60}",
          style: textStyle);
    }
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 2;
    final offset = Offset(xCenter, 0);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
