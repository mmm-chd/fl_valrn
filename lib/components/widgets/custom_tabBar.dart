import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CustomTabbar extends StatelessWidget {
  final String text;
  final Color? textColor;
  final RxInt currentIndex;
  final int tabIndex;
  final Function(int) onTap;

  const CustomTabbar({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    required this.currentIndex,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(tabIndex),
      child: Obx(
        () => Container(
          width: 170,
          height: 45,
          margin: EdgeInsets.only(bottom: 0),
          padding: EdgeInsets.all(0),
          decoration: currentIndex.value == tabIndex
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(34),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                )
              : BoxDecoration(),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentIndex.value == tabIndex
                      ? textColor ?? Colors.black
                      : Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
