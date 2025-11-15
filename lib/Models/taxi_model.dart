class Taxi {
  final int index; // رقم التاكسي في Hive
  final String name;
  final String phone;
  final bool isActive;
  final bool isAvailable;

  Taxi({
    required this.index,
    required this.name,
    required this.phone,
    required this.isActive,
    required this.isAvailable,
  });

  factory Taxi.fromMap(Map<String, dynamic> map, int index) {
    return Taxi(
      index: index,
      name: map['name'],
      phone: map['phone'],
      isActive: map['isActive'] == 1,
      isAvailable: map['isAvailable'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "isActive": isActive ? 1 : 0,
      "isAvailable": isAvailable ? 1 : 0,
    };
  }
}
