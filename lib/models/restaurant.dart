class Restaurant {
  final int distance;
  final String name;

  Restaurant({
    required this.distance,
    required this.name,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      distance: int.parse(json['distance']),
      name: json['place_name'],
    );
  }
}
