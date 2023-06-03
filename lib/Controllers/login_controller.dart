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

class LoginController extends GetxController {
  var isLoading = false;
  bool error = false;
  String errortext = '';
  bool complete = false;
  bool obscureText = true;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> login() async {
    var login = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    print(login);
    if (await InternetConnectionChecker().hasConnection) {
      var response =
          await NetworkHandler.post(body: login, endpoint: 'auth/login/');
      if (response[1] == 200) {
        try {
          Map data = (response[0]);

          // Store The Token
          SecuredStorage.store(key: SharedKeys.token, value: data['token']);
          data.remove('token');
          final user = User.fromJson(data);

          // Store The User
          SecuredStorage.store(
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
          logger(LoginController).e(e);
          return false;
        }
      }
    } else {
      return false;
    }
    errortext = 'Something went wrong';
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

class MyCustomWidget extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(
      Duration(seconds: 3),
      () {
        // _btnController.success();
        _btnController.error();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RoundedLoadingButton(
          child: Text('Sign Up', style: TextStyle(color: Colors.white)),
          controller: _btnController,
          onPressed: _doSomething,
        ),
      ),
    );
  }
}
