import 'package:fl_valrn/bindings/home_binding.dart';
import 'package:fl_valrn/bindings/login_binding.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/pages/home_page.dart';
import 'package:fl_valrn/pages/login_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(name: AppRoutes.homePage, page: ()=>HomePage(),binding: HomeBinding(),)
  ];
}
