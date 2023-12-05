import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Language {
  english,
  japanese,
  chinese,
}

class LanguageSelectProvider extends StateNotifier<Language> {
  LanguageSelectProvider() : super(Language.english);

  void setLanguage(Language language) {
    state = language;
  }

  String getLanguage() {
    // '${language.toString().split('.').last[0].toUpperCase()}${language.toString().split('.').last.substring(1).toLowerCase()}'
    return state.toString().split('.').last[0].toUpperCase() +
        state.toString().split('.').last.substring(1).toLowerCase();
  }
}

final languageSelectProvider =
    StateNotifierProvider<LanguageSelectProvider, Language>((ref) {
  return LanguageSelectProvider();
});

final languageProvider = Provider<List<Language>>((ref) {
  return [
    Language.english,
    Language.japanese,
    Language.chinese,
  ];
});
