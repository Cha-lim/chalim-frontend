class Location {
  Location({
    required this.latitude,
    required this.longitude,
    required this.keyword,
  });

  final double latitude;
  final double longitude;
  final String keyword;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        keyword: json["keyword"],
      );

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "y": latitude,
        "x": longitude,
      };
}
