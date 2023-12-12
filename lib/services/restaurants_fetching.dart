import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:chalim/models/restaurant.dart';

class RestaurantsFetching {
  static Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.get('RESTAURANT_SERVICE_URL'),
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(minutes: 2),
    persistentConnection: true,
  ));

  static Future<List<Restaurant>> fetchRestaurants({
    required double lat,
    required double long,
  }) async {
    List<Restaurant> restaurants = [];

    try {
      Response response = await dio.request(
        '/restaurant-name',
        data: {
          "keyword": "식당",
          'y': lat,
          'x': long,
        },
        options: Options(method: 'POST'),
      );

      print('real Uri: ${response.realUri}');

      if (response.statusCode == 200) {
        final restaurantsList = response.data['documents'];

        print(restaurantsList);

        for (var restaurant in restaurantsList) {
          restaurants.add(Restaurant.fromJson(restaurant));
        }
        return restaurants;
      } else {
        print("Error during file upload: ${response.statusCode}");
        return restaurants;
      }
    } catch (e) {
      print("Error during file upload: $e");
      return restaurants;
    }
  }
}
