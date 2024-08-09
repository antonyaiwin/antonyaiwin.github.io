import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RouteAnimation extends StatefulWidget {
  const RouteAnimation({super.key});

  @override
  State<RouteAnimation> createState() => _RouteAnimationState();
}

class _RouteAnimationState extends State<RouteAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  BoxConstraints constraints = const BoxConstraints();
  double get width => constraints.maxWidth;
  double get height => constraints.maxHeight;

  double calculateChild1Height(double animationValue, double h) {
    if (animationValue <= 0.5) {
      // Interpolates from 0 to 10% of h
      return (animationValue / 0.5) * 0.1 * h;
    } else {
      // Interpolates back to 0 after 0.5
      return (1 - ((animationValue - 0.5) / 0.5)) * 0.1 * h;
    }
  }

  double calculateChild2Height(double animationValue, double h) {
    if (animationValue <= 0.5) {
      // Starts at 10% of h and stays there until 0.5
      return 0.1 * h * (1 - (animationValue / 0.5));
    } else {
      // Interpolates from 10% to 0 after 0.5
      return ((1 - (animationValue - 0.5) / 0.5)) * 0.1 * h;
    }
  }

  double calculateOpacity(double animationValue) {
    if (animationValue < 0.4 || animationValue > 0.6) {
      return 0.0;
    } else if (animationValue < 0.5) {
      // Increase from 0 to 1 between 0.4 and 0.5
      return (animationValue - 0.4) / 0.1;
    } else {
      // Decrease from 1 to 0 between 0.5 and 0.6
      return (0.6 - animationValue) / 0.1;
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: CustomEasePauseCurve(),
      ),
    );
    _startDelayedAnimation();
  }

  void _startDelayedAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      animationController.reset();
      animationController.forward().then((_) {
        _startDelayedAnimation(); // Repeat the whole process
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        this.constraints = constraints;
        return Stack(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Positioned(
                  right: 0,
                  left: 0,
                  top: (1 - 2 * animation.value) * height,
                  child: SizedBox(
                    height: height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: SizedBox(
                            height:
                                calculateChild1Height(animation.value, height),
                            width: width,
                            child: const RoundedContainer(),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: SizedBox(
                            height:
                                calculateChild1Height(animation.value, height),
                            width: width,
                            child: const RoundedContainer(
                              bottom: true,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            height: height * 0.8,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                'Hello',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      color: Colors.black.withOpacity(
                                        calculateOpacity(animation.value),
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
              },
            ),
          ],
        );
      },
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.bottom = false,
  });
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Transform.translate(
        offset: Offset(0, constraints.maxHeight * (bottom ? 1 : -1)),
        child: Transform.scale(
          scaleX: 1.5,
          scaleY: 7.5,
          alignment: bottom ? Alignment.bottomCenter : Alignment.topCenter,
          origin: Offset.zero,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              //  bottom
              //     ? Colors.yellow.withOpacity(0.2)
              //     : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.all(
                Radius.elliptical(
                  constraints.maxWidth / 2,
                  constraints.maxHeight / 2,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CustomEasePauseCurve extends Curve {
  @override
  double transform(double t) {
    if (t < 0.4) {
      // Ease from 0.0 to 0.5 in the first 40% of the duration
      return Curves.easeOutExpo.transform(t / 0.4) * 0.5;
    } else if (t < 0.6) {
      // Pause at 0.5 for 20% of the duration
      return 0.5;
    } else {
      // Ease from 0.5 to 1.0 in the last 40% of the duration
      return 0.5 + Curves.easeInQuint.transform((t - 0.6) / 0.4) * 0.5;
    }
  }
}
