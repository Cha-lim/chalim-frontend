import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chalim/models/restaurant.dart';

class RestaurantsFetching {
  static String baseUrl = dotenv.env['RESTAURANT_SERVICE_URL']!;

  static Future<List<Restaurant>> fetchRestaurants({
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
