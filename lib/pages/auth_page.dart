import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_checkBox.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_tabBar.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/auth/auth_controller.dart';
import 'package:fl_valrn/controllers/auth/ui_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AuthPage extends GetView<UiController> {
  AuthPage({super.key});
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, 1),
              end: Alignment(1, 1),
              colors: [Colors.lightGreen, PColor.primGreen],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              // HEADER
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 240,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/logo/waisya-white.svg',
                          width: 180,
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
                      ],
                    ),
                  ),
                ),
              ),

              // FORM CONTAINER
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tabBar(),
                        controller.currentTabIndex.value == 0
                            ? _loginForm()
                            : _registerForm(),
                        const CustomSpacing(height: 84),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TAB BAR
  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          height: 53,
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: const Color(0xffECECEC),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTabbar(
                  text: 'Login',
                  tabIndex: 0,
                  currentIndex: controller.currentTabIndex,
                  onTap: (i) => controller.selectTab(i, Get.context!),
                ),
              ),
              const CustomSpacing(width: 4),
              Expanded(
                child: CustomTabbar(
                  text: 'Register',
                  tabIndex: 1,
                  currentIndex: controller.currentTabIndex,
                  onTap: (i) => controller.selectTab(i, Get.context!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form _registerForm() {
    return Form(
      key: controller.registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Email',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const CustomSpacing(height: 8),
          CustomTextfield(
            textInputType: TextInputType.emailAddress,
            label: 'Input email..',
            controller: controller.emailController,
            validator: controller.validateEmail,
          ),
          const CustomSpacing(height: 16.0),
          CustomText(
            text: 'Phone Number',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const CustomSpacing(height: 8),
          CustomTextfield(
            textInputType: TextInputType.phone,
            controller: controller.numberController,
            label: 'Input phone number...',
            prefixText: '+62 ',
            validator: controller.validatePhoneNumber,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const CustomSpacing(height: 8),
                    CustomTextfield(
                      isNumber: false,
                      label: 'John',
                      controller: controller.firstNameController,
                      validator: controller.validateFirstName,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const CustomSpacing(height: 8),
                    CustomTextfield(
                      isNumber: false,
                      label: 'Doe',
                      controller: controller.lastNameController,
                      validator: controller.validateLastName,
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
          const CustomSpacing(height: 8),
          Obx(
            () => CustomTextfield(
              isNumber: false,
              label: 'Input password..',
              obscureText: controller.isObsecurePass.value,
              enableInteractiveSelection: false,
              onTapSuffixIcon: controller.togglePassword,
              useSuffixIcon: true,
              suffixIcon: Icon(
                controller.isObsecurePass.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: Colors.grey,
              ),
              controller: controller.passwordController,
              validator: controller.validatePassword,
            ),
          ),
          const CustomSpacing(height: 16.0),
          CustomText(
            text: 'Confirm Password',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const CustomSpacing(height: 8),
          Obx(
            () => CustomTextfield(
              isNumber: false,
              label: 'Confirm password..',
              obscureText: controller.isObsecureCPass.value,
              enableInteractiveSelection: false,
              onTapSuffixIcon: controller.toggleConfirmPassword,
              useSuffixIcon: true,
              suffixIcon: Icon(
                controller.isObsecureCPass.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: Colors.grey,
              ),
              controller: controller.confirmPasswordController,
              validator: controller.validateConfirmPassword,
            ),
          ),
          const CustomSpacing(height: 52.0),
          Obx(
            () => Column(
              children: [
                CustomText(
                  text: controller.registerGeneralError.value,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
                CustomSpacing(height: 8),
                CustomButton(
                  onPressed: authController.isLoading.value
                      ? null
                      : () {
                          authController.register(
                            email: controller.emailController.text.trim(),
                            phone: controller.numberController.text.trim(),
                            firstName: controller.firstNameController.text
                                .trim(),
                            lastname: controller.lastNameController.text.trim(),
                            password: controller.passwordController.text.trim(),
                            confirmPassword: controller
                                .confirmPasswordController
                                .text
                                .trim(),
                          );
                        },
                  text: authController.isLoading.value
                      ? 'Loading..'
                      : 'Register',
                  backgroundColor: PColor.primGreen,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Form _loginForm() {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
                validator: controller.validateEmail,
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
                  onTapSuffixIcon: controller.togglePassword,
                  useSuffixIcon: true,
                  suffixIcon: Icon(
                    controller.isObsecurePass.value
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: Colors.grey,
                  ),
                  controller: controller.passwordController,
                  validator: controller.validatePassword,
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
                          controller.toggleRememberMe();
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
                      style: TextStyle(color: PColor.primGreen),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const CustomSpacing(height: 72),
          Obx(
            () => Column(
              children: [
                CustomText(
                  text: controller.loginGeneralError.value,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
                CustomSpacing(height: 8),
                CustomButton(
                  onPressed: authController.isLoading.value
                      ? null
                      : () {
                          authController.login(
                            email: controller.emailController.text.trim(),
                            password: controller.passwordController.text.trim(),
                          );
                        },
                  text: authController.isLoading.value ? 'Loading..' : 'Log In',
                  backgroundColor: PColor.primGreen,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
