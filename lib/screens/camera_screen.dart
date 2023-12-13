// flutter
import 'package:flutter/material.dart';

// libraries
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:camera/camera.dart';

import 'package:image_picker/image_picker.dart';

// screens

import 'package:chalim/screens/translate_screen.dart';

// widgets
import 'package:chalim/widgets/camera_shot_button.dart';
import 'package:chalim/widgets/photo_icon.dart';
import 'package:chalim/widgets/select_language_button.dart';

// constants

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      const snackBar = SnackBar(
        content: Center(child: Text('Take a vertical picture of the menu.')),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
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

  //이미지를 가져오는 함수
  void _getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
    // 이미지를 선택하지 않으면 null이 된다.
    if (_image == null) {
      return;
    }

    if (!mounted) return; // 이미지를 선택하지 않으면 null이 된다.
    Navigator.of(context).push(
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
