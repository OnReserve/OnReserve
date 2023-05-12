import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool dark = false;

  void toggle() {
    dark = !dark;
    // TODO: Save preference
    update();
  }
}
