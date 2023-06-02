import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';
import 'package:on_reserve/helpers/routes.dart';

class IntroScreenDemo extends StatelessWidget {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
            title: 'On Reserve',
            bodyWidget: Column(
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "The Best Way to Reserve a Table",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                ElevatedButton(
                    onPressed: () {
                      // setState(() => _status = 'Going to the next page...');
                      // 3. Use the `currentState` member to access functions defined in `IntroductionScreenState`
                      Future.delayed(const Duration(seconds: 3),
                          () => _introKey.currentState?.next());
                    },
                    child: const Text('Start'))
              ],
            )),
        PageViewModel(
            title: 'Page Two',
            bodyWidget: Column(
              children: [
                const Text('That\'s all folks'),
                ElevatedButton(
                    onPressed: () {
                      // setState(() => _status = 'Going to the next page...');

                      Get.find<ThemeController>().setFirstTime();

                      Get.toNamed(Routes.welcome);
                    },
                    child: const Text('Start'))
              ],
            ))
      ],
      showNextButton: false,
      showDoneButton: false,
    );
  }
}
