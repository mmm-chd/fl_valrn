import 'package:fl_valrn/components/widgets/custom_spacing.dart';
import 'package:fl_valrn/components/widgets/custom_text.dart';
import 'package:flutter/widgets.dart';

class InfoRow extends StatelessWidget {
  final String leftText;
  final String rightText;

  const InfoRow({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              text: leftText,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff333333),
              ),
            ),
          ),
          if (rightText.isNotEmpty) ...[
            const CustomSpacing(width: 16),
            Expanded(
              child: CustomText(
                text: rightText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff333333),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}