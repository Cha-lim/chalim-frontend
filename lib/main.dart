// flutter
import 'package:flutter/material.dart';

// screens
import 'package:chalim/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chalim',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xfff64e26),
        fontFamily: 'Myriad Pro',
      ),
      home: const SplashScreen(),
    );
  }
}
