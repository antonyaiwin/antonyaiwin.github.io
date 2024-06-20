import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/utils/screen_utils/responsive.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/about_section/about_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/contact_section/contact_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/footer_section/footer_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/projects_section/projects_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/skills_section/skills_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/work_section/work_section.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/home_screen_controller.dart';
import 'components/home_screen_back_to_top_floating_button.dart';
import 'components/home_screen_drawer.dart';
import 'sections/profile_section/profile_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double sectionSpacing = 25;
    var provider = context.read<HomeScreenController>();
    return Scaffold(
      key: provider.scaffoldKey,
      endDrawer: isbelow750(context) ? const HomeScreenDrawer() : null,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('antony aiwin'),
        backgroundColor: Colors.transparent,
        actions: isbelow750(context) ? _mobileNav() : _desktopNav(provider),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: ColorConstants.navy.withOpacity(0.7),
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          controller: context.read<HomeScreenController>().scrollController,
          padding: const EdgeInsets.all(15).copyWith(
            top: 50,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size.fromWidth(1000)),
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
      floatingActionButton: const HomeScreenBackToTopFloatingButton(),
    );
  }

  List<Widget> _desktopNav(HomeScreenController provider) {
    return [
      ...List.generate(
        provider.navBarItems.length,
        (index) => TextButton(
          onPressed: () {
            provider.scrollToChild(provider.keys[index]);
          },
          child: Text(
            provider.navBarItems[index],
            style: const TextStyle(
              color: ColorConstants.secondaryGreen,
            ),
          ),
        ),
      ),
      const SizedBox(width: 5),
      OutlinedButton(
        onPressed: () {
          launchUrl(Uri.parse('/Antony-Aiwin-Flutter-Developer.pdf'));
        },
        child: const Text('My Resume'),
      ),
      const SizedBox(width: 10),
    ];
  }

  List<Widget> _mobileNav() {
    return [
      Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: Transform.flip(
            flipX: true,
            child: const Icon(Icons.sort),
          ),
        );
      }),
    ];
  }
}
