import 'package:flutter/material.dart';

import '../../controllers/taxi_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/order_controller.dart';

import '../../models/taxi_model.dart';
import '../../models/location_model.dart';
import '../../models/order_model.dart';
import '../../utils/sms_service.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final TaxiController taxiController = TaxiController();
  final LocationController locationController = LocationController();
  final OrderController orderController = OrderController();

  List<Taxi> availableTaxis = [];
  List<String> categories = ["بوابة", "سكن", "مطعم", "كافيه", "سوبرماركت"];
  List<LocationPlace> filteredLocations = [];

  Taxi? selectedTaxi;
  int? selectedTaxiIndex;

  String? selectedCategory;
  LocationPlace? selectedLocation;

  OrderModel? activeOrder;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => isLoading = true);

    availableTaxis = await taxiController.getAvailableTaxis();
    activeOrder = await orderController.getActiveOrder();

    setState(() => isLoading = false);
  }

  Future<void> _loadLocationsByCategory(String category) async {
    //print("🔍 Loading locations for category: $category");

    filteredLocations = await locationController.getLocationsByCategory(
      category,
    );

    //print("🔍 Loaded ${filteredLocations.length} locations");

    for (var loc in filteredLocations) {
      print("📍 ${loc.name} - ${loc.category}");
    }

    setState(() {});
  }

  Future<void> _createOrder() async {
    if (selectedTaxi == null || selectedLocation == null) return;

    final newOrder = OrderModel(
      index: 0, // سيتم تعيينه تلقائيًا بواسطة Hive
      taxiId: selectedTaxiIndex!,
      taxiName: selectedTaxi!.name,
      location: selectedLocation!.name,
      studentName: "Student",
      status: "active",
    );

    await orderController.createOrder(newOrder);

    //  جعل التاكسي غير متاح
    await taxiController.setTaxiAvailability(selectedTaxiIndex!, false);

    // إرسال SMS (وهمي)
    SmsService.sendTaxiSms(
      selectedTaxi!.phone,
      "تم طلبك من الطالب. الموقع: ${selectedLocation!.name}. الرجاء عمل رنّة عند انتهاء الطلب.",
    );

    activeOrder = newOrder;

    setState(() {});
  }

  Future<void> _finishOrder() async {
    if (activeOrder == null) return;

    setState(() {
      isLoading = true;
    });

    // 1) إنهاء الطلب في قاعدة البيانات
    await orderController.finishOrder(activeOrder!);

    // 2) إعادة التاكسي لحالة "متاح"
    await taxiController.setTaxiAvailability(activeOrder!.taxiId, true);

    // 3) مسح الطلب من الواجهة
    activeOrder = null;

    // 4) إعادة تحميل البيانات من Hive
    await _loadInitialData();

    // 5) Reset كل الخيارات حتى تختفي DropDown الثالثة
    selectedTaxi = null;
    selectedTaxiIndex = null;
    selectedCategory = null;
    selectedLocation = null;
    filteredLocations = [];

    setState(() {
      isLoading = false;
    });

    // 6) رسالة نجاح
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("✔️ تم إنهاء الطلب")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Otlobne AAUP"),
        backgroundColor: Colors.amber,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (activeOrder != null) _activeOrderCard(),

          if (activeOrder == null) ...[
            _buildTaxiDropdown(),
            const SizedBox(height: 20),
            _buildCategoryDropdown(),
            const SizedBox(height: 20),
            if (selectedCategory != null) _buildLocationDropdown(),
            const SizedBox(height: 30),
            _buildRequestButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildTaxiDropdown() {
    return DropdownButtonFormField<Taxi>(
      decoration: _inputDecoration("اختر التاكسي"),
      items:
          availableTaxis.map((t) {
            int index = availableTaxis.indexOf(t);
            return DropdownMenuItem(
              value: t,
              child: Text(t.name),
              onTap: () {
                selectedTaxiIndex = index;
              },
            );
          }).toList(),
      onChanged: (v) {
        setState(() => selectedTaxi = v);
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration("اختر نوع المكان"),
      items:
          categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
      onChanged: (v) async {
        selectedCategory = v;
        selectedLocation = null;
        await _loadLocationsByCategory(v!);
      },
    );
  }

  Widget _buildLocationDropdown() {
    return DropdownButtonFormField<LocationPlace>(
      decoration: _inputDecoration("اختر المكان"),
      items:
          filteredLocations
              .map((l) => DropdownMenuItem(value: l, child: Text(l.name)))
              .toList(),
      onChanged: (v) => setState(() => selectedLocation = v),
    );
  }

  Widget _buildRequestButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: _createOrder,
      child: const Text("اطلب الآن", style: TextStyle(color: Colors.black)),
    );
  }

  Widget _activeOrderCard() {
    return Card(
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "الطلب الحالي",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("التاكسي: ${activeOrder!.taxiName}"),
            Text("المكان: ${activeOrder!.location}"),
            const Text("الحالة: Active"),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _finishOrder,
              child: const Text("✔️ إنهاء الطلب"),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      fillColor: Colors.amber.shade100,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
