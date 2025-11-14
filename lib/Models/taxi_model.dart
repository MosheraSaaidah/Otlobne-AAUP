class Taxi {
  int id;
  String name;
  String phone;
  bool isActive;
  bool isAvailable;

  Taxi({
    required this.id,
    required this.name,
    required this.phone,
    required this.isActive,
    required this.isAvailable,
  });

  // لتحويل Map → Taxi
  factory Taxi.fromMap(Map<String, dynamic> map) {
    return Taxi(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      isActive: map['isActive'] == 1,
      isAvailable: map['isAvailable'] == 1,
    );
  }

  // لتحويل Taxi → Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "isActive": isActive ? 1 : 0,
      "isAvailable": isAvailable ? 1 : 0,
    };
  }
}
