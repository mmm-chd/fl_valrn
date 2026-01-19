import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialbutton extends StatelessWidget {
  final String type;
  final VoidCallback onTap;
  const CustomSocialbutton({
    super.key,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: SvgPicture.asset(
            'assets/icons/socialIcons/${type}_icon.svg',
            width: 44,
            height: 44,
          ),
        ),
      ),
    );
  }
}
