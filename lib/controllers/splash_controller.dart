import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> bgColorAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    _initAnimation();
    _checkLoginAndNavigate();
  }

  void _initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    bgColorAnimation = ColorTween(begin: Colors.white, end: PColor.primGreen)
        .animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
        );

    scaleAnimation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutBack),
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    animationController.forward();
  }

  Future<void> _checkLoginAndNavigate() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      print('🔍 Checking login status...');

      final isLoggedIn = await AuthService.isLoggedIn();

      print('📊 Is Logged In: $isLoggedIn');

      if (isLoggedIn) {
        try {
          await AuthService.getProfile();
          print('✅ Token valid, navigating to navbar...');
          Get.offAllNamed(AppRoutes.navbarPage);
        } catch (e) {
          print('⚠️ Token invalid: $e');
          await AuthService.clearStorage();
          Get.offAllNamed(AppRoutes.authPage);
        }
      } else {
        print('❌ Not logged in, navigating to auth page...');
        Get.offAllNamed(AppRoutes.authPage);
      }
    } catch (e) {
      print('❌ ERROR in splash: $e');
      Get.offAllNamed(AppRoutes.authPage);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
