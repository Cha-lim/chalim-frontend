class MenuDescription {
  final String description;
  final String history;
  final String ingredients;

  MenuDescription({
    required this.description,
    required this.history,
    required this.ingredients,
  });

  factory MenuDescription.fromJson(Map<String, dynamic> json) {
    return MenuDescription(
      description: sanitizeString(json['description']),
      history: sanitizeString(json['history']),
      ingredients: sanitizeString(json['ingredients']),
    );
  }

  static String sanitizeString(String input) {
    final pattern = RegExp('[\\/]');
    return input.replaceAll(pattern, '');
  }
}
