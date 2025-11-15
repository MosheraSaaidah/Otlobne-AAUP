import 'package:hive_flutter/hive_flutter.dart';
import '../models/order_model.dart';

class OrderController {
  final Box orderBox = Hive.box('orders');

  Future<OrderModel?> getActiveOrder() async {
    for (int i = 0; i < orderBox.length; i++) {
      final map = Map<String, dynamic>.from(orderBox.getAt(i));
      final order = OrderModel.fromMap(map, i);
      if (order.status == "active") return order;
    }
    return null;
  }

  Future<void> createOrder(OrderModel order) async {
    await orderBox.add(order.toMap());
  }

  Future<void> finishOrder(OrderModel order) async {
    final map = order.toMap();
    map['status'] = "completed";
    await orderBox.putAt(order.index, map);
  }
}
