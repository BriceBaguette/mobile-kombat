import "dart:ui" as ui;

import 'package:flutter/material.dart';

class Ground {
  final Rect bbox;
  final ui.Image groundImg;
  Ground({required this.bbox, required this.groundImg});
}
