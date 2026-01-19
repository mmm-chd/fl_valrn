import 'package:fl_valrn/components/widgets/custom_bottomSheet.dart';
import 'package:fl_valrn/components/widgets/custom_bottomSheetFix.dart';
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

  // ===== LOGIN ERRORS =====
  final emailError = ''.obs;
  final passwordError = ''.obs;

  // ===== REGISTER ERRORS =====
  final firstNameError = ''.obs;
  final lastNameError = ''.obs;
  final confirmPasswordError = ''.obs;
  final registerGeneralError = ''.obs;

  void clearAllErrors() {
    emailError.value = '';
    passwordError.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
    confirmPasswordError.value = '';
    registerGeneralError.value = '';
  }

  void clearLoginErrors() {
    emailError.value = '';
    passwordError.value = '';
  }

  void clearRegisterErrors() {
    emailError.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    registerGeneralError.value = '';
  }

  bool validateLogin() {
    clearLoginErrors();
    bool isValid = true;

    if (emailController.text.isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Email format is invalid';
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    }

    return isValid;
  }

  bool validateRegister() {
    clearRegisterErrors();
    bool isValid = true;

    if (emailController.text.isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Email format is invalid';
      isValid = false;
    }

    if (firstNameController.text.isEmpty) {
      firstNameError.value = 'First name is required';
      isValid = false;
    }

    if (lastNameController.text.isEmpty) {
      lastNameError.value = 'Last name is required';
      isValid = false;
    }

    if (passwordController.text.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    }

    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    return isValid;
  }

  // =========================
  // TAB HANDLER
  // =========================
  void selectTab(int index, BuildContext context) {
    if (currentTabIndex.value == index) return;

    clearAllErrors();

    if (_hasAnyText()) {
      _showLeaveSheet(
        onConfirm: () {
          clearAll();
          currentTabIndex.value = index;
          Get.back();
        },
        context: context,
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

  void clearAll() {
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // =========================
  // DIALOG
  // =========================
  void _showLeaveSheet({required VoidCallback onConfirm, context}) {
    CustomBottomsheetfix.show(
      context,
      title: '',
      hideHeader: true,
      initialChildSize: 0.32,
      onDismissed: () {},
      onPressed: onConfirm,
      onReset: () => Get.back(),
      primaryButtonText: 'Yes',
      secondaryButtonText: 'No',
      pBackgroundColor: Colors.red,
      sBorderColor: Colors.grey.shade300,
      sForegroundColor: Colors.grey.shade400,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Do you want to leave all the progress?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Text(
              "You will need to fill in again",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
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
