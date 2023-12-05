class CurrentLocation {
  double latitude;
  double longitude;

  CurrentLocation({
    required this.latitude,
    required this.longitude,
  });

  factory CurrentLocation.fromJson(Map<String, dynamic> json) {
    return CurrentLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
