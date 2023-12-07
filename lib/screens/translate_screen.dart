// flutter
import 'package:flutter/material.dart';
import 'dart:io';

// libraries
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// screens
import 'package:chalim/screens/map_screen.dart';

// widgets
import 'package:chalim/widgets/select_language_button.dart';
import 'package:chalim/widgets/loading_bar.dart';

// constants
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/constants/gaps.dart';

// services
import 'package:chalim/services/translate_image.dart';

// providers
import 'package:chalim/providers/language_provider.dart';

class TranslateScreen extends ConsumerStatefulWidget {
  const TranslateScreen({
    super.key,
    required this.image,
  });

  final XFile image;

  @override
  ConsumerState<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends ConsumerState<TranslateScreen> {
  void _navigateToWordcloudScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToWordcloudScreen(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.solidStar,
              size: Sizes.size28,
            ),
          ),
          Gaps.h10,
          const FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          ),
          Gaps.h10,
        ],
        elevation: 5,
      ),
      body: FutureBuilder(
        future: TranslateImage.translateImage(
          widget.image,
          ref.read(languageSelectProvider),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBar(
              message: '이미지를 번역하는 중입니다.',
            );
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return const Text('오류가 발생했습니다.');
          }

          var boxes = snapshot.data!;
          return Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  File(widget.image.path),
                  fit: BoxFit.cover,
                ),
              ),
              ...boxes.map(
                (box) {
                  return Positioned(
                    left: box.points[0][0].toDouble(),
                    top: box.points[0][1].toDouble(),
                    child: Container(
                      width: (box.points[1][0] - box.points[0][0]).toDouble(),
                      height: (box.points[3][1] - box.points[0][1]).toDouble(),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                      ),
                      child: Text(
                        box.transcription,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
