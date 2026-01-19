import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> bgColorAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    _initAnimation();
    verifyLogin();
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

  Future<void> verifyLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      Get.offAllNamed(AppRoutes.navbarPage);
    } else {
      Get.offAllNamed(AppRoutes.authPage);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
