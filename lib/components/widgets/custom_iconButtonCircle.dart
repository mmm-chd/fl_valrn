import 'package:flutter/material.dart';

class CustomIconbuttonCircle extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? iconColor, splashColor;
  final double splashRadius, iconSize;
  final String? tooltip;

  const CustomIconbuttonCircle({
    super.key,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.splashColor,
    this.splashRadius = 22.5,
    this.iconSize = 26,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(shape: CircleBorder()),
      tooltip: tooltip,
      iconSize: iconSize,
      icon: Icon(icon, color: iconColor),
      splashColor: splashColor,
      splashRadius: splashRadius,
    );
  }
}
