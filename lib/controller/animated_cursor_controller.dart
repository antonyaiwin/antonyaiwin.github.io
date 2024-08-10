import 'dart:developer';

import 'package:flutter/material.dart';

class AnimatedCursorController extends ChangeNotifier {
  bool tapDown = false;
  Offset offset = Offset.zero;
  final double outerCircleDiameter = 50;
  final double innerCircleDiameter = 7;
  final Color color = Colors.white.withOpacity(0.3);

  void updatePosition(Offset offset) {
    this.offset = offset;
    notifyListeners();
  }

  void onTapDown() {
    tapDown = true;
    notifyListeners();
  }

  void onTapUp() {
    tapDown = false;
    notifyListeners();
  }

  void onPanUpdate(DragUpdateDetails details) {
    log(details.toString());
    offset += details.delta;
    notifyListeners();
  }
}
