import 'package:fl_valrn/components/navbar/custom_bottomNavItem.dart';
import 'package:fl_valrn/components/navbar/notch/notch_painter.dart';
import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<CustomBottomnavitem> items;
  final int? centerItemIndex;
  final double height;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color floatingButtonColor;
  final double floatingButtonSize;
  final double iconSize;
  final double textSize;
  final bool showLabels;
  final bool showIndicatorDot;
  final NotchStyle notchStyle;
  final bool enableAnimation;
  final Duration animationDuration;
  final double floatingButtonHeight;
  final double notchSpacing;
  final double? notchRadius;
  final double notchCornerRadius;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.centerItemIndex,
    this.height = 65,
    this.backgroundColor = Colors.white,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.floatingButtonColor = Colors.blue,
    this.floatingButtonSize = 58,
    this.iconSize = 24,
    this.showLabels = false,
    this.showIndicatorDot = true,
    this.notchStyle = NotchStyle.circular,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.floatingButtonHeight = -4,
    this.notchSpacing = 8,
    this.notchRadius,
    this.notchCornerRadius = 22,
    this.textSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    if (centerItemIndex != null && notchStyle != NotchStyle.none) {
      return _buildWithNotch(context);
    }
    return _buildWithoutNotch(context);
  }

  Widget _buildWithNotch(BuildContext context) {
    final calculatedNotchRadius =
        notchRadius ?? (floatingButtonSize / 2 + notchSpacing);

    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, height),
            painter: NotchPainter(
              notchStyle: notchStyle,
              backgroundColor: backgroundColor,
              notchRadius: calculatedNotchRadius,
              notchSpacing: notchSpacing,
              notchCornerRadius: notchCornerRadius,
              notchVerticalOffset: floatingButtonHeight,
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(children: _buildNavItems(context)),
            ),
          ),

          if (centerItemIndex != null) _buildFloatingButton(context),
        ],
      ),
    );
  }

  Widget _buildWithoutNotch(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(children: _buildNavItems(context)),
          if (centerItemIndex != null) _buildFloatingButton(context),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    List<Widget> navItems = [];

    for (int i = 0; i < items.length; i++) {
      if (centerItemIndex != null && i == centerItemIndex) {
        navItems.add(Expanded(child: SizedBox.shrink()));
        continue;
      }

      navItems.add(Expanded(child: _buildNavItem(items[i], i)));
    }

    return navItems;
  }

  Widget _buildNavItem(CustomBottomnavitem item, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: enableAnimation ? animationDuration : Duration.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedScale(
                  scale: isSelected && enableAnimation ? 1.1 : 1.0,
                  duration: animationDuration,
                  child:
                      item.customIcon ??
                      Icon(
                        item.icon,
                        color: isSelected ? selectedColor : unselectedColor,
                        size: iconSize,
                      ),
                ),
                if (item.hasIndicator)
                  Positioned(
                    right: -6,
                    top: -3,
                    child: AnimatedScale(
                      scale: isSelected && enableAnimation ? 1.2 : 1.0,
                      duration: animationDuration,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedColor,
                          border: Border.all(color: backgroundColor, width: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (showLabels) ...[
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: enableAnimation ? animationDuration : Duration.zero,
                style: TextStyle(
                  fontSize: textSize,
                  color: isSelected ? selectedColor : unselectedColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                child: Text(
                  item.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ] else if (showIndicatorDot) ...[
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: enableAnimation ? animationDuration : Duration.zero,
                width: isSelected ? 5 : 0,
                height: isSelected ? 5 : 0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    if (centerItemIndex == null) return const SizedBox.shrink();

    final item = items[centerItemIndex!];
    final screenWidth = MediaQuery.of(context).size.width;
    final isSelected = currentIndex == centerItemIndex;

    return Positioned(
      left: screenWidth / 2 - (floatingButtonSize / 2),
      top: notchStyle != NotchStyle.none
          ? -(floatingButtonSize / 2) + floatingButtonHeight
          : -(floatingButtonSize / 2) + 15,
      child: GestureDetector(
        onTap: () => onTap(centerItemIndex!),
        child: AnimatedScale(
          scale: isSelected && enableAnimation ? 1.08 : 1.0,
          duration: animationDuration,
          child: Container(
            width: floatingButtonSize,
            height: floatingButtonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: floatingButtonColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedRotation(
              turns: isSelected && enableAnimation ? 0.125 : 0,
              duration: animationDuration,
              child:
                  item.customIcon ??
                  Icon(item.icon, color: Colors.white, size: iconSize + 4),
            ),
          ),
        ),
      ),
    );
  }
}
