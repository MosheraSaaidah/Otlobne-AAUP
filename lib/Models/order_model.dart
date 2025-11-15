class OrderModel {
  final int index; // رقم العنصر داخل Hive
  final int taxiId;
  final String taxiName;
  final String location;
  final String studentName;
  final String status;

  OrderModel({
    required this.index,
    required this.taxiId,
    required this.taxiName,
    required this.location,
    required this.studentName,
    required this.status,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, int index) {
    return OrderModel(
      index: index,
      taxiId: map['taxiId'],
      taxiName: map['taxiName'],
      location: map['location'],
      studentName: map['studentName'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "taxiId": taxiId,
      "taxiName": taxiName,
      "location": location,
      "studentName": studentName,
      "status": status,
    };
  }
}
