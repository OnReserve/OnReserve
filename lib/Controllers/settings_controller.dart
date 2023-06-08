import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:on_reserve/helpers/network/network_provider.dart';
import 'package:on_reserve/helpers/storage/secure_store.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

class SettingsController extends GetxController {
  final userController = Get.find<ProfileController>();
  bool isLoading = false;
  bool notifications = true;
  bool sound = true;
  List<bool> obscureText = [true, true];
  List<bool> changed = [false, false];
  String stream = "";
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  static Map<int, String> streams = {
    2: "Social Science",
    1: "Natural Science",
  };

  @override
  void onInit() {
    checkNotificationsEnabled();
    appVersion();
    super.onInit();
  }

  // Request the Notification permission on Android
  Future<bool> requestPermission() async {
    if (await Permission.notification.request().isGranted) {
      logger(SettingsController).i('Notification Permission Granted');
      notifications = true;
      update();
      return true;
    }
    return false;
  }

  void appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    update();
  }

  void changeObscureText(int index) {
    obscureText[index] = !obscureText[index];
    update();
  }

  Future<bool> deleteAccount() async {
    List<dynamic> response = await NetworkHandler.delete(
        // TODO: Change endpoint to delete account
        endpoint: 'accounts/user/${userController.user!}/');
    if (response[1] >= 204 && response[1] < 300) {
      return true;
    } else {
      return false;
    }
  }

  // Check if notifications are enabled
  void checkNotificationsEnabled() async {
    var prefs = await SecuredStorage.read(key: SharedKeys.notification);
    bool enabled = prefs == 'true' ? true : false;
    notifications = enabled;
    update();
  }

  // Toggle notifications
  void toggleNotifications(bool enabled) async {
    await SecuredStorage.store(
        key: SharedKeys.notification, value: enabled.toString());
    if (enabled) {
      await requestPermission().then((value) async {
        if (value) {
          // Schedule next notification
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: 'schedule_reminder',
              title: 'Notification Enabled',
              body: 'Successfully enabled notifications',
            ),
            schedule: NotificationCalendar(
              weekday: DateTime.now().weekday,
              hour: DateTime.now().hour,
              minute: DateTime.now().minute + 1,
            ),
          );
        } else {
          await AwesomeNotifications().cancelAllSchedules();
        }
      });
    } else {
      notifications = false;
      update();
    }
  }
}
