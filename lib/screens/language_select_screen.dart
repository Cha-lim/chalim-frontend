// flutter
import 'package:flutter/material.dart';

// libraries
import 'package:flutter_riverpod/flutter_riverpod.dart';

// screens
import 'package:chalim/screens/home_screen.dart';

// widgets
import 'package:chalim/widgets/chalim_bottom_text.dart';

// constants
import 'package:chalim/constants/sizes.dart';

// models & providers
import 'package:chalim/providers/language_provider.dart';

class LanguageSelectScreen extends ConsumerStatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  ConsumerState<LanguageSelectScreen> createState() =>
      _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends ConsumerState<LanguageSelectScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(languageProvider);
    ref.read(languageSelectProvider);
  }

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = ref.watch(languageSelectProvider);

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
                  children: ref
                      .read(languageProvider)
                      .map(
                        (language) => ListTile(
                          title: Text(
                            '${language.toString().split('.').last[0].toUpperCase()}${language.toString().split('.').last.substring(1).toLowerCase()}',
                            style: TextStyle(
                              fontFamily: 'Myriad Pro',
                              fontSize: language == selectedLanguage
                                  ? Sizes.size40
                                  : Sizes.size32,
                              fontWeight: language == selectedLanguage
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            ref
                                .read(languageSelectProvider.notifier)
                                .setLanguage(language);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => HomeScreen(
                                  selectedLanguage: selectedLanguage,
                                ),
                              ),
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
