import 'package:get/get.dart';
import 'package:on_reserve/Controllers/event_controller.dart';

class EventDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());
  }
}
