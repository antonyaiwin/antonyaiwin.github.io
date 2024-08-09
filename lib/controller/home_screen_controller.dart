import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../view/home_screen/sections/about_section/about_section.dart';
import '../view/home_screen/sections/contact_section/contact_section.dart';
import '../view/home_screen/sections/footer_section/footer_section.dart';
import '../view/home_screen/sections/profile_section/profile_section.dart';
import '../view/home_screen/sections/projects_section/projects_section.dart';
import '../view/home_screen/sections/skills_section/skills_section.dart';
import '../view/home_screen/sections/work_section/work_section.dart';

class HomeScreenController extends ChangeNotifier {
  bool showBackToTop = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<GlobalKey> keys = List.generate(7, (index) => GlobalKey());
  BuildContext? tabContext;
  List<String> navBarItems = [
    'Profile',
    'About',
    'Experience',
    'Projects',
    'Contact',
  ];
  List<Widget> sectionWidgets = [];
  ScrollController scrollController = ScrollController();
  HomeScreenController() {
    sectionWidgets = [
      const ProfileSection(),
      const AboutSection(),
      const SkillsSection(),
      const WorkSection(),
      const ProjectsSection(),
      const ContactSection(),
      const FooterSection(),
    ];
    _initListener();
  }

  GlobalKey scrollViewKey = GlobalKey();

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

  GlobalKey _getKey(int index) {
    if (index < 2) {
      return keys[index];
    } else {
      return keys[index + 1];
    }
  }

  Future<void> scrollToChild(int index) async {
    var key = _getKey(index);
    final context = key.currentContext;
    scrollController.removeListener(scrollListener);
    if (context != null) {
      // Get the offset of the widget
      final box = context.findRenderObject() as RenderSliver;
      // final offset = box.localToGlobal(Offset.zero,
      //     ancestor: context.findRenderObject()?.parent as RenderObject);
      final offset = box.constraints.precedingScrollExtent;
      // log('offset: $offset\npaintExtend : ${box.constraints.remainingPaintExtent}\nscroll offset : ${scrollController.offset}');
      // log(box.constraints.toString());
      // log(' child offet : $offset');
      // Scroll to the offset
      await scrollController.animateTo(
        offset - kToolbarHeight /* +
            scrollController.offset */
        , // Adjust for current scroll position
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
    scrollController.addListener(scrollListener);
  }
}
