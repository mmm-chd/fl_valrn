import 'package:fl_valrn/components/navbar/custom_bottomNavBar.dart';
import 'package:fl_valrn/components/navbar/custom_bottomNavItem.dart';
import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
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
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeIndex(index),
          items: [
            CustomBottomnavitem(icon: Icons.home, label: 'Beranda'),
            CustomBottomnavitem(icon: Icons.home, label: 'Beranda'),
            CustomBottomnavitem(icon: Icons.home, label: 'Beranda'),
            CustomBottomnavitem(icon: Icons.home, label: 'Beranda'),
            CustomBottomnavitem(icon: Icons.home, label: 'Beranda'),
          ],
          centerItemIndex: 2,
          backgroundColor: Colors.white,
          selectedColor: Colors.green[700]!,
          unselectedColor: Colors.grey[400]!,
          floatingButtonColor: Colors.green[700]!,
          notchStyle: NotchStyle.circular,
          enableAnimation: true,
        ),
        body: controller.pages[controller.currentIndex.value],
      ),
    );
  }
}
