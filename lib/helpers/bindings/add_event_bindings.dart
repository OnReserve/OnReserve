import 'package:get/get.dart';
import 'package:on_reserve/Controllers/add_event_controller.dart';

class AddEventBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEventController());
  }
}
