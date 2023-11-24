import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraInitializer {
  static Future<CameraController> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    final cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await cameraController.initialize();
    return cameraController;
  }

  static Future<void> disposeCamera(CameraController cameraController) async {
    await cameraController.dispose();
  }
}

final cameraProvider = FutureProvider<CameraController>((ref) async {
  return CameraInitializer.initializeCamera();
});
