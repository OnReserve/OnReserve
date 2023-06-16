import 'package:get/get.dart';
import 'package:on_reserve/Controllers/my_companies_controller.dart';

class MyCompaniesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCompaniesController());
  }
}
