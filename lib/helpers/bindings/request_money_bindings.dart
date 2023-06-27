import 'package:get/get.dart';
import 'package:on_reserve/Controllers/payment_request.dart';

class RequestMoneyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestMoneyController());
  }
}
