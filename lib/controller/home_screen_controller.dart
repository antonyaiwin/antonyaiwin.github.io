// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreenController extends ChangeNotifier {
  bool showBackToTop = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<GlobalKey> keys = List.generate(5, (index) => GlobalKey());
  List<String> navBarItems = [
    'Profile',
    'About',
    'Experience',
    'Projects',
    'Contact',
  ];
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

  void scrollToChild(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      // Get the offset of the widget
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero,
          ancestor: context.findRenderObject()?.parent as RenderObject);
      log(' child offet : $offset');
      // Scroll to the offset
      scrollController.animateTo(
        offset.dy - kToolbarHeight /* +
            scrollController.offset */
        , // Adjust for current scroll position
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}
