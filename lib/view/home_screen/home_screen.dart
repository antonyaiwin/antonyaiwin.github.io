// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/contact_section/contact_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/footer_section/footer_section.dart';
import 'package:flutter_personal_portfolio/view/home_screen/sections/work_section/work_section.dart';

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
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                ProfileSection(),
                WorkSection(),
                ContactSection(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
