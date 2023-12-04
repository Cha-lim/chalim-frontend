// flutter
import 'package:flutter/material.dart';
import 'dart:convert';

// libraries
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// screens
import 'package:chalim/screens/map_screen.dart';
import 'package:chalim/screens/translate_screen.dart';

// widgets
import 'package:chalim/widgets/camera_shot_button.dart';
import 'package:chalim/widgets/photo_icon.dart';
import 'package:chalim/widgets/select_language_button.dart';

// constants
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/constants/gaps.dart';

// providers

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  void _onCameraButtonPressed() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await _controller.takePicture();

      if (!mounted) return;

      var url =
          Uri.parse('https://1100-114-206-33-35.ngrok.io/restaurant-name');

      // If the picture was taken, display it on a new screen.
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TranslateScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            image: image,
          ),
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = Future.value();
    _startCamera();
  }

  void _startCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    setState(() {
      // Next, initialize the controller. This returns a Future.
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  void _navigateToWordcloudScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
  }

  //이미지를 가져오는 함수
  Future _getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TranslateScreen(
          // Pass the automatically generated path to
          // the DisplayPictureScreen widget.
          image: _image!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return CameraPreview(_controller);
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: width / 2 - 35,
            child: GestureDetector(
              onTap: _onCameraButtonPressed,
              child: const CameraShotButton(),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 40,
            child: GestureDetector(
              onTap: () {
                _getImage(ImageSource.gallery);
              },
              child: const PhotoIcon(),
            ),
          )
        ],
      ),
    );
  }
}
