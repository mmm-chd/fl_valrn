import 'package:fl_valrn/controllers/auth/auth_controller.dart';
import 'package:fl_valrn/controllers/auth/ui_controller.dart';
import 'package:fl_valrn/controllers/location_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    Get.put(LocationController(), permanent: true);
    Get.put(() => AuthController());
    Get.put(() => UiController());
  }
}
