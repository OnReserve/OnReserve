import 'package:get/get.dart';
import 'package:on_reserve/Pages/Settings%20Bottom%20Sheets/choose_theme.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

class ThemeController extends GetxController {
  bool dark = false;
  bool loggedIn = false;
  bool firstTime = true;
  OnReserveTheme theme = OnReserveTheme.light;

  @override
  void onInit() async {
    try {
      var themeString = await SecuredStorage.read(key: SharedKeys.theme);
      if (themeString != null) {
        theme = OnReserveTheme.values
            .firstWhere((element) => element.toString() == themeString);
        dark = theme == OnReserveTheme.dark;
        update();
      }
    } catch (e) {
      print(e);
    }
    super.onInit();
  }

  void reset() async {
    await SecuredStorage.clear();
  }

  void setTheme({required OnReserveTheme newTheme}) {
    theme = newTheme;
    SecuredStorage.store(key: SharedKeys.theme, value: theme.toString());
    update();
  }

  void toggle() {
    dark = !dark;
    if (dark) {
      setTheme(newTheme: OnReserveTheme.dark);
    } else {
      setTheme(newTheme: OnReserveTheme.light);
    }
    update();
  }
}
