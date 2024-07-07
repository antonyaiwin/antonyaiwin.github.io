// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_personal_portfolio/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

import '../core/constants/string_constants.dart';

class GreetingsController extends ChangeNotifier {
  BuildContext? context;
  Size? size;

  double? containerHeight;
  double roundedContainerHeight = 100;
  double textOpacity = 0;
  int index = 0;
  int opacityDuration = 2000;
  GreetingsController();

  initTextTimer() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (index >= greetings.length - 1) {
        timer.cancel();
        // Future.delayed(const Duration(seconds: 1)).then((value) {

        //   // context?.read<HomeScreenController>().removeScrollPhysics();
        // });
        Timer(
          const Duration(milliseconds: 1000),
          () {
            textOpacity = 0;
            containerHeight = 0;
            opacityDuration = 400;
            notifyListeners();
          },
        );
        Timer(
          const Duration(milliseconds: 1300),
          () {
            roundedContainerHeight = 0;
            notifyListeners();
            context?.read<HomeScreenController>().removeScrollPhysics();
          },
        );

        return;
      }
      index++;
      notifyListeners();
    });
  }

  void initAnimation(BuildContext context) {
    size = MediaQuery.of(context).size;
    containerHeight ??= size!.height;

    this.context = context;
    textOpacity = 1;
    notifyListeners();
  }
}
