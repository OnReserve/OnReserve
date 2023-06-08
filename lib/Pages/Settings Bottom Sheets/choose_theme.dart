import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';

enum OnReserveTheme { light, dark, system }

class ChooseThemeBottomSheet extends StatelessWidget {
  const ChooseThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ThemeController>();
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
                        'Choose Theme',
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
                height: 13,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(child: buildThemeChooser()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rollingIconBuilder(
      OnReserveTheme value, Size iconSize, bool isSelected) {
    IconData data = Icons.sunny;
    if (value == OnReserveTheme.dark) data = Icons.dark_mode_rounded;
    if (value == OnReserveTheme.system) data = Icons.settings_system_daydream;
    return Icon(
      data,
      size: iconSize.shortestSide,
    );
  }

  Widget buildThemeChooser() {
    return GetBuilder<ThemeController>(builder: (themecontroller) {
      return AnimatedToggleSwitch<OnReserveTheme>.rolling(
        current: themecontroller.theme,
        values: const [
          OnReserveTheme.dark,
          OnReserveTheme.light,
          OnReserveTheme.system
        ],
        onChanged: (i) {
          themecontroller.setTheme(newTheme: i);
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
