import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';
import 'package:on_reserve/Controllers/theme_controller.dart';
import 'package:on_reserve/Pages/Profile%20Bottom%20Sheets/edit_profile.dart';

import 'Settings Bottom Sheets/choose_theme.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    var controller2 = Get.find<ThemeController>();
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              backgroundColor: Theme.of(context).colorScheme.primary,
              userName:
                  "${controller.user!.firstName} ${controller.user!.lastName}",
              backgroundMotifColor: Theme.of(context).colorScheme.background,
              userMoreInfo: Text(
                controller.user!.email,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 45.sp,
                ),
              ),
              userProfilePic: CachedNetworkImageProvider(
                controller.user!.profilePic!.startsWith('https://api.')
                    ? 'https://img.freepik.com/free-icon/user_318-159711.jpg'
                    : controller.user!.profilePic!,
              ),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: "Modify",
                subtitle: "Tap to change your data",
                onTap: () {
                  controller.coverPic = null;
                  controller.profilePic = null;
                  controller.profbio.text = controller.user!.bio ?? '';
                  controller.lname.text = controller.user!.lastName;
                  controller.fname.text = controller.user!.firstName;
                  controller.phoneNumber.text =
                      controller.user!.phoneNumber ?? '';
                  controller.name.text = '';
                  Get.bottomSheet(
                    const EditProfileBottomSheet(),
                    shape: Get.theme.bottomSheetTheme.shape,
                    isScrollControlled: true,
                    clipBehavior: Clip.hardEdge,
                    useRootNavigator: true,
                    enableDrag: true,
                  );
                },
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: 'General',
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.abc,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  subtitle: "Make Onreserve yours",
                ),
                SettingsItem(
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.black54,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: controller2.dark,
                    onChanged: (value) {
                      if (value) {
                        controller2.setTheme(newTheme: OnReserveTheme.dark);
                        controller2.toggle();
                      } else {
                        controller2.setTheme(newTheme: OnReserveTheme.light);
                        controller2.toggle();
                      }
                    },
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.notifications,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Notification',
                  subtitle: "On",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about OnReserve",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
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
                                    controller.logout();
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
                  icons: Icons.exit_to_app_rounded,
                  title: "Log Out",
                ),
                SettingsItem(
                  onTap: () {
                    // Dialog
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete account'),
                            content: Text(
                                'Are you sure you want to delete your account? This action cannot be undone. All your data will be lost.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    controller.deleteAccount();
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
                  icons: Icons.delete,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildLogout(BuildContext context) => SimpleSettingsTile(
  //       title: 'Logout',
  //       subtitle: 'Logout from your account ',
  //       leading: Icon(Icons.logout,
  //           size: 95.r,
  //           color:
  //               Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
  //       onTap: () {
  //         // Dialog
  //         showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 title: Text('Logout'),
  //                 content: Text('Are you sure you want to logout?'),
  //                 actions: [
  //                   TextButton(
  //                       onPressed: () {
  //                         Get.find<controller>().logout();
  //                         Get.back();
  //                       },
  //                       child: Text('Yes')),
  //                   TextButton(
  //                       onPressed: () {
  //                         Get.back();
  //                       },
  //                       child: Text('No')),
  //                 ],
  //               );
  //             });
  //       },
  //     );

  // Widget buildDeleteAccount(BuildContext context) => SimpleSettingsTile(
  //       title: 'Delete Account',
  //       subtitle: 'Delete your account',
  //       leading: Icon(Icons.delete,
  //           size: 95.r,
  //           color:
  //               Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
  //       onTap: () {
  //         // Dialog
  //         showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                 title: Text('Delete Account'),
  //                 content:
  //                     Text('Are you sure you want to delete your account?'),
  //                 actions: [
  //                   TextButton(
  //                       onPressed: () async {
  //                         if (await Get.find<SettingsController>()
  //                             .deleteAccount()) {
  //                           Get.showSnackbar(GetSnackBar(
  //                             message: 'Account deleted successfully',
  //                             duration: const Duration(seconds: 2),
  //                           ));
  //                           Get.find<controller>().logout();
  //                         } else {
  //                           Get.showSnackbar(GetSnackBar(
  //                             message: 'Something went wrong',
  //                             duration: const Duration(seconds: 2),
  //                           ));
  //                         }
  //                         Get.back();
  //                       },
  //                       child: Text('Yes')),
  //                   TextButton(
  //                       onPressed: () {
  //                         Get.back();
  //                       },
  //                       child: Text('No')),
  //                 ],
  //               );
  //             });
  //       },
  //     );

  // Widget buildNotifications(BuildContext context) => SimpleSettingsTile(
  //       title: "Notifications",
  //       subtitle: "Manage notifications",
  //       leading: Icon(Icons.notifications_active,
  //           size: 95.r,
  //           color:
  //               Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
  //       onTap: () {
  //         Get.bottomSheet(
  //           const ToggleNotificationBottomSheet(),
  //           shape: Get.theme.bottomSheetTheme.shape,
  //           isScrollControlled: true,
  //         );
  //       },
  //     );

  // Widget buildTheme(BuildContext context) => SimpleSettingsTile(
  //       title: "Theme",
  //       subtitle: "Choose App Theme",
  //       leading: Icon(Icons.dark_mode_rounded,
  //           size: 95.r,
  //           color:
  //               Theme.of(context).colorScheme.onBackground.withOpacity(0.85)),
  //       onTap: () {
  //         Get.bottomSheet(
  //           const ChooseThemeBottomSheet(),
  //           shape: Get.theme.bottomSheetTheme.shape,
  //           isScrollControlled: true,
  //           clipBehavior: Clip.hardEdge,
  //           useRootNavigator: true,
  //           enableDrag: true,
  //         );
  //       },
  //     );

  // Widget appVersion(BuildContext context) => SimpleSettingsTile(
  //       title: "About OnReserve",
  //       subtitle: "More Information",
  //       leading: Icon(
  //         Icons.info,
  //         color: Theme.of(context).colorScheme.onBackground.withOpacity(0.85),
  //         size: 95.r,
  //       ),
  //       onTap: () {
  //         Get.bottomSheet(
  //           const AppVersionBottomSheet(),
  //           shape: Get.theme.bottomSheetTheme.shape,
  //           isScrollControlled: true,
  //           clipBehavior: Clip.hardEdge,
  //           useRootNavigator: true,
  //           enableDrag: true,
  //         );
  //       },
  //     );
}
