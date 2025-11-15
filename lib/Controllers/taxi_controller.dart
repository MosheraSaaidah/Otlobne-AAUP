import 'package:hive_flutter/hive_flutter.dart';
import '../models/taxi_model.dart';

class TaxiController {
  final Box taxiBox = Hive.box('taxis');

  Future<List<Taxi>> getAvailableTaxis() async {
    return List.generate(taxiBox.length, (i) {
      final map = Map<String, dynamic>.from(taxiBox.getAt(i));
      return Taxi.fromMap(map, i);
    }).where((t) => t.isActive && t.isAvailable).toList();
  }

  Future<void> addTaxi(Taxi taxi) async {
    await taxiBox.add(taxi.toMap());
  }

  Future<void> setTaxiAvailability(int index, bool available) async {
    final map = Map<String, dynamic>.from(taxiBox.getAt(index)!);
    map['isAvailable'] = available ? 1 : 0;
    await taxiBox.putAt(index, map);
  }
}
