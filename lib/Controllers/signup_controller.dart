import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';
import 'package:on_reserve/helpers/routes.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();

  Future<bool> signUp() async {
    var signUp = {
      "email": emailController.text,
      "fname": fnameController.text,
      "lname": lnameController.text,
      "password": passwordController.text,
    };
    print(signUp);
    if (await InternetConnectionChecker().hasConnection) {
      var response =
          await NetworkHandler.post(body: signUp, endpoint: 'auth/register/');
      if (response[1] == 200) {
        try {
          Map data = (response[0]);
          print(data);
          // Get.toNamed(Routes.otp,
          //     arguments: {"username": username, "phoneNumber": phone});
          // Get.toNamed(Routes.otp, arguments: {
          //   "username": username,
          //   "phoneNumber": phone,
          // });
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
