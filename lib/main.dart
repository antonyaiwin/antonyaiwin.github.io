import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/controller/contact_section_controller.dart';
import 'package:flutter_personal_portfolio/controller/greetings_controller.dart';
import 'package:flutter_personal_portfolio/controller/home_screen_controller.dart';
import 'package:flutter_personal_portfolio/core/constants/color_constants.dart';
import 'package:flutter_personal_portfolio/view/home_screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GreetingsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactSectionController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            fillColor: ColorConstants.navy,
            filled: true,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorConstants.textFieldHintColor,
                ),
            isDense: true,
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              side: const MaterialStatePropertyAll(
                BorderSide(
                  color: ColorConstants.secondaryGreen,
                ),
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              foregroundColor: const MaterialStatePropertyAll(
                ColorConstants.secondaryGreen,
              ),
              overlayColor: MaterialStatePropertyAll(
                ColorConstants.secondaryGreen.withOpacity(0.15),
              ),
            ),
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
