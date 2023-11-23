// flutter
import 'package:chalim/widgets/select_language_button.dart';
import 'package:flutter/material.dart';

// libraries
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camera/camera.dart';

// screens

// widgets

// constants
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/constants/gaps.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
        actions: const [
          FaIcon(
            FontAwesomeIcons.solidStar,
            size: Sizes.size28,
          ),
          Gaps.h10,
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          ),
          Gaps.h10,
        ],
        elevation: 5,
      ),
      body: const Center(
        child: Text('Camera Screen'),
      ),
    );
  }
}
