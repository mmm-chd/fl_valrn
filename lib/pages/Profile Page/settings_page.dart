import 'package:fl_valrn/components/widgets/custom_bottomsheetfix.dart';
import 'package:fl_valrn/components/widgets/custom_formSection.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/routes.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<ProfileController> {
  const SettingsPage({super.key});

  void _showLogoutConfirmation(BuildContext context) {
    CustomBottomsheetfix.show(
      context,
      title: 'Log Out',
      initialChildSize: 0.3,
      children: [
        Center(
          child: Column(
            children: [
              CustomText(
                text: 'Are you sure want to logout?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              CustomSpacing(height: 4),
              CustomText(
                text: "We'll miss you, come back anytime",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
      onPressed: () async {
        await controller.logout();
        Get.offAllNamed(AppRoutes.authPage);
      },
      onReset: () {},
      onDismissed: () {},
      primaryButtonText: 'Log Out',
      secondaryButtonText: 'Cancel',
      pForegroundColor: Colors.white,
      pBackgroundColor: Color(0xFFD43E3E),
      sForegroundColor: PColor.primGreen,
      sBackgroundColor: Colors.white,
      sBorderColor: PColor.primGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, left: 8, right: 8),
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 25,
                        color: PColor.primGreen,
                      ),
                    ),
                  ),

                  CustomText(
                    text: "Pengaturan",
                    style: TextStyle(
                      color: PColor.primGreen,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            CustomFormsection(
              margin: EdgeInsets.all(20),
              padding: EdgeInsetsGeometry.all(16),
              border: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Akun & Profil",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  CustomSpacing(height: 12),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.editAccountPage);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          size: 24,
                          color: Colors.grey,
                        ),
                        CustomSpacing(width: 10),
                        CustomText(
                          text: "Edit Akun",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, size: 18),
                      ],
                    ),
                  ),
                  CustomSpacing(height: 12),
                  CustomText(
                    text: "Preferensi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  CustomSpacing(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.translate_rounded,
                        size: 24,
                        color: Colors.grey,
                      ),
                      CustomSpacing(width: 10),
                      CustomText(
                        text: "Bahasa",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                  CustomSpacing(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_rounded,
                        size: 24,
                        color: Colors.grey,
                      ),
                      CustomSpacing(width: 10),
                      CustomText(
                        text: "Notifikasi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                  CustomSpacing(height: 12),
                  Divider(thickness: 1.5, color: Colors.grey),
                  CustomSpacing(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.bookmark_rounded,
                        size: 24,
                        color: Colors.grey,
                      ),
                      CustomSpacing(width: 10),
                      CustomText(
                        text: "Saved Product",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                  CustomSpacing(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.question_mark_rounded,
                        size: 24,
                        color: Colors.grey,
                      ),
                      CustomSpacing(width: 10),
                      CustomText(
                        text: "FnQ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                ],
              ),
            ),

            CustomFormsection(
              margin: EdgeInsets.only(right: 20, left: 20),
              padding: EdgeInsetsGeometry.all(16),
              border: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Mengenai Aplikasi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  CustomSpacing(height: 12),
                  Row(
                    children: [
                      Icon(Icons.info_rounded, size: 24, color: Colors.grey),
                      CustomSpacing(width: 10),
                      CustomText(
                        text: "Tentang Aplikasi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                  CustomSpacing(height: 12),
                  Row(
                    children: [
                      Icon(Icons.shield_rounded, size: 24, color: Colors.grey),
                      CustomSpacing(width: 10),
                      CustomText(
                        text: "Aturan Privasi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    ],
                  ),
                ],
              ),
            ),

            // Logout
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Center(
                child: SizedBox(
                  width: 150,
                  child: GestureDetector(
                    onTap: () => _showLogoutConfirmation(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        CustomSpacing(width: 8),
                        CustomText(
                          text: "Log Out",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
