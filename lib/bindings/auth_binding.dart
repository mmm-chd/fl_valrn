import 'package:fl_valrn/controllers/auth/auth_controller.dart';
import 'package:fl_valrn/controllers/auth/ui_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UiController>(() => UiController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
