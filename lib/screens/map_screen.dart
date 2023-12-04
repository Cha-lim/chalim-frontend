import 'package:chalim/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final bool _isCurrentLocationLoading = true;
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    // print('initial!');
    // _getCurrentLocation().then((locationData) {
    //   setState(() {
    //     _currentLocation = locationData;
    //     _isCurrentLocationLoading = false;
    //     print('current location: $_currentLocation');
    //   });

    //   _fetchRestaurants(locationData!.latitude, locationData.longitude);
    // });

    _fetchRestaurants(37.6040015, 127.0657662);
  }

  Future<void> _fetchRestaurants(double latitude, double longitude) async {
    var url = Uri.parse('https://1100-114-206-33-35.ngrok.io/restaurant-name');

    var response = await http.post(
      url,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'keyword': '김밥',
        'y': latitude,
        'x': longitude,
      }),
    );

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var restaurants = jsonDecode(responseBody);
      print('restaurants: $restaurants');
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Request failed with body: ${response.body}');
      // 사용자에게 오류 메시지를 표시하는 로직을 추가할 수 있습니다.
    }
  }

  Future<LocationData?> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    // 서비스가 가능한지 확인하는 코드
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('Service is not enabled');
        return null;
      }
    }

    // 사용자의 허락이 떨어졌는지 확인하는 코드
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('Permission is not granted');
        return null;
      }
    }

    locationData = await location.getLocation();

    return locationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isCurrentLocationLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )
            : const Text(
                'Map',
                style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
      ),
    );
  }
}
