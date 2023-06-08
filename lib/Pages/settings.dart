import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';
import 'package:on_reserve/Controllers/settings_controller.dart';
import 'package:on_reserve/Pages/Settings%20Bottom%20Sheets/application_info.dart';
import 'package:on_reserve/Pages/Settings%20Bottom%20Sheets/choose_theme.dart';
import 'package:on_reserve/Pages/Settings%20Bottom%20Sheets/toggle_notification.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.58),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 75.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: SettingsGroup(
              title: "GENERAL",
              children: [
                buildNotifications(context),
                buildTheme(context),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: SettingsGroup(
              title: "ACCOUNT SETTINGS",
              children: [
                buildLogout(context),
                buildDeleteAccount(context),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: SettingsGroup(
              title: "ABOUT",
              children: [
                appVersion(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLogout(BuildContext context) => SimpleSettingsTile(
        title: 'Logout',
        subtitle: 'Logout from your account ',
        leading: Icon(Icons.logout,
            size: 95.r,
            color:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
        onTap: () {
          // Dialog
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.find<ProfileController>().logout();
                          Get.back();
                        },
                        child: Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('No')),
                  ],
                );
              });
        },
      );

  Widget buildDeleteAccount(BuildContext context) => SimpleSettingsTile(
        title: 'Delete Account',
        subtitle: 'Delete your account',
        leading: Icon(Icons.delete,
            size: 95.r,
            color:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
        onTap: () {
          // Dialog
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Delete Account'),
                  content:
                      Text('Are you sure you want to delete your account?'),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          if (await Get.find<SettingsController>()
                              .deleteAccount()) {
                            Get.showSnackbar(GetSnackBar(
                              message: 'Account deleted successfully',
                              duration: const Duration(seconds: 2),
                            ));
                            Get.find<ProfileController>().logout();
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              message: 'Something went wrong',
                              duration: const Duration(seconds: 2),
                            ));
                          }
                          Get.back();
                        },
                        child: Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('No')),
                  ],
                );
              });
        },
      );

  Widget buildNotifications(BuildContext context) => SimpleSettingsTile(
        title: "Notifications",
        subtitle: "Manage notifications",
        leading: Icon(Icons.notifications_active,
            size: 95.r,
            color:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
        onTap: () {
          Get.bottomSheet(
            const ToggleNotificationBottomSheet(),
            shape: Get.theme.bottomSheetTheme.shape,
            isScrollControlled: true,
          );
        },
      );

  Widget buildTheme(BuildContext context) => SimpleSettingsTile(
        title: "Theme",
        subtitle: "Choose App Theme",
        leading: Icon(Icons.dark_mode_rounded,
            size: 95.r,
            color:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
        onTap: () {
          Get.bottomSheet(
            const ChooseThemeBottomSheet(),
            shape: Get.theme.bottomSheetTheme.shape,
            isScrollControlled: true,
            clipBehavior: Clip.hardEdge,
            useRootNavigator: true,
            enableDrag: true,
          );
        },
      );

  Widget appVersion(BuildContext context) => SimpleSettingsTile(
        title: "About OnReserve",
        subtitle: "More Information",
        leading: Icon(
          Icons.info,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.85),
          size: 95.r,
        ),
        onTap: () {
          Get.bottomSheet(
            const AppVersionBottomSheet(),
            shape: Get.theme.bottomSheetTheme.shape,
            isScrollControlled: true,
            clipBehavior: Clip.hardEdge,
            useRootNavigator: true,
            enableDrag: true,
          );
        },
      );
}
