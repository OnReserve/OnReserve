import 'package:get/get.dart';
import 'package:on_reserve/Controllers/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
