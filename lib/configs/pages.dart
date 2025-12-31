import 'package:fl_valrn/bindings/init_binding.dart';
import 'package:fl_valrn/bindings/login_binding.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/navigation/navBar_page.dart';
import 'package:fl_valrn/pages/login_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.navbarPage,
      page: () => NavbarPage(),
      binding: InitBinding(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
