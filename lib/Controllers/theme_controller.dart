import 'package:get/get.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

class ThemeController extends GetxController {
  bool dark = false;

  bool firstTime = true;

  @override
  Future<void> onInit() async {
    firstTime = await SecuredStorage.read(key: SharedKeys.firstTime) == "1"
        ? true
        : false;
    super.onInit();
  }

  void toggle() {
    dark = !dark;
    // TODO: Save preference
    update();
  }

  void setFirstTime() async {
    await SecuredStorage.store(key: SharedKeys.firstTime, value: "0");
    firstTime = false;
  }
}
