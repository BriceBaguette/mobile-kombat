import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/CustomButtons.dart';
import 'dart:ui' as ui;

import '../models/character.dart';

class ScenePainter extends CustomPainter {
  List<Character> characterList;
  List<Button> buttonList;

  ScenePainter(this.characterList, this.buttonList);

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in characterList) {
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
