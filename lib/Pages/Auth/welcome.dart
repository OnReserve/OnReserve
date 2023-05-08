import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_reserve/Pages/Auth/auth_base.dart';
import 'package:on_reserve/Pages/Auth/login.dart';
import 'package:on_reserve/Pages/Auth/sign_up.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String subtitle =
        "The best online reservation and ticketing system. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ornare nunc odio, et rhoncus ante consectetur id";
    return AuthBase(
        background: "assets/Images/Intro slider screen.png",
        subTitle: subtitle,
        children: [
          SizedBox(height: 100.h),
          Image.asset(
            "assets/Images/Brazuca Sitting.png",
            fit: BoxFit.cover,
          ),
          SizedBox(height: 350.h),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignUpPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.r, vertical: 25.r),
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 80.sp),
                  ),
                )),
          )
        ]);
  }
}
