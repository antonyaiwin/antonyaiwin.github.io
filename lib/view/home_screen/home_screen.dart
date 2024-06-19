// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/contact_section/contact_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/footer_section/footer_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/projects_section/projects_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/work_section/work_section.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';
import 'sections/profile_section/profile_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(Size.fromWidth(1000)),
          child: SingleChildScrollView(
            controller: context.read<HomeScreenController>().scrollController,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                ProfileSection(),
                const SizedBox(height: 10),
                WorkSection(),
                const SizedBox(height: 10),
                ProjectsSection(),
                const SizedBox(height: 10),
                ContactSection(),
                const SizedBox(height: 10),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<HomeScreenController>(
        builder: (BuildContext context, value, Widget? child) {
          return AnimatedScale(
            scale: value.showBackToTop ? 1 : 0,
            // offset: Offset(0, value.showBackToTop ? 0 : 3),
            duration: Duration(milliseconds: 200),
            child: FloatingActionButton(
              onPressed: () {
                context.read<HomeScreenController>().scrollController.animateTo(
                      0,
                      duration: Duration(
                        milliseconds: 700,
                      ),
                      curve: Curves.easeInOut,
                    );
              },
              backgroundColor: ColorConstants.lightNavy2,
              child: Icon(
                Icons.arrow_upward_rounded,
              ),
            ),
          );
        },
      ),
    );
  }
}
