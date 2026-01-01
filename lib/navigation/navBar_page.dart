import 'package:fl_valrn/components/navbar/custom_bottomNavBar.dart';
import 'package:fl_valrn/components/navbar/custom_bottomNavItem.dart';
import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/navigation/navBar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarPage extends GetView<NavbarController> {
  const NavbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 🔹 PAGE CONTENT
            Positioned.fill(
              child: controller.pages[controller.currentIndex.value],
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomNavBar(
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeIndex,
                items: [
                  CustomBottomnavitem(icon: Icons.home, label: 'Beranda'),
                  CustomBottomnavitem(icon: Icons.explore, label: 'Fields'),
                  CustomBottomnavitem(icon: Icons.add, label: 'Add'),
                  CustomBottomnavitem(icon: Icons.history, label: 'History'),
                  CustomBottomnavitem(icon: Icons.person, label: 'Profile'),
                ],
                centerItemIndex: 2,
                backgroundColor: Colors.white,
                selectedColor: PColor.primGreen,
                unselectedColor: Colors.grey.shade400,
                floatingButtonColor: PColor.primGreen,
                notchStyle: NotchStyle.circular,
                height: 84,
                showLabels: true,
                enableAnimation: true,
                floatingButtonSize: 72,
                iconSize: 28,
                textSize: 12,
                notchRadius: 38,
                notchSpacing: 4,
                notchCornerRadius: 6,
                floatingButtonHeight: 6,
                animationDuration: const Duration(milliseconds: 300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
