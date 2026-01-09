import 'package:flutter/material.dart';

class CornerFrame extends StatelessWidget {
  final double size;
  final double cornerLength;
  final double strokeWidth;
  final double radius;

  const CornerFrame({
    super.key,
    this.size = 260,
    this.cornerLength = 32,
    this.strokeWidth = 4,
    this.radius = 10,
  });

  Widget corner({
    BorderSide? top,
    BorderSide? bottom,
    BorderSide? left,
    BorderSide? right,
    BorderRadius? borderRadius,
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
        borderRadius: borderRadius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
              ),
            ),
          ),

          // kanan atas
          Positioned(
            top: 0,
            right: 0,
            child: corner(
              top: BorderSide(color: Colors.white, width: strokeWidth),
              right: BorderSide(color: Colors.white, width: strokeWidth),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(radius),
              ),
            ),
          ),

          // kiri bawah
          Positioned(
            bottom: 0,
            left: 0,
            child: corner(
              bottom: BorderSide(color: Colors.white, width: strokeWidth),
              left: BorderSide(color: Colors.white, width: strokeWidth),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
              ),
            ),
          ),

          // kanan bawah
          Positioned(
            bottom: 0,
            right: 0,
            child: corner(
              bottom: BorderSide(color: Colors.white, width: strokeWidth),
              right: BorderSide(color: Colors.white, width: strokeWidth),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(radius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}