
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
  // ----------- Controllers ------------
  final TaxiController taxiController = TaxiController();
  final LocationController locationController = LocationController();
  final OrderController orderController = OrderController();

  // ----------- UI State ------------
  List<Taxi> availableTaxis = [];
  List<String> categories = ["بوابة", "سكن", "مطعم", "كافيه", "سوبرماركت"];
  List<LocationPlace> filteredLocations = [];

  Taxi? selectedTaxi;
  String? selectedCategory;
  LocationPlace? selectedLocation;

  OrderModel? activeOrder;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  // تحميل البيانات من الـ Database
  Future<void> _loadInitialData() async {
    setState(() => isLoading = true);

    availableTaxis = await taxiController.getAvailableTaxis();
    activeOrder = await orderController.getActiveOrder();

    setState(() {
      isLoading = false;
    });
  }

  // تحميل الأماكن حسب النوع
  Future<void> _loadLocationsByCategory(String category) async {
    filteredLocations =
        await locationController.getLocationsByCategory(category);
    setState(() {});
  }

  // إنشاء الطلب
  Future<void> _createOrder() async {
    if (selectedTaxi == null || selectedLocation == null) return;

    final newOrder = OrderModel(
      id: 0,
      taxiId: selectedTaxi!.id,
      taxiName: selectedTaxi!.name,
      location: selectedLocation!.name,
      studentName: "Student Name", // لاحقًا نجيب اسم الطالب
      status: "active",
    );

    await orderController.createOrder(newOrder);
    await taxiController.setTaxiAvailability(selectedTaxi!.id, false);

    SmsService.sendTaxiSms(
      selectedTaxi!.phone,
      "تم طلبك من الطالب. الموقع: ${selectedLocation!.name}. الرجاء عمل رنّة عند إنهاء الطلب.",
    );

    activeOrder = newOrder;

    setState(() {});
  }

  // إنهاء الطلب
  Future<void> _finishOrder() async {
    if (activeOrder == null) return;

    await orderController.finishOrder(activeOrder!.id);
    await taxiController.setTaxiAvailability(activeOrder!.taxiId, true);

    activeOrder = null;

    await _loadInitialData();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("✔️ تم إنهاء الطلب")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otlobne AAUP"),
        backgroundColor: Colors.amber,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ----------- عرض الطلب الحالي ------------
          if (activeOrder != null) _activeOrderCard(),

          if (activeOrder == null) ...[
            _buildTaxiDropdown(),
            SizedBox(height: 20),
            _buildCategoryDropdown(),
            SizedBox(height: 20),
            if (selectedCategory != null) _buildLocationDropdown(),
            SizedBox(height: 30),
            _buildRequestButton(),
          ]
        ],
      ),
    );
  }

  // -------- Widgets --------

  Widget _buildTaxiDropdown() {
    return DropdownButtonFormField<Taxi>(
      decoration: _inputDecoration("اختر التاكسي"),
      items: availableTaxis
          .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
          .toList(),
      onChanged: (v) => setState(() => selectedTaxi = v),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration("اختر نوع المكان"),
      items: categories
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
      items: filteredLocations
          .map((l) => DropdownMenuItem(value: l, child: Text(l.name)))
          .toList(),
      onChanged: (v) => setState(() => selectedLocation = v),
    );
  }

  Widget _buildRequestButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: _createOrder,
      child: Text("اطلب الآن", style: TextStyle(color: Colors.black)),
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
            Text("الطلب الحالي",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            Text("التاكسي: ${activeOrder!.taxiName}"),
            Text("المكان: ${activeOrder!.location}"),
            Text("الحالة: Active"),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: _finishOrder,
              child: Text("✔️ إنهاء الطلب"),
            )
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




