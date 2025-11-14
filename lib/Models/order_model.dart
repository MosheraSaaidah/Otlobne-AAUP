class OrderModel {
  int id;
  int taxiId;
  String taxiName;
  String location;
  String studentName;
  String status; // active or completed
  String? createdAt;

  OrderModel({
    required this.id,
    required this.taxiId,
    required this.taxiName,
    required this.location,
    required this.studentName,
    required this.status,
    this.createdAt,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      taxiId: map['taxiId'],
      taxiName: map['taxiName'],
      location: map['location'],
      studentName: map['studentName'],
      status: map['status'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "taxiId": taxiId,
      "taxiName": taxiName,
      "location": location,
      "studentName": studentName,
      "status": status,
      "createdAt": createdAt,
    };
  }
}
