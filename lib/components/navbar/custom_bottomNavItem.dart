import 'package:flutter/material.dart';

/// Model untuk item bottom navigation
class CustomBottomnavitem {
  final IconData icon;
  final String label;
  final bool hasIndicator;
  final Widget? customIcon;

  CustomBottomnavitem({
    required this.icon,
    required this.label,
    this.hasIndicator = false,
    this.customIcon,
  });
}