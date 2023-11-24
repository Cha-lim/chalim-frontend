// flutter
import 'package:chalim/widgets/camera_shot_button.dart';
import 'package:chalim/widgets/photo_icon.dart';
import 'package:chalim/widgets/select_language_button.dart';
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

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(cameraProvider);
  }

  @override
  void dispose() {
    ref.read(cameraProvider).whenData((cameraController) async {
      await CameraInitializer.disposeCamera(cameraController);
    });

    super.dispose();
  }

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
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ref.watch(cameraProvider).when(
              data: (cameraController) {
                return CameraPreview(cameraController);
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (error, stackTrace) {
                return const Center(
                  child: Text('Error'),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Positioned(
              left: MediaQuery.of(context).size.width / 2 - 50,
              bottom: 30,
              child: const CameraShotButton(),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Positioned(
                left: MediaQuery.of(context).size.width / 5 - 30,
                bottom: 50,
                child: const PhotoIcon()),
          ),
        ],
      ),
    );
  }
}
