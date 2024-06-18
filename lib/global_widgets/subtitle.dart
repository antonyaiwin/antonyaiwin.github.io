import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/color_constants.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.asar(
        color: ColorConstants.secondaryGreen,
        textStyle: Theme.of(context).textTheme.titleLarge,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
