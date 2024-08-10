import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/animated_cursor_controller.dart';
import 'package:provider/provider.dart';

class LinkMouseRegion extends StatelessWidget {
  const LinkMouseRegion({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) =>
          context.read<AnimatedCursorController>().onLinkHover(true),
      onExit: (event) =>
          context.read<AnimatedCursorController>().onLinkHover(false),
      opaque: false,
      child: child,
    );
  }
}
