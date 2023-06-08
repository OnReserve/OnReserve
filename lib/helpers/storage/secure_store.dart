import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedKeys {
  static const String token = "token";
  static const String user = "user";
  static const String firstTime = "firstTime";
  static const String theme = "theme";
  static const String profile = "profile";
  static const String package = "package";
  static const String notification = "notification";
  static const List list = [
    token,
    user,
    firstTime,
    theme,
    profile,
    package,
    notification,
  ];
}

class SecuredStorage {
  static var storage;

  static Future<bool> check({required String key}) async {
    storage = Platform.isWindows
        ? await SharedPreferences.getInstance()
        : FlutterSecureStorage();
    logger(SecuredStorage).i('SECURE STORAGE : CHECKING THE KEY CALLED $key');
    return Platform.isWindows
        ? await (storage as SharedPreferences).get(key) != null
        : await storage.containsKey(key: key);
  }

  static Future<String?> read({required String key}) async {
    storage = Platform.isWindows
        ? await SharedPreferences.getInstance()
        : FlutterSecureStorage();
    logger(SecuredStorage).i('SECURE STORAGE : READING THE KEY CALLED $key');
    try {
      return Platform.isWindows
          ? await (storage as SharedPreferences).getString(key)
          : await storage.read(key: key);
    } catch (e) {
      logger(SecuredStorage).e('ERROR WHILE READING PREFRENCE KEYS !! $e');
    }
    return null;
  }

  static Future<void> store(
      {required String key, required String value}) async {
    storage = Platform.isWindows
        ? await SharedPreferences.getInstance()
        : FlutterSecureStorage();
    logger(SecuredStorage).i('SECURE STORAGE : STORING TO KEY CALLED $key');
    try {
      if (Platform.isWindows) {
        await (storage as SharedPreferences).setString(key, value);
        return;
      }
      await storage.write(key: key, value: value);
    } catch (e) {
      logger(SecuredStorage).e('ERROR WHILE STORING PREFRENCE KEYS !! $e');
    }
  }

  static Future<void> clear() async {
    storage = Platform.isWindows
        ? await SharedPreferences.getInstance()
        : FlutterSecureStorage();
    logger(SecuredStorage).i('CLEARING PREFRENCE KEYS !!');
    for (var key in SharedKeys.list) {
      try {
        if (Platform.isWindows) {
          await (storage as SharedPreferences).remove(key);
          continue;
        }
        await storage.delete(key: key);
      } catch (e) {
        logger(SecuredStorage).e('ERROR WHILE CLEARING PREFRENCE KEYS !! $e');
      }
    }
  }

  static Future<void> delete(key) async {
    storage = Platform.isWindows
        ? await SharedPreferences.getInstance()
        : FlutterSecureStorage();
    logger(SecuredStorage).i('CLEARING REFRESH TOKEN !!');
    if (Platform.isWindows) {
      await (storage as SharedPreferences).remove(key);
      return;
    }
    await storage.delete(key: key);
  }
}
