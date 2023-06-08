import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/Models/user.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignUpController extends GetxController {
  var isLoading = false;
  bool error = false;
  String errortext = '';
  bool complete = false;
  bool obscureText = true;
  final FocusNode firstnameFocusNode = FocusNode();
  final FocusNode lastnameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode password2FocusNode = FocusNode();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();

  Future<bool> signUp() async {
    var signUp = {
      "email": emailController.text.trim(),
      "fname": fnameController.text.trim(),
      "lname": lnameController.text.trim(),
      "password": password2Controller.text,
    };
    print(signUp);
    if (await InternetConnectionChecker().hasConnection) {
      var response =
          await NetworkHandler.post(body: signUp, endpoint: 'auth/register/');
      if (response[1] == 200) {
        try {
          Map data = (response[0]);
          print(data);

          // Store The Token
          await SecuredStorage.store(
              key: SharedKeys.token, value: data['token']);

          data.remove('token');
          final user = User.fromJson(data);

          // Store The User
          await SecuredStorage.store(
              key: SharedKeys.user, value: jsonEncode(user.toJson()));

          btnController.success();
          Timer(const Duration(seconds: 2), () {
            btnController.reset();
            Timer(const Duration(milliseconds: 80), () {
              Get.toNamed(Routes.home);
            });
          });
          return true;
        } catch (e) {
          btnController.error();
          Timer(const Duration(seconds: 2), () {
            btnController.reset();
          });
          logger(SignUpController).e(e);
          return false;
        }
      }
    } else {
      // showSimpleNotification(const Text("Check your Internet Connection ..."),
      //     background: Colors.red);
      return false;
    }
    errortext = 'User with this Email already exists';
    update();
    btnController.error();
    Timer(const Duration(seconds: 2), () {
      btnController.reset();
      Timer(const Duration(seconds: 2), () {
        errortext = '';
        update();
      });
    });
    return false;
  }
}
