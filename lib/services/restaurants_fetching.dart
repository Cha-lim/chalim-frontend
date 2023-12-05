import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chalim/models/restaurant.dart';

class RestaurantsFetching {
  static const String baseUrl = 'https://0347-223-62-188-75.ngrok-free.app';

  static Future<List<Restaurant>> fetchRestaurants({
    required String keyword,
    required double lat,
    required double long,
  }) async {
    List<Restaurant> restaurants = [];
    var url = Uri.parse('$baseUrl/restaurant-name');

    var response = await http.post(
      url,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'keyword': keyword,
        'y': lat,
        'x': long,
      }),
    );

    print('lat: $lat, long: $long');

    if (response.statusCode == 200) {
      final restaurantsJson =
          json.decode(utf8.decode(response.bodyBytes))['documents'];

      for (var restaurantJson in restaurantsJson) {
        restaurants.add(Restaurant.fromJson(restaurantJson));
      }

      return restaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
