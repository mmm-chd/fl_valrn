import 'package:fl_valrn/configs/themes_color.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CustomTabbar extends StatelessWidget {
  final String text;
  final RxInt currentIndex;
  final int tabIndex;
  final Function(int) onTap;

  const CustomTabbar({
    super.key,
    required this.text,
    required this.currentIndex,
    required this.tabIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isActive = currentIndex.value == tabIndex;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => onTap(tabIndex),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? PColor.primGreen : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      );
    });
  }
}
