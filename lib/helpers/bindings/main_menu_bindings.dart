import 'package:get/get.dart';
import 'package:on_reserve/Controllers/home_controller.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => HomeController());
  }
}
