import '../database/db_helper.dart';
import '../models/location_model.dart';
import '../models/order_model.dart';

class OrderController {
  final db = DBHelper.instance;

  // إنشاء طلب جديد
  Future<void> createOrder(OrderModel order) async {
    await db.insertOrder({
      "taxiId": order.taxiId,
      "taxiName": order.taxiName,
      "location": order.location,
      "studentName": order.studentName,
      "status": "active",
    });
  }

  // جلب الطلب الحالي الوحيد
  Future<OrderModel?> getActiveOrder() async {
    final result = await db.getActiveOrder();

    if (result == null) return null;

    return OrderModel(
      id: result['id'],
      taxiId: result['taxiId'],
      taxiName: result['taxiName'],
      location: result['location'],
      studentName: result['studentName'],
      status: result['status'],
    );
  }

  // إنهاء الطلب (تغيير الحالة)
  Future<void> finishOrder(int id) async {
    await db.finishOrder(id);
  }

  // جلب كل الطلبات المكتملة
  Future<List<OrderModel>> getFinishedOrders() async {
    final data = await db.getCompletedOrders();

    return data.map((e) => OrderModel(
      id: e['id'],
      taxiId: e['taxiId'],
      taxiName: e['taxiName'],
      location: e['location'],
      studentName: e['studentName'],
      status: e['status'],
    )).toList();
  }
}
