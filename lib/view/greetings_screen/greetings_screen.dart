import 'package:flutter/material.dart';
import 'package:flutter_personal_portfolio/route/greetings_route.dart';
import 'package:flutter_personal_portfolio/view/home_screen/home_screen.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Navigator.pushReplacement(
          context,
          GreetingsRoute(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
          ),
        );
      },
    );
    return const SizedBox();
  }
}
