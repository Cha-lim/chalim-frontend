// flutter
import 'package:chalim/screens/camera_screen.dart';
import 'package:chalim/widgets/chalim_bottom_text.dart';
import 'package:flutter/material.dart';

// libraries
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// screens

// widgets

// constants
import 'package:chalim/constants/sizes.dart';

// models
import 'package:chalim/models/languages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.selectedLanguage,
  });

  final Language selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          body: Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                  vertical: Sizes.size56,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 150,
                        height: 200,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: Sizes.size40),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => CameraScreen(
                                  selectedLanguage: selectedLanguage),
                            ),
                          );
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.camera,
                          size: Sizes.size96,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Spacer(),
                      ChalimBottomText(
                          textColor: Theme.of(context).primaryColor)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
