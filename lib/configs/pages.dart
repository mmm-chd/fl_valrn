
import 'package:fl_valrn/bindings/camera_binding.dart';
import 'package:fl_valrn/bindings/fields_binding.dart';
import 'package:fl_valrn/bindings/home_binding.dart';
import 'package:fl_valrn/bindings/journey_binding.dart';
import 'package:fl_valrn/bindings/login_binding.dart';
import 'package:fl_valrn/bindings/market_binding.dart';
import 'package:fl_valrn/bindings/overview_binding.dart';
import 'package:fl_valrn/bindings/profile_binding.dart';
import 'package:fl_valrn/bindings/settings_binding.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/pages/Profile%20Page/profile_page.dart';
import 'package:fl_valrn/pages/camera_page.dart';
import 'package:fl_valrn/pages/fields_page.dart';
import 'package:fl_valrn/pages/home_page.dart';
import 'package:fl_valrn/bindings/init_binding.dart';
import 'package:fl_valrn/navigation/navBar_page.dart';
import 'package:fl_valrn/pages/journey_page.dart';
import 'package:fl_valrn/pages/login_page.dart';
import 'package:fl_valrn/pages/market_page.dart';
import 'package:fl_valrn/pages/overview_page.dart';
import 'package:fl_valrn/pages/preview_page.dart';
import 'package:fl_valrn/pages/product_page.dart';
import 'package:fl_valrn/pages/Profile%20Page/settings_page.dart';
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
    GetPage(name: AppRoutes.homePage, page: ()=>HomePage(),binding: HomeBinding(),),
    GetPage(name: AppRoutes.fieldsPage, page: ()=>FieldsPage(), binding: FieldsBinding()),
    GetPage(name: AppRoutes.marketPage, page: ()=>MarketPage(), binding: MarketBinding()),
    GetPage(name: AppRoutes.productPage, page: ()=>ProductPage(), binding: MarketBinding()),
    GetPage(name: AppRoutes.profilePage, page: ()=>ProfilePage(), binding: ProfileBinding()),
    GetPage(name: AppRoutes.cameraPage, page: ()=>CameraPage(), binding: CameraBinding()),
    GetPage(
      name: AppRoutes.previewPage,
      page: () => PreviewPage(),
      binding: CameraBinding()
    ),
    GetPage(name: AppRoutes.journeyPage, page: ()=>JourneyPage(), binding: JourneyBinding()),
    GetPage(name: AppRoutes.overviewPage, page: ()=>OverviewPage(), binding: OverviewBinding()),
    GetPage(name: AppRoutes.settingsPage, page: ()=>SettingsPage(), binding: ProfileBinding())
  ];
}