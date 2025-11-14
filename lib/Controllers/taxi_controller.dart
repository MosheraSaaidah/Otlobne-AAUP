import '../database/db_helper.dart';
import '../models/taxi_model.dart';


class TaxiController {
  final db = DBHelper.instance;

  // جلب كل التكاسي
  Future<List<Taxi>> getAllTaxis() async {
    final data = await db.getAllTaxis();
    return data.map((e) => Taxi(
      id: e['id'],
      name: e['name'],
      phone: e['phone'],
      isActive: e['isActive'] == 1,
      isAvailable: e['isAvailable'] == 1,
    )).toList();
  }

  // جلب التكاسي المتاحة فقط
  Future<List<Taxi>> getAvailableTaxis() async {
    final data = await db.getAvailableTaxis();
    return data.map((e) => Taxi(
      id: e['id'],
      name: e['name'],
      phone: e['phone'],
      isActive: e['isActive'] == 1,
      isAvailable: e['isAvailable'] == 1,
    )).toList();
  }

  // إضافة تكسي جديد
  Future<void> addTaxi(Taxi taxi) async {
    await db.insertTaxi({
      "name": taxi.name,
      "phone": taxi.phone,
      "isActive": taxi.isActive ? 1 : 0,
      "isAvailable": taxi.isAvailable ? 1 : 0,
    });
  }

  // تحديث تكسي
  Future<void> updateTaxi(Taxi taxi) async {
    await db.updateTaxi({
      "id": taxi.id,
      "name": taxi.name,
      "phone": taxi.phone,
      "isActive": taxi.isActive ? 1 : 0,
      "isAvailable": taxi.isAvailable ? 1 : 0,
    });
  }

  // حذف تكسي
  Future<void> deleteTaxi(int id) async {
    await db.deleteTaxi(id);
  }

  // تعديل حالة التكسي (متاح/غير متاح)
  Future<void> setTaxiAvailability(int taxiId, bool available) async {
    await db.setTaxiAvailability(taxiId, available ? 1 : 0);
  }
}
