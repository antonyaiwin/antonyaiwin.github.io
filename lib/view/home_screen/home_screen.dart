import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/extensions/widget.dart';
import 'package:flutter_personal_portfolio/utils/screen_utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';
import 'components/home_screen_back_to_top_floating_button.dart';
import 'components/home_screen_drawer.dart';
import 'components/resume_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<HomeScreenController>();
    return DefaultTabController(
      length: provider.navBarItems.length,
      child: Scaffold(
        key: provider.scaffoldKey,
        endDrawer: isbelow750(context) ? const HomeScreenDrawer() : null,
        body: Consumer<HomeScreenController>(
          builder: (BuildContext context, value, Widget? child) =>
              CustomScrollView(
            key: provider.scrollViewKey,
            controller: context.read<HomeScreenController>().scrollController,
            slivers: [
              SliverAppBar(
                title: const Text('antony aiwin'),
                pinned: true,
                backgroundColor: Colors.transparent,
                actions:
                    isbelow750(context) ? _mobileNav() : _desktopNav(provider),
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: ColorConstants.navy.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              ...value.sectionWidgets.map(
                (e) => SliverToBoxAdapter(
                  key: provider.keys[value.sectionWidgets.indexOf(e)],
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(15).copyWith(
                        top: 25,
                        bottom: 0,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.loose(const Size.fromWidth(1000)),
                          child: e,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 15)),
            ],
          ),
        ),
        floatingActionButton: const HomeScreenBackToTopFloatingButton(),
      ),
    );
  }

  List<Widget> _desktopNav(HomeScreenController provider) {
    return [
      Builder(
        builder: (context) {
          provider.tabContext = context;
          return TabBar(
            labelColor: ColorConstants.secondaryGreen,
            unselectedLabelColor:
                ColorConstants.secondaryGreen.withOpacity(0.7),
            indicatorPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            indicatorColor: ColorConstants.secondaryGreen,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            dividerHeight: 0,
            overlayColor: WidgetStatePropertyAll(
              ColorConstants.secondaryGreen.withOpacity(0.15),
            ),
            splashBorderRadius: BorderRadius.circular(10),
            tabAlignment: TabAlignment.start,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            tabs: List.generate(
              provider.navBarItems.length,
              (index) => Tab(
                text: provider.navBarItems[index],
              ),
            ),
            onTap: (int index) => provider.scrollToChild(index),
          ).hover;
        },
      ),
      const SizedBox(width: 5),
      const ResumeButton(),
      const SizedBox(width: 10),
    ];
  }

  List<Widget> _mobileNav() {
    return [
      Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Transform.flip(
              flipX: true,
              child: const Icon(Icons.sort),
            ),
          ).hover;
        },
      ),
    ];
  }
}
