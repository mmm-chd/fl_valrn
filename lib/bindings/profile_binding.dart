import 'package:fl_valrn/controllers/auth/auth_controller.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(()=> ProfileController());
    Get.lazyPut<AuthController>(()=> AuthController());
  }

}