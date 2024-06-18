// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/utils/screen_utils/responsive.dart';

import 'components/name_widget.dart';
import 'components/profile_avatar.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Center(
        child: isMobile(context)
            ? Column(
                children: [
                  ProfileAvatar(),
                  const SizedBox(height: 10),
                  NameWidget(),
                ],
              )
            : Row(
                children: [
                  ProfileAvatar(),
                  const SizedBox(width: 50),
                  Expanded(
                    child: NameWidget(),
                  ),
                ],
              ),
      ),
    );
  }
}
