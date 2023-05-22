import 'package:get/get.dart';
import 'package:on_reserve/Controllers/qr_controller.dart';

class QrBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(QRController());
  }
}
