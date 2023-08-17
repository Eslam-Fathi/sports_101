import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sports_101/UI/Screens/board_screen.dart';
import 'package:sports_101/UI/Screens/home_screen.dart';

//import 'package:flutter_svg_provider/flutter_svg_provider.dart';
class SplashScreen extends StatefulWidget {
  final bool showHome3;
  const SplashScreen({super.key, required this.showHome3});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              widget.showHome3 ? const HomeScreen() : const OnboardingScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          "assets/Images/sports-logo.png",
        ),
      ),
    );
  }
}
