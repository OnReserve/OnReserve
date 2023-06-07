import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:nice_intro/intro_screen.dart';
import 'package:nice_intro/intro_screens.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';

List<IntroScreen> pages = [
  IntroScreen(
    title: 'Search',
    imageAsset: 'assets/Images/intro1.png',
    description: 'Quickly find all your messages',
    headerBgColor: Colors.white,
  ),
  IntroScreen(
    title: 'Focused Inbox',
    headerBgColor: Colors.white,
    imageAsset: 'assets/Images/intro2.png',
    description: "We've put your most important, actionable emails here",
  ),
  IntroScreen(
    title: 'Social',
    headerBgColor: Colors.white,
    imageAsset: 'assets/Images/intro3.png',
    description: "Keep talking with your mates",
  ),
];

class IntroScreenDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IntroScreens introScreens = IntroScreens(
      footerBgColor: Colors.blue,
      activeDotColor: Colors.white,
      footerRadius: 18.0,
      indicatorType: IndicatorType.CIRCLE,
      slides: pages,
      onDone: () {
        SecuredStorage.store(key: SharedKeys.firstTime, value: 'false');
        Get.toNamed(Routes.welcome);
      },
    );

    return Scaffold(
      body: introScreens,
    );
  }
}
