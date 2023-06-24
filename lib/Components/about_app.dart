import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/settings_controller.dart';

class AppVersionBottomSheet extends StatelessWidget {
  const AppVersionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SettingsController>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: EdgeInsets.only(
            left: 28.r,
            right: 28.r,
            top: 25.r,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: 30.0.r, left: 30.r, right: 30.r),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 115.h,
                          width: 230.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                invertColors: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? true
                                    : false,
                                image: const AssetImage(
                                  "assets/Images/Logo.png",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        '  ${controller.appName} Version ${controller.version}',
                        style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .darken()),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '  Build ${controller.buildNumber}',
                        style: TextStyle(
                          fontSize: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rollingIconBuilder(bool value, Size iconSize, bool isSelected) {
    IconData data = Icons.notifications_active;
    if (!value) data = Icons.notifications_off;
    return Icon(
      data,
      size: iconSize.shortestSide,
    );
  }

  Widget buildNotificationToggler() {
    Get.find<SettingsController>();
    return GetBuilder<SettingsController>(builder: (controller) {
      return AnimatedToggleSwitch<bool>.rolling(
        current: controller.notifications,
        values: const [true, false],
        onChanged: (i) {
          controller.toggleNotifications(i);
        },
        iconBuilder: rollingIconBuilder,
        borderColor: Colors.transparent,
        foregroundBoxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1.5),
          )
        ],
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1.5),
          )
        ],
      );
    });
  }
}
