import 'package:fl_valrn/controllers/auth_controller.dart';
import 'package:fl_valrn/controllers/location_controller.dart';
import 'package:fl_valrn/controllers/login_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(UserController(), permanent: true);
    Get.put(LocationController(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(LoginController());
  }

}