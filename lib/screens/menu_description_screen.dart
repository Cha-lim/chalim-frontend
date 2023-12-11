import 'package:chalim/constants/gaps.dart';
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/models/menu_description.dart';
import 'package:chalim/providers/language_provider.dart';
import 'package:chalim/services/service_menu_description.dart';
import 'package:chalim/widgets/loading_bar.dart';
import 'package:chalim/widgets/select_language_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuDescriptionScreen extends ConsumerWidget {
  const MenuDescriptionScreen({
    super.key,
    required this.menuNameKorean,
    required this.menuNameForeign,
  });

  final String menuNameKorean;
  final String menuNameForeign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Language language = ref.read(languageSelectProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
        actions: const [
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          ),
          Gaps.h10,
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: ServiceMenuDescription.getMenuDescription(
          menuNameKorean,
          language.name.toLowerCase(),
        ),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const LoadingBar(
                  message: '차림 메뉴 설명을 불러오는 중입니다.',
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: Sizes.size20,
                          left: Sizes.size20,
                          right: Sizes.size20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menuNameKorean,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              menuNameForeign,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.v10,
                            Text(
                              (snapshot.data as MenuDescription).description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.v10,
                            Text(
                              (snapshot.data as MenuDescription).history,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                            Gaps.v10,
                            Text(
                              (snapshot.data as MenuDescription).ingredients,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
