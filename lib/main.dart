import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/core/constants/app_theme.dart';
import 'package:provider/provider.dart';

import 'package:flutter_personal_portfolio/controller/contact_section_controller.dart';
import 'package:flutter_personal_portfolio/controller/home_screen_controller.dart';
import 'package:flutter_personal_portfolio/global_widgets/animated_cursor.dart';

import 'view/greetings_screen/greetings_screen.dart';

@JS('hideSplash') // bind directly to JS function defined in index.html
external void hideSplash();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());

  // Call the JS function defined in index.html
  // Call the global JS function
  hideSplash();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => GreetingsController(),
        // ),
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactSectionController(),
        ),
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedCursor(
          child: MaterialApp(
            title: 'Antony Aiwin - Flutter Developer',
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            home: const GreetingsScreen(),
          ),
        ),
      ),
    );
  }
}
