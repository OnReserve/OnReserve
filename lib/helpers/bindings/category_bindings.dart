import 'package:get/get.dart';
import 'package:on_reserve/Controllers/category_controller.dart';

class CategoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
