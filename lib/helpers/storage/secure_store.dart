import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:on_reserve/helpers/log/logger.dart';

class SharedKeys {
  static const String token = "token";
  static const String user = "user";
  static const String firstTime = "firstTime";
  static const String theme = "theme";
  static const String profile = "profile";
  static const String package = "package";
  static const String notification = "notification";
  static const List list = [
    package,
    theme,
    profile,
    user,
  ];
}

class SecuredStorage {
  static const storage = FlutterSecureStorage();

  static Future<bool> check({required String key}) async {
    logger(SecuredStorage).i('SECURE STORAGE : CHECKING THE KEY CALLED $key');
    return await storage.containsKey(key: key);
  }

  static Future<String?> read({required String key}) async {
    logger(SecuredStorage).i('SECURE STORAGE : READING THE KEY CALLED $key');
    return await storage.read(key: key);
  }

  static Future<void> store(
      {required String key, required String value}) async {
    logger(SecuredStorage).i('SECURE STORAGE : STORING TO KEY CALLED $key');
    await storage.write(key: key, value: value);
  }

  static Future<void> clear() async {
    logger(SecuredStorage).i('CLEARING PREFRENCE KEYS !!');
    for (var key in SharedKeys.list) {
      await storage.delete(key: key);
    }
  }

  static Future<void> delete(key) async {
    logger(SecuredStorage).i('CLEARING REFRESH TOKEN !!');
    await storage.delete(key: key);
  }
}
