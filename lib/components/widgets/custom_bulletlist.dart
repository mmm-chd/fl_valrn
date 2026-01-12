import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/widgets.dart';

class BulletListItem extends StatelessWidget {
  final String text;
  final Color? bulletColor;

  const BulletListItem({
    super.key,
    required this.text,
    this.bulletColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: bulletColor ?? const Color(0xff52A068),
              shape: BoxShape.circle,
            ),
          ),
          const CustomSpacing(width: 10),
          Expanded(
            child: CustomText(
              text: text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff333333),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}