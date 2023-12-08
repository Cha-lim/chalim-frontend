class Box {
  final List<List<int>> points;
  final String transcription;

  Box({required this.points, required this.transcription});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      points: List<List<int>>.from(
          json['points'].map((x) => List<int>.from(x.map((x) => x)))),
      transcription: json['transcription'],
    );
  }
}
