// flutter
import 'package:flutter/material.dart';

// libraries
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// screens
import 'package:chalim/screens/camera_screen.dart';

// widgets
import 'package:chalim/widgets/chalim_bottom_text.dart';

// constants
import 'package:chalim/constants/sizes.dart';

// models

// providers
import 'package:chalim/providers/language_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.selectedLanguage,
  });

  final Language selectedLanguage;

  void _onTapNavigateToCameraScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CameraScreen(),
      ),
    );
  }

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
                          _onTapNavigateToCameraScreen(context);
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
