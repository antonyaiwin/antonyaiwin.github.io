import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/screen_utils/responsive.dart';
import 'social_media_buttons.dart';

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
          textAlign: isMobile(context) ? TextAlign.center : null,
        ),
        Text(
          'Crafting beautiful, high-performance cross-platform mobile applications with Flutter.',
          style: GoogleFonts.balooPaaji2().copyWith(
            fontSize: 14,
            color: Colors.white54,
          ),
          textAlign: isMobile(context) ? TextAlign.center : TextAlign.start,
        ),
        const SocialMediaButtons()
      ],
    );
  }
}
