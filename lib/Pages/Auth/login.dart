import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/login_controller.dart';
import 'package:on_reserve/Pages/Auth/auth_base.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
    String subtitle =
        "One stop online reservation and ticketing solution for Ethiopians";

    return ScaffoldMessenger(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Images/Login BG.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: AuthBase(
                    background: "assets/Images/Login BG.png",
                    subTitle: subtitle,
                    children: [
                  SizedBox(height: 80.h),
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 95.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 80.h),
                  Form(
                    key: logInFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: loginController.emailController,
                          validator:
                              ValidationBuilder().email().maxLength(50).build(),
                          onFieldSubmitted: (value) {
                            loginController.passwordFocusNode.requestFocus();
                          },
                          decoration: InputDecoration(
                            hintText: 'Johndoe@gmail.com',
                            hintStyle: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              color: Colors.black,
                            ),
                            fillColor: const Color.fromARGB(200, 255, 255, 255),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.h),
                        TextFormField(
                          obscureText: true,
                          focusNode: loginController.passwordFocusNode,
                          controller: loginController.passwordController,
                          validator: ValidationBuilder()
                              .minLength(8, 'Password Length < 8 😟')
                              .build(),
                          onFieldSubmitted: (value) {
                            if (logInFormKey.currentState!.validate())
                              loginController.login();
                          },
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              color: Colors.black,
                            ),
                            fillColor: const Color.fromARGB(200, 255, 255, 255),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(height: 100.h),
                            GetBuilder<LoginController>(
                                builder: (loginController) {
                              return RoundedLoadingButton(
                                color: const Color(0xFF3e4c45),
                                child: Text('Login',
                                    style: TextStyle(color: Colors.white)),
                                controller: loginController.btnController,
                                onPressed: () async {
                                  if (logInFormKey.currentState!
                                      .validate()) if (!await loginController.login()) {
                                    SnackBar(content: Text("Sign Up Failed"));
                                  }
                                },
                              );
                            }),
                            SizedBox(height: 170.h),
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 50.sp,
                                fontFamily: "Inter",
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 45.h),
                            Text.rich(
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(
                                  fontSize: 50.sp,
                                  fontFamily: "Inter",
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.signUp);
                                      },
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      fontSize: 50.sp,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]))),
      ),
    );
  }
}
