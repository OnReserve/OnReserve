import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}
