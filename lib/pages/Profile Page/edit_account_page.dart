import 'package:fl_valrn/components/widgets/custom_buildLabel.dart';
import 'package:fl_valrn/components/widgets/custom_buildTextField.dart';
import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountPage extends GetView<ProfileController> {
  const EditAccountPage({super.key});

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

              // Nama Pertama
              FormLabel(label: "Nama Pertama*"),
              FormInputField(hint: "Emmanuel Michael"),
              CustomSpacing(height: 20),

              // Nama Terakhir
              FormLabel(label: "Nama Terakhir*"),
              FormInputField(hint: "Emmanuel Michael"),
              CustomSpacing(height: 20),

              // Nomor Telepon
              FormLabel(label: "Nomor Telepon*"),
              FormInputField(hint: "081234567890"),
              CustomSpacing(height: 40),

              CustomButton(
                text: "Simpan Perubahan",
                backgroundColor: PColor.primGreen,
                foregroundColor: Colors.white,
                onPressed: () {},
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
