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
    if (!uiController.loginFormKey.currentState!.validate()) {
      print('❌ Login validation failed');
      return;
    }
    try {
      isLoading.value = true;
      uiController.loginGeneralError.value = '';
      final result = await UserService.login(email: email, password: password);

      if (result.token.isNotEmpty) {
        Get.offAllNamed(AppRoutes.navbarPage);
      } else {
        uiController.loginGeneralError.value = result.message;
      }
    } on SocketException {
      uiController.loginGeneralError.value = 'No internet connection';
    } on HttpException {
      uiController.loginGeneralError.value = 'Server error, please try again';
    } on FormatException {
      uiController.loginGeneralError.value = 'Invalid response from server';
    } catch (e) {
      uiController.loginGeneralError.value =
          'Not Found, Please check your fill in';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String email,
    required String phone,
    required String firstName,
    required String lastname,
    required String password,
    required String confirmPassword,
  }) async {
    if (!uiController.registerFormKey.currentState!.validate()) {
      print('❌ Register validation failed');
      return;
    }
    try {
      isLoading.value = true;
      uiController.registerGeneralError.value = '';

      final result = await UserService.register(
        email: email,
        phone: phone,
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
    } on SocketException {
      uiController.registerGeneralError.value = 'No internet connection';
    } on HttpException {
      uiController.registerGeneralError.value =
          'Server error, please try again';
    } on FormatException {
      uiController.registerGeneralError.value = 'Invalid response from server';
    } catch (e) {
      uiController.registerGeneralError.value = 'Please check your fill in';
    } finally {
      isLoading.value = false;
    }
  }
}
