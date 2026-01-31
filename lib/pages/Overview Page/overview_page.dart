import 'package:fl_valrn/pages/Overview%20Page/overview_bottom_button.dart';
import 'package:fl_valrn/pages/Overview%20Page/overview_content.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const OverviewContent(),
      bottomNavigationBar: const OverviewBottomButton(),
    );
  }
}
