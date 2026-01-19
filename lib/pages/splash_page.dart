import 'package:fl_valrn/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller.animationController,
        builder: (_, __) {
          return Container(
            color: controller.bgColorAnimation.value,
            child: Center(
              child: FadeTransition(
                opacity: controller.fadeAnimation,
                child: ScaleTransition(
                  scale: controller.scaleAnimation,
                  child: SvgPicture.asset('assets/logo/logoW.svg', width: 140),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
