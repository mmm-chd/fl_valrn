import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/controllers/overview_controller.dart';
import 'package:fl_valrn/overview_detail.dart';
import 'package:fl_valrn/overview_header.dart';
// import 'package:fl_valrn/pages/Overview%20Page/overview_detail.dart';
// import 'package:fl_valrn/pages/Overview%20Page/overview_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewContent extends StatelessWidget {
  const OverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OverviewController>();

    return CustomScrollView(
      slivers: [
        OverviewHeader(controller: controller),
        OverviewDetail(controller: controller),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: CustomSpacing(),
        ),
      ],
    );
  }
}
