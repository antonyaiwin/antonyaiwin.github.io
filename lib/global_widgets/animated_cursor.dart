import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:provider/provider.dart';

import 'package:flutter_personal_portfolio/controller/animated_cursor_controller.dart';

class AnimatedCursor extends StatelessWidget {
  const AnimatedCursor({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnimatedCursorController(),
      builder: (context, _) => Consumer<AnimatedCursorController>(
        child: child,
        builder: (context, value, child) => Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapDown: (details) => _onTapDown(details, context),
                onTapUp: (details) => _onTapUp(details, context),
                onTapCancel: () => _onTapCancel(context),
                onPanUpdate: (details) => _onPanUpdate(details, context),
                child: child!,
              ),
            ),
            Positioned.fill(
              child: MouseRegion(
                cursor: SystemMouseCursors.none,
                opaque: false,
                onHover: (event) => _onMouseHover(event, context),
              ),
            ),
            Visibility(
              visible: value.offset != Offset.zero,
              child: AnimatedPositioned(
                top: value.offset.dy - value.outerCircleDiameter / 2,
                left: value.offset.dx - value.outerCircleDiameter / 2,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: IgnorePointer(
                  child: AnimatedContainer(
                    height: value.outerCircleDiameter,
                    width: value.outerCircleDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: value.color,
                        width: 0.5,
                      ),
                    ),
                    duration: const Duration(milliseconds: 200),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: value.offset != Offset.zero,
              child: AnimatedPositioned(
                top: value.offset.dy - value.outerCircleDiameter / 2,
                left: value.offset.dx - value.outerCircleDiameter / 2,
                duration: Duration.zero,
                curve: Curves.easeOut,
                child: IgnorePointer(
                  child: SizedBox(
                    width: value.outerCircleDiameter,
                    height: value.outerCircleDiameter,
                    child: Center(
                      child: AnimatedContainer(
                        height: value.tapDown
                            ? value.outerCircleDiameter
                            : value.innerCircleDiameter,
                        width: value.tapDown
                            ? value.outerCircleDiameter
                            : value.innerCircleDiameter,
                        decoration: BoxDecoration(
                          color: value.color,
                          shape: BoxShape.circle,
                        ),
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMouseHover(PointerHoverEvent event, BuildContext context) {
    log(event.toString());
    context.read<AnimatedCursorController>().updatePosition(event.position);
  }

  _onTapDown(TapDownDetails details, BuildContext context) {
    log(details.toString());
    context.read<AnimatedCursorController>().onTapDown();
  }

  _onTapUp(TapUpDetails details, BuildContext context) {
    log(details.toString());
    context.read<AnimatedCursorController>().onTapUp();
  }

  _onTapCancel(BuildContext context) {
    log('onTapCancel');
    context.read<AnimatedCursorController>().onTapUp();
  }

  _onPanUpdate(DragUpdateDetails details, BuildContext context) {
    context.read<AnimatedCursorController>().onPanUpdate(details);
  }
}
