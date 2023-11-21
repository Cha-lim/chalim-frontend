// flutter
import 'package:flutter/material.dart';

// libraries
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// screens

// widgets

// constants
import 'package:chalim/constants/sizes.dart';

// models
import 'package:chalim/models/languages.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.selectedLanguage,
  });

  final Language selectedLanguage;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final List<Language> _languageList = [
    Language.english,
    Language.chinese,
    Language.japanese
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton(
          items: _languageList.map((Language language) {
            return DropdownMenuItem(
              value: language,
              child: Text(language.name),
            );
          }).toList(),
          onChanged: (value) {},
        ),
        actions: const [
          FaIcon(
            FontAwesomeIcons.solidStar,
            size: Sizes.size28,
          ),
          SizedBox(width: Sizes.size20),
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          )
        ],
        elevation: 5,
      ),
      body: const Center(
        child: Text('Camera Screen'),
      ),
    );
  }
}
