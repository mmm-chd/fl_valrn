import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomIconbutton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final String text;
  final Color? iconColor, foregroundColor, backgroundColor, splashColor;
  final Color borderColor;
  final double borderWidth, spacing;
  final FontWeight? fontWeight;
  final bool useBorder;

  const CustomIconbutton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
    this.iconColor,
    this.foregroundColor,
    this.backgroundColor,
    this.splashColor,
    this.fontWeight,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.spacing = 8,
    this.useBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: useBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor),
              CustomSpacing(width: spacing),
              CustomText(
                text: text,
                style: TextStyle(
                  fontSize: 18,
                  color: foregroundColor,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
