import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/login_controller.dart';
import 'package:fl_valrn/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  final isLoading= false.obs;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try{
      isLoading.value= true;

      final result= await AuthService.login(
        email: email,
        password: password
      );

      if (result['token'] != null) {
        Get.offAllNamed(
          AppRoutes.navbarPage
        );
      }else {
          Get.snackbar('Login Failed', 
          result['message'] ?? 'Invalid credentials',);
      } 
    }catch (e){
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value= false;
    }
  }

  Future<void> register ({
    required String email,
    required String firstName,
    required String lastname,
    required String password,
    required String confirmPassword,
  }) async {
    try{
      isLoading.value= true;

      final result = await AuthService.register(
        email: email,
        firstName: firstName,
        lastName: lastname,
        password: password,
        confirmPassword: confirmPassword
      );

      if (result['success'] == true || result['token'] != null) {
      Get.snackbar('Success', 'Register successful');
      final loginController= Get.find<LoginController>();
      loginController.clearAll;
      Get.offAllNamed(
        AppRoutes.loginPage
      ); 
        } else {
          Get.snackbar(
            'Register failed',
            result['message'] ?? 'Something went wrong',
          );
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        isLoading.value = false;
      }
  }
}