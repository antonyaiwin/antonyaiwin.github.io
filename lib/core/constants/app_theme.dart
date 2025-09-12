import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_constants.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.lexendTextTheme().copyWith(
    bodyLarge: GoogleFonts.lexendTextTheme().bodyLarge?.copyWith(
          color: ColorConstants.primaryWhite,
        ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    fillColor: ColorConstants.navy,
    filled: true,
    hintStyle: GoogleFonts.lexendTextTheme().bodyMedium?.copyWith(
          color: ColorConstants.textFieldHintColor,
        ),
    isDense: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // side: const WidgetStatePropertyAll(
      //   BorderSide(
      //     color: ColorConstants.secondaryGreen,
      //   ),
      // ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(
        ColorConstants.primaryWhite,
      ),
      backgroundColor: const WidgetStatePropertyAll(
        ColorConstants.secondaryGreen2,
      ),
      overlayColor: WidgetStatePropertyAll(
        ColorConstants.secondaryGreen.withValues(alpha: 0.15),
      ),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.lexendTextTheme().bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: const WidgetStatePropertyAll(
        BorderSide(
          color: ColorConstants.secondaryGreen,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(
        ColorConstants.secondaryGreen,
      ),
      overlayColor: WidgetStatePropertyAll(
        ColorConstants.secondaryGreen.withValues(alpha: 0.15),
      ),
    ),
  ),
  useMaterial3: true,
);
