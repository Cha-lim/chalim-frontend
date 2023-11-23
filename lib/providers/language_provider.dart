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
