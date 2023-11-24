import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// screens
import 'package:chalim/screens/wordcloud_screen.dart';

import 'package:chalim/constants/sizes.dart';

class WordcloudButton extends StatelessWidget {
  const WordcloudButton({
    super.key,
  });

  void _navigateToWordcloudScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WordcloudScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _navigateToWordcloudScreen(context);
      },
      icon: const FaIcon(
        FontAwesomeIcons.solidStar,
        size: Sizes.size28,
      ),
    );
  }
}
