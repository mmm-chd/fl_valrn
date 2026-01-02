import 'package:flutter/material.dart';

class CustomNavbarsafepadding extends StatelessWidget {
  final Widget child;
  final double navbarHeight;

  const CustomNavbarsafepadding({
    super.key,
    required this.child,
    this.navbarHeight = 84.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: navbarHeight),
      child: child,
    );
  }
}
