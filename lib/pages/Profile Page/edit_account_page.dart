import 'package:fl_valrn/components/widgets/custom_buildLabel.dart';
import 'package:fl_valrn/components/widgets/custom_buildTextField.dart';
import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/edit_account_controller.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:fl_valrn/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountPage extends GetView<ProfileController> {
  EditAccountPage({super.key});
  final userC = Get.find<UserController>();
  int? get id => userC.id.value;
  final c = Get.find<EditAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                margin: const EdgeInsets.only(top: 30, left: 8, right: 8),
                height: 56,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: Get.back,
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 25,
                          color: PColor.primGreen,
                        ),
                      ),
                    ),

                    CustomText(
                      text: "Edit Account",
                      style: TextStyle(
                        color: PColor.primGreen,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              CustomSpacing(height: 24),

              // Profile Picture
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/logo/logoW.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Edit icon
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          // Logic untuk ganti foto
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 16,
                          color: PColor.primGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSpacing(height: 32),

              
              Obx(() {
                if (c.isLoading.value) return CircularProgressIndicator();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormLabel(label: "Nama Pertama*"),
                    FormInputField(controller: c.nameC, hint: controller.profile.value?.name ?? '-',),
                    CustomSpacing(height: 20),

                    FormLabel(label: "Email*"),
                    FormInputField(controller: c.emailC, hint: controller.profile.value?.email ?? '-',),
                    CustomSpacing(height: 20),

                    FormLabel(label: "Nomor Telepon*"),
                    FormInputField(controller: c.phoneC, hint: controller.profile.value?.phone ?? '-',),
                    CustomSpacing(height: 20),

                    FormLabel(label: "Facebook*"),
                    FormInputField(controller: c.facebookC, hint: controller.profile.value?.facebook ?? '-',),
                    CustomSpacing(height: 20),

                    FormLabel(label: "Instagram*"),
                    FormInputField(controller: c.instaC, hint: controller.profile.value?.insta ?? '-',),
                    CustomSpacing(height: 20),

                    FormLabel(label: "Tentang Saya*"),
                    FormInputField(controller: c.aboutC, hint: controller.profile.value?.about ?? '-',),
                    CustomSpacing(height: 20),
                  ],
                );
              }),

              CustomButton(
                text: "Simpan Perubahan",
                backgroundColor: PColor.primGreen,
                foregroundColor: Colors.white,
                onPressed: () {
                   c.updateProfile(id!);
                },
              ),
              CustomSpacing(height: 12),

              // Change Password Button
              CustomButton(
                text: "Change Password",
                backgroundColor: Colors.white,
                foregroundColor: PColor.primGreen,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: PColor.primGreen),
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {},
              ),
              CustomSpacing(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
