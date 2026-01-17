import 'package:fl_valrn/services/auth_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Future<void> logout() async{
    await AuthService.logout();
  }
}