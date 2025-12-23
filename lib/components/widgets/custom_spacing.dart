import 'package:flutter/widgets.dart';

class CustomSpacing extends StatelessWidget {
  final double? height;
  final double? width;

  const CustomSpacing({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}
