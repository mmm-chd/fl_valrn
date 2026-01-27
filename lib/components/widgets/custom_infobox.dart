import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final Widget child;

  const InfoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xff5B5B5B), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
