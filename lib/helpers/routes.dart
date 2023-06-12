import 'package:get/get.dart';
import 'package:on_reserve/Pages/Auth/login.dart';
import 'package:on_reserve/Pages/Auth/sign_up.dart';
import 'package:on_reserve/Pages/Auth/welcome.dart';
import 'package:on_reserve/Pages/add_event.dart';
import 'package:on_reserve/Pages/booking_history.dart';
import 'package:on_reserve/Pages/category.dart';
import 'package:on_reserve/Pages/company.dart';
import 'package:on_reserve/Pages/event.dart';
import 'package:on_reserve/Pages/main_menu.dart';
import 'package:on_reserve/Pages/my_companies.dart';
import 'package:on_reserve/Pages/new_home.dart';
import 'package:on_reserve/Pages/payment.dart';
import 'package:on_reserve/Pages/profile.dart';
import 'package:on_reserve/Pages/qr_code.dart';
import 'package:on_reserve/Pages/reserve.dart';
import 'package:on_reserve/Pages/settings.dart';
import 'package:on_reserve/helpers/bindings/add_event_bindings.dart';
import 'package:on_reserve/helpers/bindings/category_bindings.dart';
import 'package:on_reserve/helpers/bindings/event_detail_bindings.dart';
import 'package:on_reserve/helpers/bindings/home_bindings.dart';
import 'package:on_reserve/helpers/bindings/login_bindings.dart';
import 'package:on_reserve/helpers/bindings/payment_bindings.dart';
import 'package:on_reserve/helpers/bindings/profile_bindings.dart';
import 'package:on_reserve/helpers/bindings/qr_bindings.dart';
import 'package:on_reserve/helpers/bindings/reserve_bindings.dart';
import 'package:on_reserve/helpers/bindings/settings_bindings.dart';
import 'package:on_reserve/helpers/bindings/signup_bindings.dart';

class Routes {
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String home = "/home";
  static const String onBoarding = "/onBoarding";
  static const String aboutUs = "/aboutUs";
  static const String eventDetail = "/eventDetail";
  static const String addEvent = "/addEvent";
  static const String contactUs = "/contactUs";
  static const String settings = "/settings";
  static const String pay = "/pay";
  static const String profile = "/profile";
  static const String qr = "/qrPage";
  static const String reserve = "/reserve";
  static const String category = "/category";
  static const String companyProfile = "/companyProfile";
  static const String bookingHistory = "/bookingHistory";
  static const String welcome = "/welcome";
  static const String test = "/test";
  static const String myCompanies = "/mycompanies";
  static const String root = "/";
}

class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.test,
      page: () => CompanyProfile(),
    ),
    GetPage(
      name: Routes.companyProfile,
      page: () => CompanyProfile(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.addEvent,
      page: () => const AddEvent(),
      binding: AddEventBindings(),
    ),
    GetPage(
      name: Routes.myCompanies,
      page: () => MyCompanies(),
      // binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpPage(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => AppSettingsPage(),
      binding: SettingsBindings(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.bookingHistory,
      page: () => BookingHistory(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.home,
      page: () => MainMenu(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.category,
      page: () => Category(),
      binding: CategoryBindings(),
    ),
    GetPage(
        name: Routes.pay,
        page: () => const Payment(),
        binding: PaymentBindings()),
    GetPage(
        name: Routes.reserve,
        page: () => const Reserve(),
        binding: ReserveBindings()),
    GetPage(
        name: Routes.eventDetail,
        page: () => const Event(),
        binding: EventDetailBindings()),
    GetPage(
      name: Routes.qr,
      page: () => const QRPage(),
      binding: QrBindings(),
    ),
    GetPage(
      name: Routes.welcome,
      page: () => const WelcomePage(),
    ),
  ];
}
