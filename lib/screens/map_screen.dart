import 'package:chalim/models/restaurant.dart';
import 'package:chalim/screens/wordcloud_screen.dart';
import 'package:chalim/services/current_location.dart';
import 'package:chalim/services/restaurants_fetching.dart';
import 'package:chalim/widgets/loading_bar.dart';
import 'package:chalim/widgets/select_language_button.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(this.menuName, {super.key});

  final List<dynamic> menuName;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<List<Restaurant>> _restaurantsFuture;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = _fetchLocationAndRestaurants();
  }

  Future<List<Restaurant>> _fetchLocationAndRestaurants() async {
    final location = await LocationFetching.getCurrentLocation();

    if (location == null) {
      throw Exception('Unable to determine location');
    }
    return RestaurantsFetching.fetchRestaurants(
      lat: location['latitude']!,
      long: location['longitude']!,
    );
  }

  void _onRestaurantTapped(
    BuildContext context, {
    required String restaurantName,
    required List<dynamic> menuNames,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WordcloudScreen(
          restaurantName: restaurantName,
          menuNames: menuNames,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _restaurantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingBar(
                message: 'Data fetching in progress', isTextWhite: true);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No data',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          final restaurants = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.white),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _onRestaurantTapped(
                  context,
                  restaurantName: restaurants[index].name,
                  menuNames: widget.menuName,
                ),
                child: ListTile(
                  title: Text(
                    restaurants[index].name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${restaurants[index].distance}m',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
