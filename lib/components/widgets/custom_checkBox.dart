import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final double? size, borderRadius;
  final Color? activeColor, checkColor, borderColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? labelStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.size,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.labelStyle,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final checkbox = Transform.scale(
      scale: size != null ? size! / 24 : 1.0,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor ?? Theme.of(context).primaryColor,
        checkColor: checkColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
        ),
        side: borderColor != null
            ? BorderSide(color: borderColor!, width: 2.0)
            : null,
      ),
    );

    if (label == null || label!.isEmpty) {
      return Padding(padding: padding ?? EdgeInsets.zero, child: checkbox);
    }

    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            checkbox,
            Expanded(
              child: CustomText(
                text: label!,
                style:
                    labelStyle ??
                    TextStyle(fontSize: 14.0, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
