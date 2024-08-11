import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/animated_cursor_controller.dart';
import 'package:provider/provider.dart';
import 'package:sprung/sprung.dart';

class LinkMouseRegion extends StatelessWidget {
  final Widget child;
  final bool elastic;

  const LinkMouseRegion({
    super.key,
    required this.child,
  }) : elastic = false;

  const LinkMouseRegion.elastic({
    super.key,
    required this.child,
  }) : elastic = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LinkMouseRegionController(
          context: context, child: child, elastic: elastic),
      builder: (context, child) => elastic
          ? _consumerWrap(const MyMouseRegion())
          : const MyMouseRegion(),
    );
  }

  Widget _consumerWrap(Widget child) {
    return Consumer<LinkMouseRegionController>(
      builder:
          (BuildContext context, LinkMouseRegionController value, Widget? _) =>
              AnimatedContainer(
        duration: value.duration,
        curve: value.curve,
        transform: Matrix4.translationValues(
          value.offset.dx,
          value.offset.dy,
          0.0,
        ),
        transformAlignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class MyMouseRegion extends StatelessWidget {
  const MyMouseRegion({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<LinkMouseRegionController>();

    return MouseRegion(
      onEnter: (event) {
        provider.onMouseEnter();
      },
      onExit: (event) {
        provider.onMouseExit();
      },
      onHover: provider.elastic
          ? (event) {
              provider.calculatePosition(event.localPosition);
              // log('delta : ${event.delta} localPosition:${event.localPosition}');
            }
          : null,
      opaque: false,
      child: provider.child,
    );
  }
}

class LinkMouseRegionController extends ChangeNotifier {
  Offset offset = Offset.zero;
  Curve curve = Curves.ease;
  Duration duration = const Duration(milliseconds: 300);
  final BuildContext context;
  final Widget child;
  final bool elastic;

  LinkMouseRegionController({
    required this.context,
    required this.child,
    required this.elastic,
  });

  void calculatePosition(Offset inputOffset) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    var width = renderBox.size.width;
    var height = renderBox.size.height;
    // var top =
    // Define the maximum range for the output offset
    const double maxOffset = 20.0;

    // Normalize the input offset to a range of 0 to 1
    double normalizedX = inputOffset.dx / width;
    double normalizedY = inputOffset.dy / height;

    // Scale the normalized values to the range of -maxOffset to +maxOffset
    double outputX = normalizedX * maxOffset - maxOffset / 2;
    double outputY = normalizedY * maxOffset - maxOffset / 2;
// double outputX = (normalizedX * 2 - 1) * maxOffset;
//     double outputY = (normalizedY * 2 - 1) * maxOffset;

    offset = Offset(outputX, outputY);
    // log('out offset : ${offset.toString()}');
    notifyListeners();
  }

  void onMouseEnter() {
    context.read<AnimatedCursorController>().onLinkHover(true);
    if (!elastic) {
      return;
    }
    curve = Curves.ease;
    duration = const Duration(milliseconds: 300);
    notifyListeners();
  }

  void onMouseExit() {
    context.read<AnimatedCursorController>().onLinkHover(false);
    if (!elastic) {
      return;
    }
    curve = Sprung.custom(
      damping: 15,
      stiffness: 500,
    );
    duration = const Duration(milliseconds: 1000);
    offset = Offset.zero;
    notifyListeners();
  }
}
