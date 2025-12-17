import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Image.asset(
            height: 120,
            width: 120,
            'assets/gifs/happy-friends.gif',
          ),
        ),
      );
  }
}
