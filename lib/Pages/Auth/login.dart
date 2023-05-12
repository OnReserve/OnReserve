import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Pages/Auth/auth_base.dart';
import 'package:on_reserve/Pages/Auth/sign_up.dart';
import 'package:on_reserve/Pages/home.dart';
import 'package:on_reserve/helpers/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String subtitle =
        "One stop online reservation and ticketing solution for Ethiopians";
    return Scaffold(
        body: SafeArea(
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
            child: Column(
              children: [
                TextFormField(
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
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                TextFormField(
                  obscureText: true,
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
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 100.h),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.home);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3e4c45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 75.r, vertical: 35.r),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 80.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              color: Colors.white,
                            ),
                          ),
                        )),
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
          )
        ])));
  }
}
