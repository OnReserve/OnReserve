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
}
