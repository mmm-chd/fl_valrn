import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'custom_spacing.dart';

class SectionHeader extends StatelessWidget {
  final String text;

  const SectionHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
          ),
        ),
        const CustomSpacing(height: 12),
      ],
    );
  }
}
