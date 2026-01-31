import 'package:fl_valrn/components/widgets/custom_button.dart';
import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/overview_bottom_sheet.dart';
// import 'package:fl_valrn/pages/Overview%20Page/overview_bottom_sheet.dart';
import 'package:flutter/material.dart';

class OverviewBottomButton extends StatelessWidget {
  const OverviewBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: CustomButton(
          text: 'Save to my journal',
          backgroundColor: PColor.primGreen,
          foregroundColor: Colors.white,
          onPressed: () => OverviewBottomSheet.showAdd(context),
        ),
      ),
    );
  }
}
