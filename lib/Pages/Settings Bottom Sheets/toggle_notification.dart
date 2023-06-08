import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/settings_controller.dart';

class ToggleNotificationBottomSheet extends StatelessWidget {
  const ToggleNotificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Toggle Notification',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close_outlined)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(child: buildNotificationToggler()),
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
