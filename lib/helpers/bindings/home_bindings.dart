import 'package:get/get.dart';
import 'package:on_reserve/Controllers/home_controller.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';
import 'package:on_reserve/Controllers/settings_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(SettingsController());
  }
}
