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

class MenuDescriptionScreen extends ConsumerStatefulWidget {
  const MenuDescriptionScreen({
    super.key,
    required this.menuNameKorean,
    required this.menuNameForeign,
  });

  final String menuNameKorean;
  final String menuNameForeign;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MenuDescriptionScreenState();
}

class _MenuDescriptionScreenState extends ConsumerState<MenuDescriptionScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
          widget.menuNameKorean,
          language.name.toLowerCase(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBar(
              message: '메뉴 설명을 가져오는 중입니다.',
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                '메뉴 설명을 가져오지 못했습니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size20,
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                '차림 설명을 가져오지 못했습니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size20,
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            final MenuDescription menuDescription = snapshot.data!;
            return Scrollbar(
              controller: _scrollController,
              interactive: true,
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.menuNameForeign,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.menuNameKorean,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v32,
                    Text(
                      menuDescription.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v32,
                    Text(
                      menuDescription.history,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v32,
                    Text(
                      menuDescription.ingredients,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: Text(
              '메뉴 설명을 가져오지 못했습니다.',
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.size20,
              ),
            ),
          );
        },
      ),
    );
  }
}
