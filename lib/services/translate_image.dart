import 'package:camera/camera.dart';

import 'package:dio/dio.dart';

import 'package:uuid/uuid.dart';

// providers

class TranslateImage {
  static const uuid = Uuid();

  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://118.67.130.163:5001',
    connectTimeout: const Duration(minutes: 30),
    receiveTimeout: const Duration(minutes: 30),
    sendTimeout: const Duration(minutes: 30),
    persistentConnection: true,
  ));

  static Future<dynamic> translateImage(XFile image, String language) async {
    final imageFileName = uuid.v4();
    FormData formData = FormData.fromMap({
      "imageName": "$imageFileName.jpg",
      "imageFile": await MultipartFile.fromFile(
        image.path,
      ),
    });

    print(imageFileName);

    try {
      print('language: $language');
      Response response = await dio.request(
        '/translate/$language',
        data: formData,
        options: Options(method: 'POST'),
        onReceiveProgress: (int sent, int total) {
          print('sent: $sent, total: $total');
        },
      );

      if (response.statusCode == 200) {
        print('menuName: ${response.data['menuName']}');
        print('menuPrice: ${response.data['price']}');

        return {
          'menu': response.data['menuName'],
          'price': response.data['price'],
        };
      } else {
        print("Error during file upload: ${response.statusCode}");
        return {};
      }
    } catch (e) {
      print("Error during file upload: $e");
      return {};
    }
  }
}
