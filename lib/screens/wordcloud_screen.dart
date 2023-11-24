// flutter
import 'package:chalim/widgets/camera_shot_button.dart';
import 'package:chalim/widgets/photo_icon.dart';
import 'package:chalim/widgets/select_language_button.dart';
import 'package:chalim/widgets/wordcloud_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// libraries
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camera/camera.dart';

// screens

// widgets

// constants
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/constants/gaps.dart';

// providers
import 'package:chalim/providers/camera_provider.dart';

class WordcloudScreen extends ConsumerStatefulWidget {
  const WordcloudScreen({super.key});

  @override
  ConsumerState<WordcloudScreen> createState() => _WordcloudScreenState();
}

class _WordcloudScreenState extends ConsumerState<WordcloudScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
        actions: const [
          WordcloudButton(),
          Gaps.h10,
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          ),
          Gaps.h10,
        ],
        elevation: 5,
      ),
      body: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 50,
            bottom: 30,
            child: const CameraShotButton(),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width / 5 - 30,
              bottom: 50,
              child: const PhotoIcon()),
        ],
      ),
    );
  }
}
