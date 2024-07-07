import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

final GlobalKey childKey = GlobalKey();

class ParallaxScrollView extends StatefulWidget {
  const ParallaxScrollView({super.key});

  @override
  _ParallaxScrollViewState createState() => _ParallaxScrollViewState();
}

class _ParallaxScrollViewState extends State<ParallaxScrollView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(30, (index) {
                if (index == 25) {
                  return ParallaxImage(
                      key: childKey, scrollController: _scrollController);
                } else {
                  return Container(
                    height: 200,
                    color: Colors.blue[(index % 9 + 1) * 100],
                    child: Center(child: Text('Item $index')),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class ParallaxImage extends StatelessWidget {
  final ScrollController scrollController;
  const ParallaxImage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) {
                // double offset = 0;
                // if (scrollController.hasClients) {
                // offset = scrollController.offset;
                // }
                double screenHeight = MediaQuery.of(context).size.height;
                double screenWidth = MediaQuery.of(context).size.width;

                double lowerBound =
                    getScrollOffset(key as GlobalKey<State<StatefulWidget>>?);
                // double upperBound = lowerBound + screenHeight - screenWidth;
                // log('$offset: $lowerBound: $upperBound');

                // double parallaxOffset = offset - lowerBound;
                double parallaxOffset = /* screenHeight - */ lowerBound;
                parallaxOffset =
                    (parallaxOffset * screenWidth * (9 / 16)) / screenHeight;
                log('parallax before: $parallaxOffset');

                parallaxOffset = parallaxOffset.clamp(
                    0.0,
                    MediaQuery.of(context).size.width *
                        (9 / 16)); // Clamp to ensure correct offset
                log('parallax : $parallaxOffset');
                return Positioned(
                  top: -parallaxOffset,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/Artboard 3.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  double getScrollOffset(GlobalKey? key) {
    // double scrollOffset = scrollController.offset;

    // logic to scroll tab bar index
    // double childPosition = 0;
    final context = key?.currentContext;
    if (context != null) {
      // Get the offset of the widget
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) {
        return -1;
      }
      double offsetY = box.localToGlobal(Offset.zero).dy;
      final childOffset = box.localToGlobal(Offset.zero,
          ancestor: context
              .read<HomeScreenController>()
              .scrollViewKey
              .currentContext
              ?.findRenderObject() as RenderObject);
      log('offsetY = $offsetY');
      log('childoffset = $childOffset');
      // log(' child offet : $offset');
      // Scroll to the offset

      /* +
            scrollController.offset */

      // if (scrollOffset >= childOffset.dy - kToolbarHeight) {
      //   DefaultTabController.of(tabContext!).animateTo(
      //     i,
      //   );
      //   break;
      // }
      return offsetY;
    }
    return -1;
  }
}
