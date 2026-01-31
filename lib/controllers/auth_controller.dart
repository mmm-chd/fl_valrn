import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/login_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final UserController userC = Get.find<UserController>();

  Future<void> login({required String email, required String password}) async {
    final loginController = Get.find<LoginController>();
    try {
      isLoading.value = true;

      final result = await AuthService.login(email: email, password: password);

      if (result['token'] != null) {
        final token = result['token'];
        final profile = await AuthService.getProfile();

        userC.setUser(
          id: profile['id'],
          name: profile['name'],
          email: profile['email'],
        );

        Get.offAllNamed(AppRoutes.navbarPage);
      } else {
        loginController.passwordError.value =
            result['message'] ?? 'Invalid credentials';
      }
    } catch (e) {
      loginController.passwordError.value =
          'Unable to connect. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String email,
    required String number,
    required String firstName,
    required String lastname,
    required String password,
    required String confirmPassword,
  }) async {
    final loginController = Get.find<LoginController>();
    try {
      isLoading.value = true;

      final result = await AuthService.register(
        email: email,
        phone: number,
        firstName: firstName,
        lastName: lastname,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (result['success'] == true || result['token'] != null) {
        Get.snackbar('Success', 'Register successful');
        final loginController = Get.find<LoginController>();
        loginController.clearAll();
        loginController.currentTabIndex.value = 0;

        Get.back();
      } else {
        loginController.registerGeneralError.value =
            result['message'] ?? 'Register failed';
      }
    } catch (e) {
      loginController.registerGeneralError.value =
          'Unable to connect. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
