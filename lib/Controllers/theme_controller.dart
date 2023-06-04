import 'package:get/get.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

class ThemeController extends GetxController {
  bool dark = false;
  bool loggedIn = false;
  bool firstTime = true;

  void reset() async {
    await SecuredStorage.clear();
  }

  void toggle() {
    dark = !dark;
    update();
  }

  void setLoggedIn() async {
    await SecuredStorage.store(key: SharedKeys.token, value: "1");
    loggedIn = true;
  }

  void setFirstTime() async {
    await SecuredStorage.store(key: SharedKeys.firstTime, value: "0");
    firstTime = false;
  }
}
