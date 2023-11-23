// flutter
import 'package:flutter/material.dart';

// screens
import 'package:chalim/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chalim',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xfff64e26),
        fontFamily: 'Myriad Pro',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xfff64e26),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Color(0xfff64e26),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
