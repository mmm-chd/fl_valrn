import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_bulletlist.dart';
import 'package:fl_valrn/components/widgets/custom_rowtext.dart';
import 'package:fl_valrn/components/widgets/custom_infobox.dart';
import 'package:fl_valrn/components/widgets/custom_info_section.dart';

class DetectionTab extends StatelessWidget {
  final OverviewController controller;

  const DetectionTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoBox(
            child: Obx(
              () => Column(
                children: controller.nutritionData.entries
                    .map(
                      (e) =>
                          InfoRow(leftText: e.key, rightText: e.value),
                    )
                    .toList(),
              ),
            ),
          ),
          const CustomSpacing(height: 20),

          InfoBox(
            child: Obx(
              () => CustomText(
                text: controller.descriptionText.value,
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
            () => InfoSection(
              title: controller.habitatTitle.value,
              child: InfoBox(
                child: CustomText(
                  text: controller.habitatText.value,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),

          InfoSection(
            title: 'Keunggulan Tanaman',
            child: InfoBox(
              child: Column(
                children: controller.advantages
                    .map((e) => BulletListItem(text: e))
                    .toList(),
              ),
            ),
          ),

          InfoSection(
            title: 'Kekurangan Tanaman',
            child: InfoBox(
              child: Column(
                children: controller.disadvantages
                    .map((e) => BulletListItem(text: e))
                    .toList(),
              ),
            ),
          ),

          InfoSection(
            title: 'Cara Perawatan',
            child: InfoBox(
              child: Column(
                children: controller.cultivation
                    .map((e) => BulletListItem(text: e))
                    .toList(),
              ),
            ),
          ),

          InfoSection(
            title: 'Informasi Tambahan',
            spacing: 40,
            child: InfoBox(
              child: Obx(
                () => CustomText(
                  text: controller.funFact.value,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
