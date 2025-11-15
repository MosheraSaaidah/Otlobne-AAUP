class LocationPlace {
  final int index;
  final String name;
  final String category;

  LocationPlace({
    required this.index,
    required this.name,
    required this.category,
  });

  factory LocationPlace.fromMap(Map<String, dynamic> map, int index) {
    return LocationPlace(
      index: index,
      name: map['name'] ?? "",
      category: map['category'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "category": category,
    };
  }
}
