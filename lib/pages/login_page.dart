import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_checkBox.dart';
import 'package:fl_valrn/components/widgets/custom_iconButton.dart';
import 'package:fl_valrn/components/widgets/custom_iconButtonCircle.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_tabBar.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.xy(-1, 1),
              end: AlignmentGeometry.xy(1, 1),
              colors: [Colors.lightGreen, Colors.green],
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 14,
                        top: 70,
                        left: 14,
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'PlantApp',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 44,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const CustomSpacing(height: 10),
                              CustomText(
                                text:
                                    'This application was created to help farmers out there.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade100,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const CustomSpacing(height: 34),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // TABBAR
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 360,
                                      height: 53,
                                      margin: EdgeInsets.only(bottom: 0),
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Color(0xffECECEC),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTabbar(
                                            text: 'Login',
                                            onTap: (index) =>
                                                controller.selectTab(index),
                                            currentIndex:
                                                controller.currentTabIndex,
                                            tabIndex: 0,
                                          ),
                                          CustomTabbar(
                                            text: 'Register',
                                            onTap: (index) =>
                                                controller.selectTab(index),
                                            currentIndex:
                                                controller.currentTabIndex,
                                            tabIndex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                controller.currentTabIndex.value == 0
                                    ? _loginForm()
                                    : _registerForm(),
                                const CustomSpacing(height: 34.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomText(
                                        text: 'Or sign in with',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const CustomSpacing(height: 32),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {},
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 1.5,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: SvgPicture.asset(
                                              'assets/socialIcons/facebook_icon.svg',
                                              width: 44,
                                              height: 44,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    CustomSpacing(width: 16),
                                    Expanded(
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {},
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 1.5,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: SvgPicture.asset(
                                              'assets/socialIcons/google_icon.svg',
                                              width: 44,
                                              height: 44,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const CustomSpacing(height: 32),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _registerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Email',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const CustomSpacing(height: 10),
        CustomTextfield(
          isNumber: false,
          label: 'john@gmail.com',
          controller: controller.emailController,
        ),
        const CustomSpacing(height: 16.0),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'First Name',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const CustomSpacing(height: 10),
                  CustomTextfield(
                    isNumber: false,
                    label: 'John',
                    controller: controller.firstNameController,
                  ),
                ],
              ),
            ),
            const CustomSpacing(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Last Name',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const CustomSpacing(height: 10),
                  CustomTextfield(
                    isNumber: false,
                    label: 'Doe',
                    controller: controller.lastNameController,
                  ),
                ],
              ),
            ),
          ],
        ),
        const CustomSpacing(height: 16.0),
        CustomText(
          text: 'Password',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const CustomSpacing(height: 10),
        Obx(
          () => CustomTextfield(
            isNumber: false,
            label: 'Enter your password..',
            obscureText: controller.isObsecurePass.value,
            enableInteractiveSelection: false,
            onTapIcon: controller.tooglePasswordPass,
            useSuffixIcon: true,
            suffixIcon: Icon(
              controller.isObsecurePass.value
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
            controller: controller.passwordController,
          ),
        ),
        const CustomSpacing(height: 16.0),
        CustomText(
          text: 'Confirm Password',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const CustomSpacing(height: 10),
        Obx(
          () => CustomTextfield(
            isNumber: false,
            label: 'Confirm your password..',
            obscureText: controller.isObsecureCPass.value,
            enableInteractiveSelection: false,
            onTapIcon: controller.tooglePasswordCPass,
            useSuffixIcon: true,
            suffixIcon: Icon(
              controller.isObsecureCPass.value
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
            controller: controller.passwordController,
          ),
        ),
        const CustomSpacing(height: 32.0),
        Obx(
          () => CustomButton(
            onPressed: () {},
            text: controller.isLoading.value ? 'Loading..' : 'Register',
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Column _loginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Email',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const CustomSpacing(height: 10),
        CustomTextfield(
          isNumber: false,
          label: 'Enter your email..',
          controller: controller.emailController,
        ),
        const CustomSpacing(height: 16.0),
        CustomText(
          text: 'Password',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const CustomSpacing(height: 10),
        Obx(
          () => CustomTextfield(
            isNumber: false,
            label: 'Enter your password..',
            obscureText: controller.isObsecurePass.value,
            enableInteractiveSelection: false,
            onTapIcon: controller.tooglePasswordPass,
            useSuffixIcon: true,
            suffixIcon: Icon(
              controller.isObsecurePass.value
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
            controller: controller.passwordController,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(
                () => CustomCheckbox(
                  value: controller.isCheckedRememberMe.value,
                  onChanged: (value) {
                    controller.toogleRememberMe();
                  },
                  label: 'Remember me',
                  padding: EdgeInsets.all(0),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  borderColor: Colors.grey.shade600,
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: CustomText(
                text: 'Forgot Password?',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
        const CustomSpacing(height: 32.0),
        Obx(
          () => CustomButton(
            onPressed: () {},
            text: controller.isLoading.value ? 'Loading..' : 'Log In',
            backgroundColor: Colors.lightGreen,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
