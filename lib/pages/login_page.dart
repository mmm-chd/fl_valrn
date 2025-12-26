import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_checkBox.dart';
import 'package:fl_valrn/components/widgets/custom_socialButton.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_tabBar.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_textField.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, 1),
            end: Alignment(1, 1),
            colors: [Colors.lightGreen, PColor.primGreen],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // =========================
            // HEADER
            // =========================
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 240,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 70, 14, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
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
                    ],
                  ),
                ),
              ),
            ),

            // =========================
            // FORM CONTAINER
            // =========================
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tabBar(),
                      controller.currentTabIndex.value == 0
                          ? _loginForm()
                          : _registerForm(),
                      const CustomSpacing(height: 34),
                      _socialDivider(),
                      const CustomSpacing(height: 32),
                      _socialButtons(),
                      const CustomSpacing(height: 32),
                    ],
                  ),
                ),
              ),
            ),

            // =========================
            // FILL SPACE (AVOID WHITE GAP)
            // =========================
            const SliverFillRemaining(
              hasScrollBody: false,
              child: CustomSpacing(),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // TAB BAR
  // =========================
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
                  onTap: (i) => controller.selectTab(i),
                ),
              ),
              const CustomSpacing(width: 4),
              Expanded(
                child: CustomTabbar(
                  text: 'Register',
                  tabIndex: 1,
                  currentIndex: controller.currentTabIndex,
                  onTap: (i) => controller.selectTab(i),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // SOCIAL
  // =========================
  Widget _socialDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey)),
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
        Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }

  Widget _socialButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomSocialbutton(type: 'facebook', onTap: () {}),
        ),
        const CustomSpacing(width: 16),
        Expanded(
          child: CustomSocialbutton(type: 'google', onTap: () {}),
        ),
      ],
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
            onTapSuffixIcon: controller.togglePassword,
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
            onTapSuffixIcon: controller.toggleConfirmPassword,
            useSuffixIcon: true,
            suffixIcon: Icon(
              controller.isObsecureCPass.value
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
            controller: controller.confirmPasswordController,
          ),
        ),
        const CustomSpacing(height: 32.0),
        Obx(
          () => CustomButton(
            onPressed: () {},
            text: controller.isLoading.value ? 'Loading..' : 'Register',
            backgroundColor: PColor.primGreen,
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
            onTapSuffixIcon: controller.togglePassword,
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
        const CustomSpacing(height: 16.0),
        Obx(
          () => CustomButton(
            onPressed: () {},
            text: controller.isLoading.value ? 'Loading..' : 'Log In',
            backgroundColor: PColor.primGreen,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
