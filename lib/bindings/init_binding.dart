import 'package:fl_valrn/controllers/field_controller.dart';
import 'package:fl_valrn/controllers/home_controller.dart';
import 'package:fl_valrn/controllers/market_controller.dart';
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
  }
}
