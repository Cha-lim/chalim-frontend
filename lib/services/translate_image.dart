import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:chalim/models/box.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

// providers
import 'package:chalim/providers/language_provider.dart';

class TranslateImage {
  static const uuid = Uuid();

  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://053c-180-69-240-120.ngrok.io',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    persistentConnection: true,
  ));

  static Future<dynamic> translateImage(XFile image, String language) async {
    FormData formData = FormData.fromMap({
      "imageName": "${uuid.v4()}.jpg",
      "imageFile": await MultipartFile.fromFile(
        image.path,
      )
    });

    try {
      Response response = await dio.request(
        '/translate/$language',
        data: formData,
        options: Options(method: 'POST'),
        onReceiveProgress: (int sent, int total) {
          print('sent: $sent, total: $total');
        },
      );
      /* return {
        "imageName": "20231208_213413.jpg",
        "menuName": [
          {
            "points": [
              [389, 297],
              [1552, 320],
              [1549, 463],
              [386, 440]
            ],
            "transcription": "Japanese style set menu for 1 person"
          },
          {
            "points": [
              [374, 584],
              [898, 584],
              [898, 735],
              [374, 735]
            ],
            "transcription": "Direct fire meat"
          },
          {
            "points": [
              [367, 911],
              [886, 921],
              [883, 1072],
              [364, 1062]
            ],
            "transcription": "Soy sauce meat"
          },
          {
            "points": [
              [354, 1247],
              [1139, 1261],
              [1136, 1408],
              [351, 1394]
            ],
            "transcription": "Gkotjeongsalgrilled"
          },
          {
            "points": [
              [359, 1591],
              [1320, 1614],
              [1316, 1761],
              [355, 1738]
            ],
            "transcription": "Grilled Chicken and Chicken"
          },
          {
            "points": [
              [354, 1940],
              [1294, 1958],
              [1291, 2092],
              [351, 2074]
            ],
            "transcription": "Grilled Chicken Maran"
          },
          {
            "points": [
              [349, 2267],
              [1294, 2281],
              [1291, 2424],
              [347, 2410]
            ],
            "transcription": "Salt-grilled chicken"
          },
          {
            "points": [
              [350, 2591],
              [1285, 2609],
              [1282, 2752],
              [347, 2733]
            ],
            "transcription": "Seasoned grilled chicken"
          },
          {
            "points": [
              [359, 2918],
              [1281, 2937],
              [1278, 3080],
              [356, 3061]
            ],
            "transcription": "Chicken teriyaki"
          },
          {
            "points": [
              [367, 3233],
              [869, 3243],
              [866, 3390],
              [364, 3380]
            ],
            "transcription": "Fire Squid"
          }
        ],
        "price": [
          {
            "points": [
              [2071, 611],
              [2579, 632],
              [2573, 783],
              [2064, 763]
            ],
            "priceValue": "9500"
          },
          {
            "points": [
              [2065, 939],
              [2579, 955],
              [2574, 1106],
              [2060, 1091]
            ],
            "priceValue": "9500"
          },
          {
            "points": [
              [1993, 1281],
              [2577, 1281],
              [2577, 1428],
              [1993, 1428]
            ],
            "priceValue": "11000"
          },
          {
            "points": [
              [1976, 1630],
              [2556, 1630],
              [2556, 1777],
              [1976, 1777]
            ],
            "priceValue": "11000"
          },
          {
            "points": [
              [1969, 1956],
              [2557, 1966],
              [2554, 2113],
              [1967, 2103]
            ],
            "priceValue": "10000"
          },
          {
            "points": [
              [2835, 1995],
              [3023, 1995],
              [3023, 2121],
              [2835, 2121]
            ],
            "priceValue": "12"
          },
          {
            "points": [
              [1963, 2289],
              [2543, 2289],
              [2543, 2436],
              [1963, 2436]
            ],
            "priceValue": "10000"
          },
          {
            "points": [
              [1963, 2612],
              [2526, 2612],
              [2526, 2759],
              [1963, 2759]
            ],
            "priceValue": "10000"
          },
          {
            "points": [
              [1949, 2941],
              [2502, 2931],
              [2505, 3078],
              [1952, 3088]
            ],
            "priceValue": "10000"
          },
          {
            "points": [
              [1928, 3264],
              [2490, 3254],
              [2492, 3385],
              [1930, 3394]
            ],
            "priceValue": "11000"
          },
          {
            "points": [
              [2852, 3335],
              [2994, 3335],
              [2994, 3406],
              [2852, 3406]
            ],
            "priceValue": "10"
          }
        ]
      }; */
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
