import 'package:flutter/material.dart';
import '../../../../../components/widgets/custom_spacing.dart';
import '../../../../../components/widgets/custom_tabBar.dart';
import '../../../../../controllers/overview_controller.dart';

class OverviewTabbar extends StatelessWidget {
  final OverviewController controller;

  const OverviewTabbar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Center(
        child: Container(
          width: 280,
          height: 45,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffD0EAD4),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomTabbar(
                  text: 'Penyakit',
                  tabIndex: 0,
                  currentIndex: controller.currentTabIndex,
                  onTap: controller.selectTab,
                ),
              ),

              const CustomSpacing(width: 4),

              Expanded(
                child: CustomTabbar(
                  text: 'Deteksi',
                  tabIndex: 1,
                  currentIndex: controller.currentTabIndex,
                  onTap: controller.selectTab,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
