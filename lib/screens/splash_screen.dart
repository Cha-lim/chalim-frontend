// flutter
import 'package:chalim/widgets/chalim_bottom_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// constants
import 'package:chalim/constants/sizes.dart';

// screens
import 'package:chalim/screens/language_select_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LanguageSelectScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double scaleFactor = MediaQuery.of(context).size.width / 400;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size56,
        ),
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Chalim',
                  style: TextStyle(
                    fontFamily: 'Bauhaus LT Heavy',
                    fontSize: Sizes.size72 * scaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: Sizes.size20),
                Image.asset(
                  'assets/images/logo.png',
                  width: 200 * scaleFactor,
                ),
                const SizedBox(height: Sizes.size20),
                Text(
                  'Menu Translation Service',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20 * scaleFactor,
                    fontFamily: 'Myriad Pro',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Spacer(),
                const ChalimBottomText(
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
