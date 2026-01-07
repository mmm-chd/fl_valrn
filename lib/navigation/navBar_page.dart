import 'package:fl_valrn/components/navbar/custom_bottomNavBar.dart';
import 'package:fl_valrn/components/navbar/custom_bottomNavItem.dart';
import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/navigation/navBar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                  CustomBottomnavitem(
                    label: 'Beranda',
                    customIconUnselectedBuilder: (size) =>
                        navSvgIcon('assets/icons/unselected/home.svg', size),
                    customIconSelectedBuilder: (size) => navSvgIcon(
                      'assets/icons/selected/home_selected.svg',
                      size,
                    ),
                  ),
                  CustomBottomnavitem(
                    label: 'Fields',
                    customIconUnselectedBuilder: (size) =>
                        navSvgIcon('assets/icons/unselected/fields.svg', size),
                    customIconSelectedBuilder: (size) => navSvgIcon(
                      'assets/icons/selected/field_selected.svg',
                      size,
                    ),
                  ),
                  CustomBottomnavitem(
                    label: 'Identifier',
                    customIconUnselectedBuilder: (size) => navSvgIcon(
                      'assets/icons/unselected/identifier.svg',
                      size,
                    ),
                    customIconSelectedBuilder: (size) => navSvgIcon(
                      'assets/icons/unselected/identifier.svg',
                      size,
                    ),
                  ),
                  CustomBottomnavitem(
                    label: 'Ecommerce',
                    customIconUnselectedBuilder: (size) => navSvgIcon(
                      'assets/icons/unselected/ecommerce.svg',
                      size,
                    ),
                    customIconSelectedBuilder: (size) => navSvgIcon(
                      'assets/icons/selected/ecommerce_selected.svg',
                      size,
                    ),
                  ),
                  CustomBottomnavitem(
                    label: 'Profile',
                    customIconUnselectedBuilder: (size) =>
                        navSvgIcon('assets/icons/unselected/profile.svg', size),
                    customIconSelectedBuilder: (size) => navSvgIcon(
                      'assets/icons/selected/profile_selected.svg',
                      size,
                    ),
                  ),
                ],
                centerItemIndex: 2,
                backgroundColor: Colors.white,
                selectedColor: PColor.primGreen,
                unselectedColor: Colors.grey.shade400,
                floatingButtonColor: PColor.primGreen,
                notchStyle: NotchStyle.circular,
                height: 56,
                showIndicatorDot: true,
                floatingButtonSize: 64,
                iconSize: 32,
                floatingButtonIconSize: 48,
                textSize: 12,
                notchRadius: 32,
                notchSpacing: 4,
                notchCornerRadius: 6,
                floatingButtonHeight: 6,
                bottomPadding: 12,
                animationDuration: const Duration(milliseconds: 300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navSvgIcon(String path, double size, {Color? color}) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        path,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        allowDrawingOutsideViewBox: true,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
      ),
    );
  }
}
