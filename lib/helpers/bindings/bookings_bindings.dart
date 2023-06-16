import 'package:get/get.dart';
import 'package:on_reserve/helpers/bindings/my_companies_binidings.dart';

class BookingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCompaniesBindings());
  }
}
