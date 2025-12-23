import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CustomTabbar extends StatelessWidget {
  final String text;
  final Color? textColor;
  final RxInt currentIndex;
  final int tabIndex;
  final Function(int) onTap;

  const CustomTabbar({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    required this.currentIndex,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(34),
        onTap: () => onTap(tabIndex),
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: 45,
            decoration: currentIndex.value == tabIndex
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(34),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  )
                : BoxDecoration(borderRadius: BorderRadius.circular(34)),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: currentIndex.value == tabIndex
                    ? textColor ?? Colors.black
                    : Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
