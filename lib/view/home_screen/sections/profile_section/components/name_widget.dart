import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/core/constants/string_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/screen_utils/responsive.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMobile(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, I\'m,',
          style: GoogleFonts.pattaya().copyWith(
            fontSize: 15,
            color: ColorConstants.primaryWhite,
          ),
        ),
        Text(
          'Antony Aiwin',
          style: GoogleFonts.spicyRice().copyWith(
            fontSize: 30,
            color: ColorConstants.primaryWhite,
          ),
        ),
        Text(
          'I\'m a Flutter Developer',
          style: GoogleFonts.balooPaaji2().copyWith(
            fontSize: 25,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Crafting beautiful, high-performance cross-platform mobile applications with Flutter.',
          style: GoogleFonts.balooPaaji2().copyWith(
            fontSize: 14,
            color: Colors.white54,
          ),
          textAlign: isMobile(context) ? TextAlign.center : TextAlign.start,
        ),
        Row(
          mainAxisAlignment: isMobile(context)
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                launchUrl(Uri.parse(linkedinUrl));
              },
              icon: const Icon(
                FontAwesome.linkedin_brand,
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
                TeenyIcons.stackoverflow,
              ),
            ),
          ],
        )
      ],
    );
  }
}
