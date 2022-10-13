import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/CustomButtons.dart';
import 'package:flutter_application_1/models/ground.dart';
import 'dart:ui' as ui;

import '../models/character.dart';

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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
