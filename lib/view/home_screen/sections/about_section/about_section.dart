import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/core/constants/string_constants.dart';
import 'package:flutter_personal_portfolio/global_widgets/subtitle.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Subtitle(text: 'About'),
        const SizedBox(height: 10),
        Text(
          aboutMe,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorConstants.white70,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
