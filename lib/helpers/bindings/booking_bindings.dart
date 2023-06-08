import 'package:get/get.dart';
import 'package:on_reserve/Controllers/booking_controller.dart';

class BookingBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingController());
  }
}
