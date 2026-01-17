import 'package:fl_valrn/controllers/auth_controller.dart';
import 'package:fl_valrn/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<AuthController>(()=> AuthController());
  }
}
