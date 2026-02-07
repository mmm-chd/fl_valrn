import 'dart:io';

import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/controllers/auth/ui_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:fl_valrn/services/user_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final UserController userC = Get.find<UserController>();
  final uiController = Get.find<UiController>();

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      final result = await UserService.login(email: email, password: password);

      if (result.token.isNotEmpty) {
        Get.offAllNamed(AppRoutes.navbarPage);
      } else {
        uiController.loginError.value = result.message;
      }
    } on SocketException {
      uiController.loginError.value = 'No internet connection';
    } on HttpException {
      uiController.loginError.value = 'Server error, please try again';
    } on FormatException {
      uiController.loginError.value = 'Invalid response from server';
    } catch (e) {
      uiController.loginError.value = 'Please check your fill in';
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
    try {
      isLoading.value = true;

      final result = await UserService.register(
        email: email,
        phone: number,
        firstName: firstName,
        lastName: lastname,
        password: password,
        confirmPassword: confirmPassword,
      );

      if (result.message.isNotEmpty && result.token.isNotEmpty) {
        Get.snackbar('Success', 'Register successful');
        uiController.clearAll();
        uiController.currentTabIndex.value = 0;

        Get.back();
      } else {
        uiController.registerGeneralError.value = result.message;
      }
    } catch (e) {
      uiController.registerGeneralError.value =
          'Unable to connect. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
