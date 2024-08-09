import 'package:flutter/material.dart';

import '../core/constants/color_constants.dart';
import '../core/constants/string_constants.dart';

class GreetingsAnimation extends StatefulWidget {
  const GreetingsAnimation({
    super.key,
    required this.child,
    this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.animationDuration,
  });
  final Widget child;
  final String? label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Duration animationDuration;

  @override
  State<GreetingsAnimation> createState() => _RouteAnimationState();
}

class _RouteAnimationState extends State<GreetingsAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController textAnimationController;
  late AnimationController opacityAnimationController;
  late Animation animation;
  late Animation textAnimation;
  late Animation opacityAnimation;

  BoxConstraints constraints = const BoxConstraints();
  double get width => constraints.maxWidth;
  double get height => constraints.maxHeight;

  double calculateChild1Height(double animationValue, double h) {
    // if (animationValue <= 0.5) {
    //   // Interpolates from 0 to 10% of h
    //   return (animationValue / 0.5) * 0.1 * h;
    // } else {
    // Interpolates back to 0 after 0.5
    return (1 - ((animationValue /* - 0.5 */) /* / 0.5 */)) * 0.1 * h;
    // }
  }

  // double calculateChild2Height(double animationValue, double h) {
  //   if (animationValue <= 0.5) {
  //     // Starts at 10% of h and stays there until 0.5
  //     return 0.1 * h * (1 - (animationValue / 0.5));
  //   } else {
  //     // Interpolates from 10% to 0 after 0.5
  //     return ((1 - (animationValue - 0.5) / 0.5)) * 0.1 * h;
  //   }
  // }

  // double calculateOpacity(double animationValue) {
  //   if (animationValue < 0.4 || animationValue > 0.6) {
  //     return 0.0;
  //   } else if (animationValue < 0.5) {
  //     // Increase from 0 to 1 between 0.4 and 0.5
  //     return (animationValue - 0.4) / 0.1;
  //   } else {
  //     // Decrease from 1 to 0 between 0.5 and 0.6
  //     return (0.6 - animationValue) / 0.1;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // reveal animation
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutQuart,
      ),
    );

    // text change animation
    textAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    textAnimation = IntTween(begin: 0, end: greetings.length - 1).animate(
      textAnimationController,
    );

    // text opacity change animation
    opacityAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1700));
    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: opacityAnimationController, curve: Curves.easeIn));

    opacityAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          textAnimationController.forward();
        }
      },
    );
    textAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 800)).then(
            (value) {
              opacityAnimationController.duration =
                  const Duration(milliseconds: 400);
              opacityAnimationController.reverse();

              animationController.forward();
            },
          );
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(const Duration(milliseconds: 50)).then(
          (value) {
            opacityAnimationController.forward();
          },
        );
      },
    );
    // _startDelayedAnimation();
  }

  /* void _startDelayedAnimation() {
    Future.delayed(const Duration(seconds: 1), () {
      animationController.reset();
      animationController.forward().then((_) {
        _startDelayedAnimation(); // Repeat the whole process
      });
    });
  } */

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        this.constraints = constraints;
        return AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Positioned(
                  top: calculateChild1Height(animation.value, height * 7),
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: widget.child,
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: (/* 1 - 2 * */ -animation.value) * height,
                  child: SizedBox(
                    height: height,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: SizedBox(
                            height:
                                calculateChild1Height(animation.value, height),
                            width: width,
                            child: RoundedContainer(
                              bottom: true,
                              backgroundColor: widget.backgroundColor,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            height: height,
                            width: width,
                            decoration: BoxDecoration(
                              color: widget.backgroundColor,
                            ),
                            child: Center(
                              child: AnimatedBuilder(
                                animation: opacityAnimationController,
                                builder: (context, _) {
                                  return AnimatedBuilder(
                                    animation: textAnimationController,
                                    builder: (context, _) {
                                      return Stack(
                                        children: List.generate(
                                          greetings.length,
                                          (index) => AnimatedOpacity(
                                            opacity:
                                                index == textAnimation.value
                                                    ? 1.0
                                                    : 0.0,
                                            duration: const Duration(
                                                milliseconds: 20),
                                            child: Text(
                                              '• ${greetings[index]}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.copyWith(
                                                    color: ColorConstants
                                                        .primaryWhite
                                                        .withOpacity(
                                                      opacityAnimation.value,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                      );
                                      // return Text(
                                      //   '• ${greetings[textAnimation.value]}',
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .headlineMedium
                                      //       ?.copyWith(
                                      //         color: ColorConstants.primaryWhite
                                      //             .withOpacity(
                                      //           opacityAnimation.value,
                                      //         ),
                                      //       ),
                                      // );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.bottom = false,
    required this.backgroundColor,
  });
  final bool bottom;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Transform.translate(
          offset: Offset(0, constraints.maxHeight * (bottom ? 1 : -1)),
          child: Transform.scale(
            scaleX: 1.5,
            scaleY: 7.5,
            alignment: bottom ? Alignment.bottomCenter : Alignment.topCenter,
            origin: Offset.zero,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
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
      },
    );
  }
}

// class CustomEasePauseCurve extends Curve {
//   @override
//   double transform(double t) {
//     return Curves.easeInOutQuart.transform(t);
//     if (t < 0.4) {
//       // Ease from 0.0 to 0.5 in the first 40% of the duration
//       return Curves.easeOutExpo.transform(t / 0.4) * 0.5;
//       // return 0.5;
//     } else if (t < 0.6) {
//       // Pause at 0.5 for 20% of the duration
//       return 0.5;
//     } else {
//       // Ease from 0.5 to 1.0 in the last 40% of the duration
//       return 0.5 + Curves.easeInOutQuart.transform((t - 0.6) / 0.4) * 0.5;
//     }
//   }
// }
