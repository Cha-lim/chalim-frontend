// flutter
import 'package:flutter/material.dart';

// libraries
import 'package:flutter_riverpod/flutter_riverpod.dart';

// constants
import 'package:chalim/constants/sizes.dart';

// providers
import 'package:chalim/providers/language_provider.dart';

class SelectLanguageButton extends ConsumerWidget {
  const SelectLanguageButton({super.key});

  void _onChangeLanguage(Language? newLanguage, WidgetRef ref) {
    if (newLanguage != null) {
      ref.read(languageSelectProvider.notifier).setLanguage(newLanguage);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: Sizes.size36,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size12,
        vertical: Sizes.size4,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Sizes.size24),
        border: Border.all(
          color: Colors.white,
          width: Sizes.size1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          dropdownColor: Theme.of(context).primaryColor,
          items: ref
              .read(languageProvider)
              .map(
                (language) => DropdownMenuItem(
                  value: language,
                  child: Text(
                    '${language.toString().split('.').last[0].toUpperCase()}${language.toString().split('.').last.substring(1).toLowerCase()}',
                    style: const TextStyle(
                      fontFamily: 'Myriad Pro',
                      color: Colors.white,
                      fontSize: Sizes.size16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
          alignment: Alignment.center,
          value: ref.watch(languageSelectProvider),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.white),
          iconSize: Sizes.size24,
          style: const TextStyle(color: Colors.white),
          onChanged: (newLanguage) {
            _onChangeLanguage(newLanguage, ref);
          },
        ),
      ),
    );
  }
}
