import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/home_screen_controller.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/core/constants/string_constants.dart';
import 'package:provider/provider.dart';

class GreetingsScreen extends StatefulWidget {
  const GreetingsScreen({super.key});

  @override
  TweenAnimationState createState() => TweenAnimationState();
}

class TweenAnimationState
    extends State<GreetingsScreen> /*     with TickerProviderStateMixin  */ {
  // AnimationController? opacityController;
  // AnimationController? greetingsController;
  // AnimationController? heightController;

  // Animation<int>? greetingsAnimation;
  // Animation<double>? opacityAnimation;
  // Animation<double>? containerHeightAnimation;
  // Animation<double>? roundedBottomHeightAnimation;
  // late Animation<Rect?> rectAnimation;

  @override
  void initState() {
    // containerHeight = size.height;

    // opacityController = AnimationController(
    //   duration: const Duration(seconds: 2),
    //   vsync: this,
    // );
    // opacityAnimation = Tween(
    //   begin: 0.0,
    //   end: 1.0,
    // ).animate(opacityController!);
    // opacityAnimation?.addStatusListener((status) {
    //   log('$status');
    //   if (status == AnimationStatus.completed) {
    //     initTextChangeAnim();
    //   }
    // });
    // greetingsController = AnimationController(
    //   duration: const Duration(seconds: 4),
    //   vsync: this,
    // );
    // heightController = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,

    // );

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   opacityController?.forward();
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        textOpacity = 1;
      });
    });
    super.initState();
  }

  // initTextChangeAnim() {
  //   log('init text change');

  //   greetingsAnimation = StepTween(
  //     begin: 0,
  //     end: greetings.length - 1,
  //   ).animate(greetingsController!);
  //   greetingsAnimation!.addStatusListener((status) {
  //     log('$status');

  //     if (status == AnimationStatus.completed) {
  //       initHeightChangeAnim();
  //     }
  //   });
  //   greetingsController?.forward();
  // }

  // initHeightChangeAnim() {
  //   log('init text change');

  //   containerHeightAnimation = Tween(
  //     begin: size.height,
  //     end: 0.0,

  //   ).animate(heightController!);

  //   roundedBottomHeightAnimation = Tween(
  //     begin: 50.0,
  //     end: 0.0,
  //   ).animate(heightController!);
  //   opacityController?.reverse();
  //   heightController?.forward();
  // }

  Size get size => MediaQuery.of(context).size;

  double? containerHeight;
  double roundedContainerHeight = 50;
  double textOpacity = 0;
  int index = 0;
  int opacityDuration = 2000;

  initTextTimer() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (index >= greetings.length - 1) {
        timer.cancel();
        Future.delayed(const Duration(seconds: 1)).then((value) {
          setState(() {
            textOpacity = 0;
            containerHeight = 0;
            roundedContainerHeight = 0;
            opacityDuration = 800;
          });
          context.read<HomeScreenController>().removeScrollPhysics();
        });

        return;
      }
      index++;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    containerHeight ??= size.height;

    log('build');
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastEaseInToSlowEaseOut,
          decoration: const BoxDecoration(
            color: ColorConstants.greetingsBackground,
          ),
          height: containerHeight,
          child: Center(
            child: AnimatedOpacity(
              opacity: textOpacity,
              duration: Duration(milliseconds: opacityDuration),
              child: Text(
                '• ${greetings[index]}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    // color: ColorConstants.primaryWhite,
                    ),
              ),
              onEnd: () {
                initTextTimer();
              },
            ),
          ),
        ),
        ClipPath(
          clipper: BottomRounded(),
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 800,
            ),
            height: roundedContainerHeight,
            width: double.infinity,
            color: ColorConstants.greetingsBackground,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // opacityController?.dispose();
    // greetingsController?.dispose();
    // heightController?.dispose();
    super.dispose();
  }
}

class BottomRounded extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 2,
      size.width,
      0,
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
