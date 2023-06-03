import 'package:get/get.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

class ThemeController extends GetxController {
  bool dark = false;
  bool loggedIn = false;
  bool firstTime = true;

  @override
  Future<void> onInit() async {
    firstTime = await SecuredStorage.read(key: SharedKeys.firstTime) == "1"
        ? true
        : false;
    loggedIn =
        await SecuredStorage.read(key: SharedKeys.token) == "1" ? true : false;

    super.onInit();
  }

  void toggle() {
    dark = !dark;
    // TODO: Save preference
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
