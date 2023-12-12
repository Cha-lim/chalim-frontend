import 'package:chalim/constants/gaps.dart';
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/models/menu_description.dart';
import 'package:chalim/providers/language_provider.dart';
import 'package:chalim/services/service_menu_description.dart';
import 'package:chalim/widgets/error_message.dart';
import 'package:chalim/widgets/loading_bar.dart';
import 'package:chalim/widgets/select_language_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

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
  late Future<MenuDescription> _menuDescriptionFuture;

  @override
  void initState() {
    super.initState();
    _menuDescriptionFuture = ServiceMenuDescription.getMenuDescription(
      widget.menuNameForeign,
      ref.read(languageSelectProvider).name.toLowerCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        future: _menuDescriptionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBar(
              message: 'Fetching menu description...',
              isTextWhite: true,
            );
          }
          if (snapshot.hasError) {
            return const ErrorMessage();
          }
          if (!snapshot.hasData) {
            return const ErrorMessage();
          }

          if (snapshot.hasData) {
            final MenuDescription menuDescription = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size40,
                  vertical: Sizes.size56,
                ),
                child: DefaultTextStyle(
                  style: GoogleFonts.notoSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.menuNameKorean,
                        style: GoogleFonts.notoSans(
                          textStyle: Theme.of(context).textTheme.displaySmall,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Gaps.v60,
                      Text(
                        widget.menuNameForeign,
                        style: GoogleFonts.notoSans(
                          textStyle: Theme.of(context).textTheme.headlineSmall,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Gaps.v20,
                      Text(
                        menuDescription.description,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Gaps.v60,
                      const Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v20,
                      Text(
                        menuDescription.history,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Gaps.v60,
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v20,
                      Text(
                        menuDescription.ingredients,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const ErrorMessage();
        },
      ),
    );
  }
}
