import 'package:hive_flutter/hive_flutter.dart';
import '../models/location_model.dart';

class LocationController {
  final Box locationBox = Hive.box('locations');

  Future<List<LocationPlace>> getLocationsByCategory(String category) async {
    List<LocationPlace> locations = [];

    for (int i = 0; i < locationBox.length; i++) {
      final raw = locationBox.getAt(i);
      if (raw == null) continue;

      final map = Map<String, dynamic>.from(raw);
      final place = LocationPlace.fromMap(map, i);

      if (place.category == category) {
        locations.add(place);
      }
    }

    return locations;
  }

  Future<void> addLocation(LocationPlace place) async {
    await locationBox.add(place.toMap());
  }
}
