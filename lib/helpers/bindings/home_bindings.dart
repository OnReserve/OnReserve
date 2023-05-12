import 'package:get/get.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
  }
}
