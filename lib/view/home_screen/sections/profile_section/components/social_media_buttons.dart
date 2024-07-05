import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/string_constants.dart';
import '../../../../../utils/screen_utils/responsive.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMobile(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            launchUrl(Uri.parse(linkedinUrl));
          },
          icon: const Icon(
            Ionicons.logo_linkedin,
          ),
        ),
        IconButton(
          onPressed: () {
            launchUrl(Uri.parse(githubUrl));
          },
          icon: const Icon(
            EvaIcons.github,
          ),
        ),
        IconButton(
          onPressed: () {
            launchUrl(Uri.parse(stackOverflowUrl));
          },
          icon: const Icon(
            Ionicons.logo_stackoverflow,
          ),
        ),
        IconButton(
          onPressed: () {
            launchUrl(Uri.parse(mailUrl));
          },
          icon: const Icon(
            Ionicons.mail,
          ),
        ),
      ],
    );
  }
}
