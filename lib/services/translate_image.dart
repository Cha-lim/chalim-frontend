import 'package:camera/camera.dart';
import 'package:chalim/models/box.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

// providers
import 'package:chalim/providers/language_provider.dart';

class TranslateImage {
  static const uuid = Uuid();
  static const String baseUrl =
      'https://89e5-2001-2d8-f089-b90f-1979-10f3-1092-1c89.ngrok.io';

  static Future<List<Box>> translateImage(
      XFile image, Language language) async {
    final dio = Dio();

    FormData formData = FormData.fromMap({
      "imageName": "${uuid.v4()}.jpg",
      "imageFile": await MultipartFile.fromFile(
        image.path,
      )
    });

    late String lang;
    if (language == Language.english) {
      lang = 'eng';
    } else if (language == Language.japanese) {
      lang = 'jpn';
    } else if (language == Language.chinese) {
      lang = 'chn';
    }

    final uploadUrl = '$baseUrl/translate/$lang';

    try {
      Response response = await dio.post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        print("File upload response: ${response.data}");
        List<Box> boxes = List<Box>.from(
            response.data['translatedTxt'].map((x) => Box.fromJson(x)));
        return boxes;
      } else {
        print("Error during file upload: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error during file upload: $e");
    }
    return [];
  }
}
