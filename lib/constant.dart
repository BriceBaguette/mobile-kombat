import 'dart:ui';

class Constant {
  final double w;
  final double h;
  final int framerate = 16;
  final time = 15000;
  late Rect leftButtonPosition;
  late Rect rightButtonPosition;
  late Rect jumpButtonPosition;
  late Rect attackButtonPosition;
  Constant({required this.w, required this.h}) {
    leftButtonPosition = Rect.fromLTWH(w / 40, h - h / 9, w / 15, h / 10);
    rightButtonPosition =
        Rect.fromLTWH(2 * w / 40 + w / 15, h - h / 9, w / 15, h / 10);
    jumpButtonPosition =
        Rect.fromLTWH(w / 40, h - w / 20 - h / 10 - h / 40, w / 20, w / 20);
    attackButtonPosition =
        Rect.fromLTWH(w - w / 40 - w / 15, h - h / 9, w / 20, w / 20);
  }
}
