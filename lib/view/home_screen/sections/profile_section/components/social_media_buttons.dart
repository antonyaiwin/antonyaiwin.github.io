import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/extensions/widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/string_constants.dart';
import '../../../../../utils/screen_utils/responsive.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({
    super.key,
  });

  static Map<IconData, String> socialMediaMap = {
    Ionicons.logo_linkedin: linkedinUrl,
    EvaIcons.github: githubUrl,
    Ionicons.logo_stackoverflow: stackOverflowUrl,
    Ionicons.mail: mailUrl,
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: isMobile(context) ? WrapAlignment.center : WrapAlignment.start,
      spacing: 10,
      children: socialMediaMap.keys
          .map(
            (key) => IconButton(
              onPressed: () {
                launchUrl(Uri.parse(socialMediaMap[key] ?? ''));
              },
              icon: Icon(
                key,
              ),
            ).hoverElastic,
          )
          .toList(),
    );
  }
}
