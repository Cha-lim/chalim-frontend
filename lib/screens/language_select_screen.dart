// flutter
import 'package:chalim/screens/home_screen.dart';
import 'package:chalim/widgets/chalim_bottom_text.dart';
import 'package:flutter/material.dart';

// constants
import 'package:chalim/constants/sizes.dart';

// models
import 'package:chalim/models/languages.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  Language _selectedLanguage = Language.english;

  var languages = [
    Language.english,
    Language.japanese,
    Language.chinese,
  ];

  void _onLanguageSelected(Language language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                ListView(
                  shrinkWrap: true,
                  children: languages
                      .map(
                        (language) => ListTile(
                          title: Text(
                            language.toString().split('.').last,
                            style: TextStyle(
                              fontFamily: 'Myriad Pro',
                              fontSize: language == _selectedLanguage
                                  ? Sizes.size40
                                  : Sizes.size32,
                              fontWeight: language == _selectedLanguage
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            _onLanguageSelected(language);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => const HomeScreen()),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
                const Spacer(),
                ChalimBottomText(textColor: Theme.of(context).primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
