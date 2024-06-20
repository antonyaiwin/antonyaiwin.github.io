import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_screen_controller.dart';
import '../../../core/constants/color_constants.dart';

class HomeScreenBackToTopFloatingButton extends StatelessWidget {
  const HomeScreenBackToTopFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(
      builder: (BuildContext context, value, Widget? child) {
        return AnimatedScale(
          scale: value.showBackToTop ? 1 : 0,
          // offset: Offset(0, value.showBackToTop ? 0 : 3),
          duration: const Duration(milliseconds: 200),
          child: FloatingActionButton(
            onPressed: () {
              context.read<HomeScreenController>().scrollController.animateTo(
                    0,
                    duration: const Duration(
                      milliseconds: 700,
                    ),
                    curve: Curves.easeInOut,
                  );
            },
            backgroundColor: ColorConstants.lightNavy2,
            child: const Icon(
              Icons.arrow_upward_rounded,
            ),
          ),
        );
      },
    );
  }
}
