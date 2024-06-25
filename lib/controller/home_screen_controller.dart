import 'package:flutter/material.dart';

class HomeScreenController extends ChangeNotifier {
  bool showBackToTop = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<GlobalKey> keys = List.generate(5, (index) => GlobalKey());
  BuildContext? tabContext;
  List<String> navBarItems = [
    'Profile',
    'About',
    'Experience',
    'Projects',
    'Contact',
  ];
  ScrollController scrollController = ScrollController();
  ScrollPhysics? scrollPhysics = const NeverScrollableScrollPhysics();
  HomeScreenController() {
    _initListener();
  }
  void _initListener() {
    scrollController.addListener(
      () {
        var offset = scrollController.offset;
        // log('$showBackToTop : $offset');

        if (showBackToTop && offset < 100) {
          showBackToTop = !showBackToTop;
          notifyListeners();
        } else if (!showBackToTop && offset >= 100) {
          showBackToTop = !showBackToTop;
          notifyListeners();
        }
      },
    );
    scrollController.addListener(scrollListener);
  }

  //remove scroll physics
  removeScrollPhysics() {
    scrollPhysics = null;
    notifyListeners();
  }

  // ScrollController Listener for scrolling listview and tabbar
  void scrollListener() {
    if (tabContext == null) {
      return;
    }
    double scrollOffset = scrollController.offset;

    // logic to scroll tab bar index
    // double childPosition = 0;
    for (var i = keys.length - 1; i >= 0; i--) {
      final context = keys[i].currentContext;
      if (context != null) {
        // Get the offset of the widget
        final box = context.findRenderObject() as RenderBox;
        final childOffset = box.localToGlobal(Offset.zero,
            ancestor: context.findRenderObject()?.parent as RenderObject);
        // log(' child offet : $offset');
        // Scroll to the offset

        /* +
            scrollController.offset */

        if (scrollOffset >= childOffset.dy - kToolbarHeight) {
          DefaultTabController.of(tabContext!).animateTo(
            i,
          );
          break;
        }
      }

      // print('iteration $i\n child Position = $childPosition');
    }

    // print('offset : ${_scrollController.offset}');
  }

  Future<void> scrollToChild(GlobalKey key) async {
    final context = key.currentContext;
    scrollController.removeListener(scrollListener);
    if (context != null) {
      // Get the offset of the widget
      final box = context.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero,
          ancestor: context.findRenderObject()?.parent as RenderObject);
      // log(' child offet : $offset');
      // Scroll to the offset
      await scrollController.animateTo(
        offset.dy - kToolbarHeight /* +
            scrollController.offset */
        , // Adjust for current scroll position
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
    scrollController.addListener(scrollListener);
  }
}
