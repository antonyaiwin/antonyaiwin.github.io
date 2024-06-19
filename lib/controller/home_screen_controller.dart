// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreenController extends ChangeNotifier {
  bool showBackToTop = false;

  ScrollController scrollController = ScrollController();
  HomeScreenController() {
    initListener();
  }
  void initListener() {
    scrollController.addListener(
      () {
        var offset = scrollController.offset;
        log('$showBackToTop : $offset');

        if (showBackToTop && offset < 100) {
          showBackToTop = !showBackToTop;
          notifyListeners();
        } else if (!showBackToTop && offset >= 100) {
          showBackToTop = !showBackToTop;
          notifyListeners();
        }
      },
    );
  }
}
