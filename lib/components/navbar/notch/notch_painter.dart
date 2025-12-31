import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
import 'package:flutter/material.dart';

class NotchPainter extends CustomPainter {
  final NotchStyle notchStyle;
  final Color backgroundColor;
  final double notchRadius;

  NotchPainter({
    required this.notchStyle,
    required this.backgroundColor,
    required this.notchRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = Path();

    // Posisi tengah
    final centerX = size.width / 2;
    final notchWidth = notchRadius * 2;

    if (notchStyle == NotchStyle.circular) {
      // Notch melingkar
      path.moveTo(0, 0);
      path.lineTo(centerX - notchWidth / 2 - 10, 0);
      
      // Kurva kiri
      path.quadraticBezierTo(
        centerX - notchWidth / 2,
        0,
        centerX - notchWidth / 2,
        10,
      );
      
      // Lengkungan atas (notch)
      path.arcToPoint(
        Offset(centerX + notchWidth / 2, 10),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
      
      // Kurva kanan
      path.quadraticBezierTo(
        centerX + notchWidth / 2,
        0,
        centerX + notchWidth / 2 + 10,
        0,
      );
      
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
    } else if (notchStyle == NotchStyle.square) {
      // Notch kotak
      path.moveTo(0, 0);
      path.lineTo(centerX - notchWidth / 2 - 10, 0);
      path.lineTo(centerX - notchWidth / 2 - 10, 20);
      path.lineTo(centerX + notchWidth / 2 + 10, 20);
      path.lineTo(centerX + notchWidth / 2 + 10, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
    }

    // Gambar shadow
    canvas.drawPath(path, shadowPaint);
    // Gambar background
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(NotchPainter oldDelegate) {
    return oldDelegate.notchStyle != notchStyle ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.notchRadius != notchRadius;
  }
}