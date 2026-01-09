import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/widgets.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Color? color;

  const SectionTitle({
    super.key,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color ?? const Color(0xffFFF3E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomText(
        text: title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff333333),
        ),
      ),
    );
  }
}