import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'custom_spacing.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final Widget child;
  final double spacing;

  const InfoSection({
    super.key,
    required this.title,
    required this.child,
    this.spacing = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
          ),
        ),
        const CustomSpacing(height: 12),
        child,
        CustomSpacing(height: spacing),
      ],
    );
  }
}
