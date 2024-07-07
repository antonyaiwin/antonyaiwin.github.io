import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/utils/screen_utils/responsive.dart';
import 'package:flutter_personal_portfolio/view/greetings_screen/greetings_screen.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/about_section/about_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/contact_section/contact_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/footer_section/footer_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/projects_section/projects_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/skills_section/skills_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/work_section/work_section.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';
import 'components/home_screen_back_to_top_floating_button.dart';
import 'components/home_screen_drawer.dart';
import 'components/resume_button.dart';
import 'sections/profile_section/profile_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double sectionSpacing = 25;
    var provider = context.read<HomeScreenController>();
    return DefaultTabController(
      length: provider.keys.length,
      child: Scaffold(
        key: provider.scaffoldKey,
        endDrawer: isbelow750(context) ? const HomeScreenDrawer() : null,
        body: Consumer<HomeScreenController>(
          builder: (BuildContext context, value, Widget? child) =>
              CustomScrollView(
            key: provider.scrollViewKey,
            controller: context.read<HomeScreenController>().scrollController,
            physics: value.scrollPhysics,
            slivers: [
              const SliverToBoxAdapter(
                child: GreetingsScreen(),
              ),
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
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15).copyWith(
                      top: 15,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints.loose(const Size.fromWidth(1000)),
                        child: Column(
                          children: [
                            ProfileSection(key: provider.keys[0]),
                            const SizedBox(height: sectionSpacing),
                            AboutSection(key: provider.keys[1]),
                            const SizedBox(height: sectionSpacing),
                            const SkillsSection(),
                            const SizedBox(height: sectionSpacing),
                            WorkSection(key: provider.keys[2]),
                            const SizedBox(height: sectionSpacing),
                            ProjectsSection(key: provider.keys[3]),
                            const SizedBox(height: sectionSpacing),
                            ContactSection(key: provider.keys[4]),
                            const SizedBox(height: sectionSpacing),
                            const FooterSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
            onTap: (int index) => provider.scrollToChild(provider.keys[index]),
          );
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
          );
        },
      ),
    ];
  }
}
