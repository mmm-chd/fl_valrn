import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // =========================
  // TEXT CONTROLLERS
  // =========================
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // =========================
  // STATES
  // =========================
  final isLoading = false.obs;
  final isObsecurePass = true.obs;
  final isObsecureCPass = true.obs;
  final isCheckedRememberMe = false.obs;
  final currentTabIndex = 0.obs; // 0 = Login, 1 = Register

  // =========================
  // TAB HANDLER
  // =========================
  void selectTab(int index) {
    if (currentTabIndex.value == index) return;

    if (_hasAnyText()) {
      _showLeaveDialog(
        onConfirm: () {
          _clearAll();
          currentTabIndex.value = index;
          Get.back();
        },
      );
    } else {
      currentTabIndex.value = index;
    }
  }

  // =========================
  // PASSWORD TOGGLE
  // =========================
  void togglePassword() {
    isObsecurePass.toggle();
  }

  void toggleConfirmPassword() {
    isObsecureCPass.toggle();
  }

  // =========================
  // REMEMBER ME
  // =========================
  void toggleRememberMe() {
    isCheckedRememberMe.toggle();
  }

  // =========================
  // HELPERS
  // =========================
  bool _hasAnyText() {
    return emailController.text.isNotEmpty ||
        firstNameController.text.isNotEmpty ||
        lastNameController.text.isNotEmpty ||
        passwordController.text.isNotEmpty ||
        confirmPasswordController.text.isNotEmpty;
  }

  void _clearAll() {
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // =========================
  // DIALOG
  // =========================
  void _showLeaveDialog({required VoidCallback onConfirm}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Do you want to leave all the progress?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "You will need to fill in again",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onConfirm,
              child: const Text("Yes"),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: Get.back,
              child: Text("Cancel", style: TextStyle(color: Colors.grey[700])),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // LIFECYCLE
  // =========================
  @override
  void onClose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
