import 'dart:ui';

class Constant {
  final double w;
  final double h;
  late Rect leftButtonPosition;
  late Rect rightButtonPosition;
  late Rect jumpButtonPosition;
  Constant({required this.w, required this.h}) {
    leftButtonPosition = Rect.fromLTWH(w / 40, h - h / 12, w / 20, h / 15);
    rightButtonPosition =
        Rect.fromLTWH(2 * w / 40 + w / 20, h - h / 12, w / 20, h / 15);
    jumpButtonPosition =
        Rect.fromLTWH(w / 40, h - w / 30 - h / 15 - h / 40, w / 30, w / 30);
  }
}
