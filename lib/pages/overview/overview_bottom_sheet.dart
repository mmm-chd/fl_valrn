import 'package:fl_valrn/components/widgets/custom_bottomSheet.dart';
import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/controllers/journal_controller.dart';
import 'package:fl_valrn/controllers/analysis_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/widgets/custom_bottomSheetFix.dart';
import '../../../../../components/widgets/custom_formSection.dart';
import '../../../../../components/widgets/custom_spacing.dart';
import '../../../../../components/widgets/custom_text.dart';
import '../../../../../configs/themes_color.dart';

class OverviewBottomSheet {
  // ================= ADD TO MYFIELDS =================
  static void showAdd(BuildContext context) {
    CustomBottomsheetfix.show(
      context,
      title: "Add to Myfields",
      onDismissed: () {},
      children: [
        const CustomSpacing(height: 6),

        const CustomText(
          text:
              "Pilih opsi untuk menambahkan field ke daftar kamu atau membuat field baru.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),

        const CustomSpacing(height: 20),

        _menuItem(
          icon: Icons.home,
          title: "Perbarui Fields",
          subtitle: "Sesuaikan dan perbarui data field",
          onTap: () {
            Get.back();
            Future.delayed(
              const Duration(milliseconds: 300),
              () => showUpdate(context),
            );
          },
        ),

        const CustomSpacing(height: 12),

        _menuItem(
          icon: Icons.add,
          title: "Buat Fields Baru",
          subtitle: "Buat field baru untuk pengelolaan",
          onTap: () {
            Get.back();
            Future.delayed(
              const Duration(milliseconds: 300),
              () => showCreate(context),
            );
          },
        ),
      ],
    );
  }

  // ================= UPDATE FIELDS (SIMPLIFIED - HANYA BUTTON) =================
  static void showUpdate(BuildContext context) {
    final journalController = Get.find<JournalController>();
    
    // Initialize AnalysisController jika belum ada
    if (!Get.isRegistered<AnalysisController>()) {
      Get.put(AnalysisController());
    }
    final analysisController = Get.find<AnalysisController>();
    
    CustomBottomsheet.show(
      context,
      title: "Perbarui Fields",
      initialChildSize: 0.55,
      primaryButtonText: "Tutup",
      pBackgroundColor: PColor.primGreen,
      pForegroundColor: Colors.white,
      onPressed: () {
        Get.back();
      },
      onDismissed: () {},
      children: [
        const CustomText(
          text:
              "Pilih field yang ingin kamu analisis.",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),

        const CustomSpacing(height: 16),

        Obx(() {
          if (journalController.isLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: PColor.primGreen,
                ),
              ),
            );
          }

          if (journalController.journals.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CustomText(
                  text: "Belum ada field yang tersedia",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }

          return Column(
            children: journalController.journals.map((journal) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _fieldItem(
                  journal.title,
                  journal.description ?? '-',
                  onTap: () {
                    // ✅ Tampilkan bottom sheet dengan HANYA button update
                    _showUpdateButton(context, journal.id, journal.title);
                  },
                ),
              );
            }).toList(),
          );
        })
      ],
    );
  }

  // ✅ BOTTOM SHEET SIMPLIFIED - HANYA ADA BUTTON UPDATE
  static void _showUpdateButton(BuildContext context, int journalId, String journalTitle) {
    final analysisController = Get.find<AnalysisController>();

    CustomBottomsheetfix.show(
      context,
      title: "Create Analysis",
      onDismissed: () {},
      children: [
        CustomText(
          text: "Field: $journalTitle",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const CustomSpacing(height: 8),
        
        const CustomText(
          text: "Klik tombol di bawah untuk membuat analysis dengan data default.",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),

        const CustomSpacing(height: 24),

        // ✅ HANYA BUTTON UPDATE
        Obx(() {
          return CustomButton(
            text: analysisController.isLoading.value ? "Loading..." : "Update Analysis",
            backgroundColor: PColor.primGreen,
            onPressed: analysisController.isLoading.value 
              ? null 
              : () async {
                  // Hit API /api/v1/analyses
                  await analysisController.createAnalysis(journalId);
                  
                  // Tutup bottom sheet setelah success
                  if (!analysisController.isLoading.value) {
                    Get.back(); // Tutup bottom sheet update button
                    Get.back(); // Tutup bottom sheet list journals
                  }
                },
          );
        }),
      ],
    );
  }

  // ================= CREATE FIELDS =================
  static void showCreate(BuildContext context) {
    final titleC = TextEditingController();
    final descC = TextEditingController();
    final imageC = TextEditingController();
    
    CustomBottomsheetfix.show(
      context,
      title: "Buat Fields Baru",
      initialChildSize: 0.55,
      primaryButtonText: "Buat Fields",
      pBackgroundColor: PColor.primGreen,
      pForegroundColor: Colors.white,
      onPressed: () async {
        final title = titleC.text.trim();
        final desc = descC.text.trim();
        final image = imageC.text.trim();

        if (title.isEmpty || desc.isEmpty) {
          Get.snackbar(
            "Peringatan",
            "Title dan Deskripsi harus diisi",
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        await Get.find<JournalController>().createJournal(
          title,
          desc,
          imageUrl: image.isEmpty ? null : image,
        );

        Get.back();
      },
      onDismissed: () {
        titleC.dispose();
        descC.dispose();
        imageC.dispose();
      },
      children: [
        const CustomText(
          text:
              "Lengkapi data untuk memastikan field baru tersimpan dengan baik.",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),

        const CustomSpacing(height: 20),

        _inputField("Masukkan Title Fields", controller: titleC),
        const CustomSpacing(height: 20),

        _inputField("Masukkan Deskripsi Fields", controller: descC),
        const CustomSpacing(height: 20),

        _inputField("Masukkan Image URL (opsional)", controller: imageC),
      ],
    );
  }

  // ================= REUSABLE MENU ITEM =================
  static Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CustomFormsection(
        border: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: PColor.primGreen.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: PColor.primGreen),
              ),

              const CustomSpacing(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const CustomSpacing(height: 2),
                    CustomText(
                      text: subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REUSABLE FIELD ITEM =================
  static Widget _fieldItem(String title, String subtitle, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: CustomFormsection(
        border: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: PColor.primGreen.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.home,
                  size: 18,
                  color: PColor.primGreen,
                ),
              ),

              const CustomSpacing(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const CustomSpacing(height: 2),
                    CustomText(
                      text: subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REUSABLE INPUT =================
  static Widget _inputField(String hint, {TextEditingController? controller}) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 1.5),
          ),
        ),

        const CustomSpacing(width: 12),

        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: PColor.primGreen, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}