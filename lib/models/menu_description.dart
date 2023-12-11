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
      description: json['description'],
      history: json['history'],
      ingredients: json['ingredients'],
    );
  }
}
