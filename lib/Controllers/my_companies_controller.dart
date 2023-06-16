import 'package:get/get.dart';

class MyCompaniesController extends GetxController {
  var args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    print(args);
  }
}
