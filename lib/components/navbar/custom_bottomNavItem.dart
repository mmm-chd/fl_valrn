import 'package:flutter/material.dart';

/// Model untuk item bottom navigation
class CustomBottomnavitem {
  final IconData? icon;
  final String label;
  final bool hasIndicator;
  final Widget Function(double size)? customIconSelectedBuilder;
  final Widget Function(double size)? customIconUnselectedBuilder;
  final Widget? customIconSelected;
  final Widget? customIconUnselected;

  CustomBottomnavitem({
    this.icon,
    required this.label,
    this.hasIndicator = false,
    this.customIconSelectedBuilder,
    this.customIconUnselectedBuilder,
    this.customIconSelected,
    this.customIconUnselected,
  });
}
