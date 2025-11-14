import 'package:flutter/foundation.dart';

class SmsService {
  /// هنا فقط Simulation
  /// لاحقاً إذا حبيتي تربطي مع API حقيقية للـ SMS
  /// بنعدل هذا المكان ونستدعي الـ API بدل print
  static Future<void> sendTaxiSms(String phone, String message) async {
    debugPrint("====== SMS SIMULATION ======");
    debugPrint("To: $phone");
    debugPrint("Message: $message");
    debugPrint("============================");
  }
}
