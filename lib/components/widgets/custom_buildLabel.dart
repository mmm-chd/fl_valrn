import 'package:fl_valrn/configs/themes_color.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';

class FormLabel extends StatelessWidget {
  final String label;

  const FormLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: PColor.primGreen,
      ),
    );
  }
}
