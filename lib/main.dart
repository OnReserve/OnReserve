import 'dart:io';
import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_reserve/helpers/routes.dart';
import 'package:on_reserve/Pages/Auth/welcome.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';
// import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isAndroid) {
  //   final GoogleMapsFlutterPlatform mapsImplementation =
  //       GoogleMapsFlutterPlatform.instance;
  //   if (mapsImplementation is GoogleMapsFlutterAndroid) {
  //     mapsImplementation.useAndroidViewSurface = false;
  //   }
  // }

  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      // size: Size(355, 760),
      size: Size(300, 585),
      center: false,
      alwaysOnTop: true,
      skipTaskbar: false,
      title: "OnReserve",
      backgroundColor: Colors.transparent,
      // titleBarStyle: TitleBarStyle.hidden,
      // maximumSize: Size(355, 760),
      maximumSize: Size(300, 585),
      // minimumSize: Size(355, 760),
      minimumSize: Size(300, 585),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // TODO: Remove this when done testing
  const bool test = true;

  final firstTime = await SecuredStorage.check(key: SharedKeys.firstTime);
  final isLoggedIn = await SecuredStorage.check(key: SharedKeys.token);

  String initialRoute = test
      // ignore: dead_code
      ? Routes.test
      // ignore: dead_code
      : isLoggedIn
          ? Routes.home
          : firstTime
              ? Routes.onBoarding
              : Routes.login;

  await dotenv.load();

  runApp(OnReserve(initialRoute: initialRoute));
}

class OnReserve extends StatelessWidget {
  final String initialRoute;
  const OnReserve({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());

    return ScreenUtilInit(
        designSize: const Size(1440, 2960),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder<ThemeController>(builder: (theme) {
            return GetMaterialApp(
              initialRoute: initialRoute,
              getPages: AppRoutes.pages,
              title: 'OnReserve',
              theme: FlexThemeData.light(
                scheme: FlexScheme.materialBaseline,
                surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                blendLevel: 7,
                subThemesData: const FlexSubThemesData(
                  blendOnLevel: 10,
                  blendOnColors: false,
                  useTextTheme: true,
                  useM2StyleDividerInM3: true,
                ),
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                useMaterial3: true,
                swapLegacyOnMaterial3: true,
                // To use the Playground font, add GoogleFonts package and uncomment
                // fontFamily: GoogleFonts.notoSans().fontFamily,
              ),
              darkTheme: FlexThemeData.dark(
                scheme: FlexScheme.materialBaseline,
                surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
                blendLevel: 13,
                subThemesData: const FlexSubThemesData(
                  blendOnLevel: 20,
                  useTextTheme: true,
                  useM2StyleDividerInM3: true,
                ),
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                useMaterial3: true,
                swapLegacyOnMaterial3: true,
                // To use the Playground font, add GoogleFonts package and uncomment
                // fontFamily: GoogleFonts.notoSans().fontFamily,
              ),
              themeMode: theme.dark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
            );
          });
        });
  }
}

class GetStarted extends StatelessWidget {
  const GetStarted({super.key, required this.title});

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
