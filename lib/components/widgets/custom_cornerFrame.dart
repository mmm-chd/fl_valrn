import 'package:flutter/material.dart';

class CornerFrame extends StatelessWidget {
  final double size;
  final double cornerLength;
  final double strokeWidth;

  const CornerFrame({
    super.key,
    this.size = 260,
    this.cornerLength = 30,
    this.strokeWidth = 4,
  });

  Widget corner({
    BorderSide? top,
    BorderSide? bottom,
    BorderSide? left,
    BorderSide? right,
  }) {
    return Container(
      width: cornerLength,
      height: cornerLength,
      decoration: BoxDecoration(
        border: Border(
          top: top ?? BorderSide.none,
          bottom: bottom ?? BorderSide.none,
          left: left ?? BorderSide.none,
          right: right ?? BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            // kiri atas
            Positioned(
              top: 0,
              left: 0,
              child: corner(
                top: BorderSide(color: Colors.white, width: strokeWidth),
                left: BorderSide(color: Colors.white, width: strokeWidth),
              ),
            ),

            // kanan atas
            Positioned(
              top: 0,
              right: 0,
              child: corner(
                top: BorderSide(color: Colors.white, width: strokeWidth),
                right: BorderSide(color: Colors.white, width: strokeWidth),
              ),
            ),

            // kiri bawah
            Positioned(
              bottom: 0,
              left: 0,
              child: corner(
                bottom: BorderSide(color: Colors.white, width: strokeWidth),
                left: BorderSide(color: Colors.white, width: strokeWidth),
              ),
            ),

            // kanan bawah
            Positioned(
              bottom: 0,
              right: 0,
              child: corner(
                bottom: BorderSide(color: Colors.white, width: strokeWidth),
                right: BorderSide(color: Colors.white, width: strokeWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }
}