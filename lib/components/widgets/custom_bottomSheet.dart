import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomsheet {
  static void show(
    BuildContext context, {
    String? title,
    RxBool? selected,
    required List<Widget> children,
    VoidCallback? onPressed,
    required VoidCallback onDismissed,
    VoidCallback? onReset,
    String? primaryButtonText,
    secondaryButtonText,
    Color? sBorderColor,
    sForegroundColor,
    sBackgroundColor,
    Color? pForegroundColor,
    pBackgroundColor,
    double? initialChildSize,
    bool? hideHeader,
  }) {
    final screen = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: initialChildSize ?? 0.65,
          minChildSize: 0.0,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),

              child: Column(
                children: [
                  // === FIXED HEADER ===
                  Column(
                    children: [
                      Container(
                        width: screen.width / 6,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      const CustomSpacing(height: 12),
                      hideHeader != null && hideHeader == true
                          ? const SizedBox.shrink()
                          : Column(
                              children: [
                                CustomText(
                                  text: title ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(height: 1, color: Colors.grey.shade300),
                  ),

                  // === SCROLLABLE CONTENT ===
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children,
                      ),
                    ),
                  ),

                  // === FIXED BUTTONS AT BOTTOM ===
                  Obx(
                    () => AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: selected != null && onPressed != null
                          ? selected.value
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      12,
                                      0,
                                      18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 10,
                                          offset: const Offset(0, -2),
                                        ),
                                      ],
                                    ),
                                    child: onReset != null
                                        ? _buildTwoButtons(
                                            context,
                                            onPressed,
                                            onReset,
                                            primaryButtonText,
                                            secondaryButtonText,
                                            sBorderColor,
                                            sForegroundColor,
                                            sBackgroundColor,
                                            pForegroundColor,
                                            pBackgroundColor,
                                          )
                                        : _buildOneButton(
                                            context,
                                            onPressed,
                                            primaryButtonText,
                                            pForegroundColor,
                                            pBackgroundColor,
                                          ),
                                  )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      // Only call onDismissed if user dismissed without pressing button
      if (value != true) {
        onDismissed();
      }
    });
  }

  // Build layout with TWO buttons
  static Widget _buildTwoButtons(
    BuildContext context,
    VoidCallback onPressed,
    VoidCallback onReset,
    String? primaryButtonText,
    secondaryButtonText,
    Color? sBorderColor,
    sForegroundColor,
    sBackgroundColor,
    Color? pForegroundColor,
    pBackgroundColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CustomButton(
            text: secondaryButtonText ?? 'Reset',
            backgroundColor: sBackgroundColor ?? Colors.white,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(36.0),
              side: BorderSide(color: sBorderColor ?? Colors.amber),
            ),
            foregroundColor: sForegroundColor ?? Colors.amber,
            onPressed: () {
              onReset();
              Get.back(result: false);
            },
          ),
        ),
        const CustomSpacing(width: 16),
        Expanded(
          child: CustomButton(
            text: primaryButtonText ?? 'Tampilkan',
            backgroundColor: pBackgroundColor ?? Colors.amber,
            foregroundColor: pForegroundColor ?? Colors.white,
            onPressed: () {
              onPressed();
              Get.back(result: true);
            },
          ),
        ),
      ],
    );
  }

  // Build layout with ONE button
  static Widget _buildOneButton(
    BuildContext context,
    VoidCallback onPressed,
    String? primaryButtonText,
    Color? pForegroundColor,
    pBackgroundColor,
  ) {
    return CustomButton(
      text: primaryButtonText ?? 'Apply',
      backgroundColor: pBackgroundColor ?? Colors.amber,
      foregroundColor: pForegroundColor ?? Colors.white,
      onPressed: () {
        onPressed();
        Get.back(result: true);
      },
    );
  }
}
