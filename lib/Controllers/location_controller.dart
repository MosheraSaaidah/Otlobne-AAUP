import '../database/db_helper.dart';
import '../models/order_model.dart';
import '../models/location_model.dart';



class LocationController {
  final db = DBHelper.instance;

  // جلب كل الأماكن حسب النوع
  Future<List<LocationPlace>> getLocationsByCategory(String category) async {
    final data = await db.getLocationsByCategory(category);

    return data.map((e) => LocationPlace(
      id: e['id'],
      name: e['name'],
      category: e['category'],
    )).toList();
  }

  // إضافة مكان جديد
  Future<void> addLocation(LocationPlace place) async {
    await db.insertLocation({
      "name": place.name,
      "category": place.category,
    });
  }

  // تحديث مكان
  Future<void> updateLocation(LocationPlace place) async {
    await db.updateLocation({
      "id": place.id,
      "name": place.name,
      "category": place.category,
    });
  }

  // حذف مكان
  Future<void> deleteLocation(int id) async {
    await db.deleteLocation(id);
  }
}
