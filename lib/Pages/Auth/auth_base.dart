import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBase extends StatelessWidget {
  const AuthBase({
    super.key,
    required this.subTitle,
    required this.background,
    required this.children,
    this.reversed = false,
    this.getStarted = false,
  });

  final String subTitle;
  final String background;
  final List<Widget> children;
  final bool border = false;
  final bool getStarted;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          background,
          fit: BoxFit.cover,
          colorBlendMode: getStarted ? BlendMode.softLight : BlendMode.lighten,
          color: getStarted ? Colors.black : Colors.transparent,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 170.h, horizontal: 95.w),
          padding: EdgeInsets.symmetric(vertical: 70.h, horizontal: 50.w),
          decoration: border
              ? BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                )
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 60.h),
                child: Image(
                  image: const AssetImage(
                    'assets/Images/logo.png',
                  ),
                  width: 219.w,
                  height: 219.h,
                ),
              ),
              Text(
                'OnReserve',
                style: TextStyle(
                  fontSize: 100.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                  color: !getStarted ? Colors.white : Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.h),
                child: Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontFamily: "Inter",
                    color: !getStarted ? Colors.white : Colors.black,
                  ),
                ),
              ),
              ...children,
            ],
          ),
        ),
      ],
    );
  }
}
