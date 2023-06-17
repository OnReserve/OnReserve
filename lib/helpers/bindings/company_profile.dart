import 'package:get/get.dart';
import 'package:on_reserve/Controllers/company_profile_controller.dart';

class CompanyProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompanyProfileController());
  }
}
