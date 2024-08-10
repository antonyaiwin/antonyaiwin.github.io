import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/animated_cursor_controller.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  void hover(bool value) {
    read<AnimatedCursorController>().onLinkHover(value);
  }
}
