import 'package:chalim/constants/sizes.dart';
import 'package:chalim/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorMessage extends ConsumerWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Language language = ref.watch(languageSelectProvider);
    late final String message;

    if (language.name == 'korean') {
      message = '차림 정보를 가져오지 못했습니다.';
    } else if (language.name == 'english') {
      message = 'Failed to load menu information.';
    } else if (language.name == 'japanese') {
      message = 'メニュー情報を取得できませんでした。';
    } else if (language.name == 'chinese') {
      message = '无法加载菜单信息。';
    }
    return Center(
      child: Text(
        message,
        style: GoogleFonts.notoSans(
          fontSize: Sizes.size32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
