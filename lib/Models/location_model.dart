class LocationPlace {
  int id;
  String name;
  String category;

  LocationPlace({
    required this.id,
    required this.name,
    required this.category,
  });

  factory LocationPlace.fromMap(Map<String, dynamic> map) {
    return LocationPlace(
      id: map['id'],
      name: map['name'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "category": category,
    };
  }
}
