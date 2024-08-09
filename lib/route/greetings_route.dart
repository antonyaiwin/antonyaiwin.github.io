import 'package:flutter/material.dart';

import 'greetings_animation.dart';

class GreetingsRoute extends PageRouteBuilder {
  GreetingsRoute({
    required super.pageBuilder,
    this.label,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 2000),
  }) : super(
          transitionDuration:
              Duration(milliseconds: animationDuration.inMilliseconds ~/ 2),
          reverseTransitionDuration:
              Duration(milliseconds: animationDuration.inMilliseconds ~/ 2),
        );
  final String? label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Duration animationDuration;
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return GreetingsAnimation(
      label: label,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      animationDuration: animationDuration,
      child: child,
    );
  }
}
