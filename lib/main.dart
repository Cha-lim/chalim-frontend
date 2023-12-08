// flutter
import 'package:flutter/material.dart';

// libraries

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// screens
import 'package:chalim/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

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
          elevation: 0,
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
