import 'package:get/get.dart';
import 'package:on_reserve/Controllers/settings_controller.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
