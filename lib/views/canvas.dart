import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/custom_buttons.dart';
import 'package:mobile_kombat/models/ground.dart';

import 'package:mobile_kombat/models/character.dart';
import 'package:mobile_kombat/models/game_stage.dart';

import '../models/loader.dart';

class ScenePainter extends CustomPainter {
  List<Character> characterList;
  List<Button> buttonList;
  List<Ground> groundList;

  ScenePainter(this.characterList, this.buttonList, this.groundList);

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in characterList) {
      bool flip = element.facing == 'LEFT' ? true : false;
      paintImage(
          canvas: canvas,
          image: element.image,
          rect: element.bbox,
          flipHorizontally: flip,
          fit: BoxFit.fill);
      if (element.equippedCosmetics["H"] != null){
        paintImage(
            canvas: canvas,
            image: element.equippedCosmetics["H"]!.image,
            rect: element.hatBbox,
            flipHorizontally: flip,
            fit: BoxFit.fill);
      }
      if (element.equippedCosmetics["F"] != null){
        paintImage(
            canvas: canvas,
            image: element.equippedCosmetics["F"]!.image,
            rect: element.footBbox,
            flipHorizontally: flip,
            fit: BoxFit.fill);
      }
      if (element.equippedCosmetics["B"] != null){
        paintImage(
            canvas: canvas,
            image: element.equippedCosmetics["B"]!.image,
            rect: element.bodyBbox,
            flipHorizontally: flip,
            fit: BoxFit.fill);
      }
      if (element.usingAbility) {
        paintImage(
            canvas: canvas,
            image: element.abilityImage(),
            rect: element.abilityRange(),
            flipHorizontally: flip,
            fit: BoxFit.fill);
      }
    }
    for (var element in groundList) {
      paintImage(
          canvas: canvas,
          image: element.groundImg,
          rect: element.bbox,
          fit: BoxFit.fill);
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
      color: Colors.black,
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
