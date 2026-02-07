import 'package:fl_valrn/components/widgets/custom_bottomSheetFix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  // TEXT CONTROLLERS
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // STATES
  final isLoading = false.obs;
  final isObsecurePass = true.obs;
  final isObsecureCPass = true.obs;
  final isCheckedRememberMe = false.obs;
  final currentTabIndex = 0.obs; // 0 = Login, 1 = Register

  // ERRORS HANDLING
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final loginGeneralError = ''.obs;

  final phoneNumberError = ''.obs;
  final firstNameError = ''.obs;
  final lastNameError = ''.obs;
  final confirmPasswordError = ''.obs;
  final registerGeneralError = ''.obs;

  void clearAllErrors() {
    emailError.value = '';
    phoneNumberError.value = '';
    passwordError.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
    confirmPasswordError.value = '';
    registerGeneralError.value = '';
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!GetUtils.isEmail(emailController.text)) {
      return "Email is invalid";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "First name is required";
    } else if (!GetUtils.isPhoneNumber(numberController.text)) {
      return 'Phone number is invalid';
    }
    return null;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "First name is required";
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Last name is required";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (passwordController.text.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null ||
        value.isEmpty ||
        passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  // TAB HANDLER
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

  // PASSWORD TOGGLE
  void togglePassword() {
    isObsecurePass.toggle();
  }

  void toggleConfirmPassword() {
    isObsecureCPass.toggle();
  }

  // REMEMBER ME
  void toggleRememberMe() {
    isCheckedRememberMe.toggle();
  }

  // HELPERS
  bool _hasAnyText() {
    return emailController.text.isNotEmpty ||
        numberController.text.isNotEmpty ||
        firstNameController.text.isNotEmpty ||
        lastNameController.text.isNotEmpty ||
        passwordController.text.isNotEmpty ||
        confirmPasswordController.text.isNotEmpty;
  }

  void clearAll() {
    emailController.clear();
    numberController.clear();
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // BOTTOM SHEET
  void _showLeaveSheet({required VoidCallback onConfirm, context}) {
    CustomBottomsheetfix.show(
      context,
      title: '',
      hideHeader: true,
      initialChildSize: 0.34,
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

  // LIFECYCLE
  @override
  void onClose() {
    emailController.dispose();
    numberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
