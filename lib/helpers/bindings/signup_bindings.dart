import 'package:get/get.dart';
import 'package:on_reserve/Controllers/signup_controller.dart';

class SignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
