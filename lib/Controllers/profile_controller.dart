import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:on_reserve/Models/user.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

class ProfileController extends GetxController {
  var isLoading = false;
  User? user;

  Future<void> logout() async {
    await SecuredStorage.clear();
    Get.offAllNamed(Routes.login);
  }

  @override
  void onInit() async {
    try {
      var userjson = await SecuredStorage.read(key: SharedKeys.user);
      if (userjson != null) user = User.fromJson(jsonDecode(userjson));
    } catch (e) {
      logger(ProfileController).e(e);
    }
    super.onInit();
  }
}
