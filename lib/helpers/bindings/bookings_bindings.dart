import 'package:get/get.dart';
import 'package:on_reserve/Controllers/ticket_controller.dart';

class BookingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TicketController());
  }
}
