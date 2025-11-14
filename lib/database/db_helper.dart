import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // Singleton
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initDatabase();

  // -------------------- إنشاء قاعدة البيانات --------------------
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), "otlobne.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // -------------------- إنشاء الجداول --------------------
  Future<void> _onCreate(Database db, int version) async {
   // ------- Seed Taxis -------
await db.insert("taxis", {
  "name": "Taxi Ahmed Qasem",
  "phone": "0599000000",
  "isActive": 1,
  "isAvailable": 1,
});

await db.insert("taxis", {
  "name": "Taxi Alaa",
  "phone": "0599111111",
  "isActive": 1,
  "isAvailable": 1,
});
await db.insert("taxis", {
  "name": "Taxi Abo Adam",
  "phone": "0599111111",
  "isActive": 1,
  "isAvailable": 1,
});
await db.insert("taxis", {
  "name": "Taxi Mohamed Zaid",
  "phone": "0599111111",
  "isActive": 1,
  "isAvailable": 1,
});
await db.insert("taxis", {
  "name": "Taxi Abood Salah",
  "phone": "0599111111",
  "isActive": 1,
  "isAvailable": 1,
});

// ------- Seed Locations -------
List<Map<String, dynamic>> seedLocations = [
  {"name": "بوابة 1", "category": "بوابة"},
  {"name": "بوابة 2", "category": "بوابة"},
  {"name": "بوابة 3", "category": "بوابة"},
{"name": "بوابة 4", "category": "بوابة"},
  {"name": "بوابة 5", "category": "بوابة"},


  {"name": "سكن الدلة", "category": "سكن"},
  {"name": "السكن الداخلي ", "category": "سكن"},
  {"name": "سكن ماريا للطالبات ", "category": "سكن"},
  {"name": "السكن A+ ", "category": "سكن"},
  {"name": "سكن الاميرات ", "category": "سكن"},
  {"name": "السكن يافا ", "category": "سكن"},




  {"name": "مطعم PHP", "category": "مطعم"},
  {"name": "مطعم SA", "category": "مطعم"},

  {"name": "Taksim Cafe", "category": "كافيه"},
  {"name": "Santorene Cafe", "category": "كافيه"},

  {"name": "سوبرماركت حمودة", "category": "سوبرماركت"},
  {"name": "سوبرماركت بدر", "category": "سوبرماركت"},
  {"name": "سوبرماركت Spring", "category": "سوبرماركت"},
 
];

for (var loc in seedLocations) {
  await db.insert("locations", loc);
}

  }

  // ============================================================
  // ==============  T A X I   Q U E R I E S  ===================
  // ============================================================

  Future<List<Map<String, dynamic>>> getAllTaxis() async {
    final db = await database;
    return await db.query("taxis", orderBy: "name ASC");
  }

  Future<List<Map<String, dynamic>>> getAvailableTaxis() async {
    final db = await database;
    return await db.query(
      "taxis",
      where: "isActive = ? AND isAvailable = ?",
      whereArgs: [1, 1],
    );
  }

  Future<int> insertTaxi(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("taxis", data);
  }

  Future<int> updateTaxi(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      "taxis",
      data,
      where: "id = ?",
      whereArgs: [data["id"]],
    );
  }

  Future<int> deleteTaxi(int id) async {
    final db = await database;
    return await db.delete("taxis", where: "id = ?", whereArgs: [id]);
  }

  Future<int> setTaxiAvailability(int id, int available) async {
    final db = await database;
    return await db.update(
      "taxis",
      {"isAvailable": available},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // ============================================================
  // ===========  L O C A T I O N S   Q U E R I E S  ============
  // ============================================================

  Future<List<Map<String, dynamic>>> getLocationsByCategory(
      String category) async {
    final db = await database;
    return await db.query(
      "locations",
      where: "category = ?",
      whereArgs: [category],
      orderBy: "name ASC",
    );
  }

  Future<int> insertLocation(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert("locations", data);
  }

  Future<int> updateLocation(Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      "locations",
      data,
      where: "id = ?",
      whereArgs: [data["id"]],
    );
  }

  Future<int> deleteLocation(int id) async {
    final db = await database;
    return await db.delete("locations", where: "id = ?", whereArgs: [id]);
  }

  // ============================================================
  // ================  O R D E R S   Q U E R I E S  =============
  // ============================================================

  // جلب الطلب النشط الوحيد
  Future<Map<String, dynamic>?> getActiveOrder() async {
    final db = await database;

    final result = await db.query(
      "orders",
      where: "status = ?",
      whereArgs: ["active"],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // إضافة طلب جديد
  Future<int> insertOrder(Map<String, dynamic> data) async {
    final db = await database;

    // دائما نخزن وقت إنشاء الطلب
    data["createdAt"] = DateTime.now().toIso8601String();

    return await db.insert("orders", data);
  }

  // إنهاء الطلب
  Future<int> finishOrder(int id) async {
    final db = await database;
    return await db.update(
      "orders",
      {"status": "completed"},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // طلبات مكتملة (للسجل فقط)
  Future<List<Map<String, dynamic>>> getCompletedOrders() async {
    final db = await database;
    return await db.query(
      "orders",
      where: "status = ?",
      whereArgs: ["completed"],
      orderBy: "createdAt DESC",
    );
  }
}
