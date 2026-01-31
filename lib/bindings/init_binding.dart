import 'package:fl_valrn/controllers/camera_controller.dart';
import 'package:fl_valrn/controllers/field_controller.dart';
import 'package:fl_valrn/controllers/home_controller.dart';
import 'package:fl_valrn/controllers/journal_controller.dart';
import 'package:fl_valrn/controllers/market_controller.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/main.dart';
import 'package:fl_valrn/navigation/navBar_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // navbar page yang nanti akan masuk ke navBar init di sini
    Get.lazyPut<NavbarController>(() => NavbarController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FieldsController>(() => FieldsController());
    Get.lazyPut<MarketController>(() => MarketController());
    Get.lazyPut<CameraPageController>(() => CameraPageController(cameras.first));
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<JournalController>(()=> JournalController());
  }
}
