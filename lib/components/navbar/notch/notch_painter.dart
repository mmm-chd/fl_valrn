import 'dart:math' as math;
import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
import 'package:flutter/material.dart';

class NotchPainter extends CustomPainter {
  final Color backgroundColor;
  final double notchRadius;
  final double notchSpacing;
  final double notchCornerRadius;
  final double notchVerticalOffset;
  final NotchStyle notchStyle;
  final double bottomPadding; // 🆕 Bottom padding support

  NotchPainter({
    required this.backgroundColor,
    required this.notchRadius,
    required this.notchSpacing,
    required this.notchCornerRadius,
    required this.notchStyle,
    required this.notchVerticalOffset,
    this.bottomPadding = 0.0, // Default 0
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path();
    final centerX = size.width / 2;

    // Total radius untuk notch
    final totalRadius = notchRadius + notchSpacing;

    // Titik kiri dan kanan
    final leftX = centerX - totalRadius;
    final rightX = centerX + totalRadius;

    // ✅ Adjust height untuk bottom padding
    final navbarHeight = size.height - bottomPadding;

    // Mulai dari kiri atas
    path.moveTo(0, 0);

    // Garis lurus sampai sebelum notch
    path.lineTo(leftX - notchCornerRadius, 0);

    // Kurva smooth di sudut kiri
    path.quadraticBezierTo(leftX, 0, leftX, notchCornerRadius);

    // Arc lingkaran sempurna untuk notch
    path.arcToPoint(
      Offset(rightX, notchCornerRadius),
      radius: Radius.circular(totalRadius),
      clockwise: false,
    );

    // Kurva smooth di sudut kanan
    path.quadraticBezierTo(rightX, 0, rightX + notchCornerRadius, 0);

    // Garis lurus sampai ujung kanan
    path.lineTo(size.width, 0);

    // ✅ Turun ke bottom (dengan padding)
    path.lineTo(size.width, navbarHeight);

    // ✅ Bottom padding area (solid color)
    if (bottomPadding > 0) {
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, navbarHeight);
    } else {
      path.lineTo(0, navbarHeight);
    }

    path.close();

    // Draw main path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant NotchPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.notchRadius != notchRadius ||
        oldDelegate.notchSpacing != notchSpacing ||
        oldDelegate.notchCornerRadius != notchCornerRadius ||
        oldDelegate.notchVerticalOffset != notchVerticalOffset ||
        oldDelegate.notchStyle != notchStyle ||
        oldDelegate.bottomPadding != bottomPadding;
  }
}
