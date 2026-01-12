import 'package:fl_valrn/components/widgets/custom_info_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_bulletlist.dart';
import 'package:fl_valrn/components/widgets/custom_section_title.dart';
import 'package:fl_valrn/components/widgets/custom_infobox.dart';
class DiseaseTab extends StatelessWidget {
  final OverviewController controller;

  const DiseaseTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final isHealthy = controller.isHealthy.value;
            return SectionTitle(
              title: isHealthy
                  ? controller.diseaseTitle.value
                  : 'Tanaman Kamu Terkena Penyakit!\n${controller.diseaseTitle.value}',
              color: isHealthy
                  ? const Color(0xffE8F5E9)
                  : const Color(0xffFFF3E0),
            );
          }),
          const CustomSpacing(height: 20),

          Obx(
            () => CustomText(
              text: controller.isHealthy.value
                  ? 'Penjelasan Singkat'
                  : 'Penjelasan Penyakit',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xff333333),
              ),
            ),
          ),
          const CustomSpacing(height: 12),

          InfoBox(
            child: Obx(
              () => CustomText(
                text: controller.diseaseDescription.value,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xff666666),
                  height: 1.6,
                ),
              ),
            ),
          ),
          const CustomSpacing(height: 24),

          Obx(
            () => controller.symptoms.isEmpty
                ? const SizedBox.shrink()
                : InfoSection(
                    title: 'Gejala',
                    child: InfoBox(
                      child: Column(
                        children: controller.symptoms
                            .map((e) => BulletListItem(text: e))
                            .toList(),
                      ),
                    ),
                  ),
          ),

          Obx(
            () => controller.causes.isEmpty
                ? const SizedBox.shrink()
                : InfoSection(
                    title: 'Penyebab',
                    child: InfoBox(
                      child: Column(
                        children: controller.causes
                            .map((e) => BulletListItem(text: e))
                            .toList(),
                      ),
                    ),
                  ),
          ),

          Obx(
            () => controller.impact.isEmpty
                ? const SizedBox.shrink()
                : InfoSection(
                    title: 'Dampak',
                    child: InfoBox(
                      child: Column(
                        children: controller.impact
                            .map((e) => BulletListItem(text: e))
                            .toList(),
                      ),
                    ),
                  ),
          ),

          Obx(
            () => controller.isHealthy.value
                ? const SizedBox.shrink()
                : InfoSection(
                    title: 'Penanganan',
                    spacing: 40,
                    child: InfoBox(
                      child: Column(
                        children: controller.prevention
                            .map((e) => BulletListItem(text: e))
                            .toList(),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
