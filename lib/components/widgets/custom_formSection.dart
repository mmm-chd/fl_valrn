import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomFormsection extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color backgroundColor;
  const CustomFormsection({super.key, required this.child, this.margin, this.padding, this.height, this.backgroundColor= Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
      ),
    );
  }
}