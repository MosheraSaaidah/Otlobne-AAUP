import 'package:final_project/view/student/student_home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_project/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  var taxiBox = await Hive.openBox('taxis');
  var locationBox = await Hive.openBox('locations');
  var orderBox = await Hive.openBox('orders');


  await _seedData(taxiBox, locationBox);

  runApp(const App());
}

// إضافة بيانات أولية إلى الـ Boxes في حالة كانت فارغة

Future<void> _seedData(Box taxiBox, Box locationBox) async {

  if (taxiBox.isNotEmpty || locationBox.isNotEmpty) {
    return;
  }

  // ------------------ Taxis -------------------
  List<Map<String, dynamic>> taxis = [
    {
      "name": "Taxi Ahmed Qasem",
      "phone": "0599000000",
      "isActive": 1,
      "isAvailable": 1,
    },
    {
      "name": "Taxi Alaa",
      "phone": "0599111111",
      "isActive": 1,
      "isAvailable": 1,
    },
    {
      "name": "Taxi Abo Adam",
      "phone": "0599111111",
      "isActive": 1,
      "isAvailable": 1,
    },
    {
      "name": "Taxi Mohamed Zaid",
      "phone": "0599111111",
      "isActive": 1,
      "isAvailable": 1,
    },
    {
      "name": "Taxi Abood Salah",
      "phone": "0599111111",
      "isActive": 1,
      "isAvailable": 1,
    },
  ];

  for (var t in taxis) {
    await taxiBox.add(t);
  }

  // ------------------ Locations -------------------//

  List<Map<String, dynamic>> locations = [
    // بوابات
    {"name": "بوابة 1", "category": "بوابة"},
    {"name": "بوابة 2", "category": "بوابة"},
    {"name": "بوابة 3", "category": "بوابة"},
    {"name": "بوابة 4", "category": "بوابة"},
    {"name": "بوابة 5", "category": "بوابة"},

    // سكن
    {"name": "سكن الدلة", "category": "سكن"},
    {"name": "السكن الداخلي", "category": "سكن"},
    {"name": "سكن ماريا للطالبات", "category": "سكن"},
    {"name": "السكن A+", "category": "سكن"},
    {"name": "سكن الاميرات", "category": "سكن"},
    {"name": "السكن يافا", "category": "سكن"},

    // مطاعم
    {"name": "مطعم PHP", "category": "مطعم"},
    {"name": "مطعم SA", "category": "مطعم"},

    // كافيهات
    {"name": "Taksim Cafe", "category": "كافيه"},
    {"name": "Santorene Cafe", "category": "كافيه"},

    // سوبرماركت
    {"name": "سوبرماركت حمودة", "category": "سوبرماركت"},
    {"name": "سوبرماركت بدر", "category": "سوبرماركت"},
    {"name": "سوبرماركت Spring", "category": "سوبرماركت"},
  ];

  for (var loc in locations) {
    await locationBox.add(loc);
  }
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otlobne AAUP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
        ).copyWith(secondary: Colors.black),
        useMaterial3: true,
      ),
      home: StudentHomePage(),
    );
  }
}
