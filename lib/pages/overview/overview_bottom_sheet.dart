import 'package:fl_valrn/components/widgets/custom_bottomSheet.dart';
import 'package:fl_valrn/controllers/journal_controller.dart';
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
        // const CustomText(
        //   text: "Add to MyFields",
        //   style: TextStyle(
        //     color: PColor.primGreen,
        //     fontSize: 22,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
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

  // ================= UPDATE FIELDS =================
  static void showUpdate(BuildContext context) {
    final c = Get.put(JournalController());
    CustomBottomsheet.show(
      context,
      title: "Perbarui Fields",
      initialChildSize: 0.55,
      primaryButtonText: "Pilih Fields",
      pBackgroundColor: PColor.primGreen,
      pForegroundColor: Colors.white,
      onPressed: () {},
      onDismissed: () {},
      children: [
        const CustomText(
          text:
              "Pilih field yang ingin kamu ubah agar pengelolaan lebih optimal.",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),

        const CustomSpacing(height: 16),

        Obx(() {
          if (c.isLoading.value) return CircularProgressIndicator();

          return Column(
            children: c.journals
                .map(
                  (journal) => _fieldItem(journal.title, journal.description),
                )
                .toList(),
          );
        }),
      ],
    );
  }

  // ================= CREATE FIELDS =================
  static void showCreate(BuildContext context) {
    CustomBottomsheetfix.show(
      context,
      title: "Buat Fields Baru",
      initialChildSize: 0.55,
      primaryButtonText: "Buat Fields",
      pBackgroundColor: PColor.primGreen,
      pForegroundColor: Colors.white,
      onPressed: () {},
      onDismissed: () {},
      children: [
        const CustomText(
          text:
              "Lengkapi data untuk memastikan field baru tersimpan dengan baik.",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),

        const CustomSpacing(height: 20),

        _inputField("Masukkan Title Fields"),
        const CustomSpacing(height: 20),

        _inputField("Masukkan Deskripsi Fields"),
        const CustomSpacing(height: 20),

        _inputField("Masukkan Image"),
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
  static Widget _fieldItem(String title, String subtitle) {
    return InkWell(
      onTap: () {},
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
            ],
          ),
        ),
      ),
    );
  }

  // ================= REUSABLE INPUT =================
  static Widget _inputField(String hint) {
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
