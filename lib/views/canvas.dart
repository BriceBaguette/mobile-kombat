import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/custom_buttons.dart';
import 'package:mobile_kombat/models/ground.dart';

import '../models/character.dart';
import '../models/game_stage.dart';

class ScenePainter extends CustomPainter {
  List<Character> characterList;
  List<Button> buttonList;
  List<Ground> groundList;

  ScenePainter(this.characterList, this.buttonList, this.groundList);

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in characterList) {
      for (var element in groundList) {
        paintImage(
            canvas: canvas,
            image: element.groundImg,
            rect: element.bbox,
            fit: BoxFit.fill);
      }
      paintImage(
          canvas: canvas,
          image: element.image,
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
