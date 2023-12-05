import 'package:location/location.dart';

class LocationFetching {
  static Future<Map<String, double>?> getCurrentLocation() async {
    Map<String, double> currentLocation = {};

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

    currentLocation['latitude'] = locationData.latitude!;
    currentLocation['longitude'] = locationData.longitude!;

    return currentLocation;
  }
}
