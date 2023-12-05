import 'package:chalim/constants/gaps.dart';
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/services/current_location.dart';
import 'package:chalim/services/restaurants_fetching.dart';
import 'package:chalim/widgets/loading_bar.dart';
import 'package:chalim/widgets/select_language_button.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  void _onRestaurantTapped(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
        actions: const [
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          ),
          Gaps.h10,
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: LocationFetching.getCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBar(
              message: '현재 위치를 가져오는 중입니다.',
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                '현재 위치를 가져오지 못했습니다.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final location = snapshot.data;

          print('location: $location');

          if (location == null) {
            return const Center(
              child: Text(
                'Unable to determine location',
              ),
            );
          }

          return FutureBuilder(
            future: RestaurantsFetching.fetchRestaurants(
              keyword: '김밥',
              lat: location['latitude']!,
              long: location['longitude']!,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBar(
                  message: '주변 음식점을 가져오는 중입니다.',
                );
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(
                    child: Text(
                  '주변 음식점을 가져오지 못했어요.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ));
              }
              final restaurants = snapshot.data!;

              print('restaurants: $restaurants');

              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white,
                ),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onRestaurantTapped(context);
                    },
                    child: ListTile(
                      title: Text(
                        restaurants[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('${restaurants[index].distance}m',
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
