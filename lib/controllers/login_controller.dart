import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isObsecurePass = true.obs;
  var isObsecureCPass = true.obs;
  var isCheckedRememberMe = false.obs;

  var currentTabIndex = 0.obs; // 0 for Login, 1 for Register

  void selectTab(int index) {
    currentTabIndex.value = index;

    if (index == 0) {
      // Login tab selected
      // loadLoginData();
    } else {
      // Register tab selected
      // loadRegisterData();
    }
  }

  void tooglePasswordPass() async {
    isObsecurePass.value = !isObsecurePass.value;
    await Future.delayed(Duration(seconds: 1));
    isObsecurePass.value = true;
  }

  void tooglePasswordCPass() async {
    isObsecureCPass.value = !isObsecureCPass.value;
    await Future.delayed(Duration(seconds: 1));
    isObsecureCPass.value = true;
  }

  void toogleRememberMe() {
    isCheckedRememberMe.value = !isCheckedRememberMe.value;
  }

  // loadLoginData() async {
  //   Response response = await get(
  //       "http://mvs.bslmeiyu.com/api/v1/auth/login"
  //   );
  //   print("login data ${response.body.toString()}");
  // }

  // loadRegisterData() async {
  //   Response response = await get(
  //       "http://mvs.bslmeiyu.com/api/v1/auth/register"
  //   );
  //   print("register data ${response.body.toString()}");
  // }

  @override
  void onInit() {
    super.onInit();
    // Load initial data for login tab
    // loadLoginData();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
