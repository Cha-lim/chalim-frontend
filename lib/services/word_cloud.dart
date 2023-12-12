import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class WordCloud {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://390b-114-206-33-35.ngrok-free.app',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  static Future<dynamic> getWordCloud({
    required String restaurantName,
    required List<dynamic> menuNames,
  }) async {
    print('restaurantName: $restaurantName');
    print('menuNames: ${menuNames.join(" ")}');

    try {
      print('query: $restaurantName ${menuNames.join(' ')}');
      Response response = await dio.request(
        '/review',
        queryParameters: {
          'query': '$restaurantName ${menuNames.join(' ')}',
        },
        options: Options(
          method: 'GET',
          responseType: ResponseType.bytes,
        ),
      );

      print(response.realUri);
      if (response.statusCode == 200) {
        // If the response is a byte stream, like an image file.
        print(response.data);
        List<int> bytes = response.data;
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        File file = File('$tempPath/wordcloud_$timestamp.png');

        await file.writeAsBytes(bytes);
        return file;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
    return "";
  }
}
