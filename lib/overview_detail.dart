import 'dart:io';
import 'package:fl_valrn/components/widgets/custom_detection_tab.dart';
import 'package:fl_valrn/components/widgets/custom_disease_tab.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:fl_valrn/pages/overview/overview_tab_bar.dart';
// import 'package:fl_valrn/pages/Overview%20Page/overview_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewDetail extends StatelessWidget {
  final OverviewController controller;

  const OverviewDetail({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            _buildTitle(),
            const Divider(),
            OverviewTabbar(controller: controller),
            Obx(() => controller.currentTabIndex.value == 0
                ? DiseaseTab(controller: controller)
                : DetectionTab(controller: controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => CustomText(
                text: controller.plantName.value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const CustomSpacing(height: 4),
          Obx(() => CustomText(
                text: controller.scientificName.value,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: PColor.primGreen,
                ),
              )),
        ],
      ),
    );
  }
  
}
