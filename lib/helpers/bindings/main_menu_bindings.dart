import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
