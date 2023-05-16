import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';
import 'package:on_reserve/Pages/Auth/welcome.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    // Require Hybrid Composition mode on Android.
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = false;
    }
  }

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(355, 760),
      center: false,
      alwaysOnTop: true,
      skipTaskbar: false,
      title: "OnReserve",
      backgroundColor: Colors.transparent,
      // skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      maximumSize: Size(355, 760),
      minimumSize: Size(355, 760),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const OnReserve());
}

class OnReserve extends StatelessWidget {
  const OnReserve({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return ScreenUtilInit(
        designSize: const Size(1440, 2960),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder<ThemeController>(builder: (themeController) {
            return GetMaterialApp(
              getPages: AppRoutes.pages,
              title: 'OnReserve',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              themeMode:
                  themeController.dark ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData.dark(useMaterial3: true),
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          });
        });
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: WelcomePage(),
      ),
    );
  }
}
