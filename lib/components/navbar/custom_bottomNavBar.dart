import 'package:fl_valrn/components/navbar/custom_bottomNavItem.dart';
import 'package:fl_valrn/components/navbar/notch/notch_painter.dart';
import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<CustomBottomnavitem> items;
  final int? centerItemIndex;
  final double? height;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color floatingButtonColor;
  final double? floatingButtonSize;
  final double? iconSize;
  final double? floatingButtonIconSize;
  final double? textSize;
  final bool showLabels;
  final bool showIndicatorDot;
  final NotchStyle notchStyle;
  final bool enableAnimation;
  final Duration animationDuration;
  final double? floatingButtonHeight;
  final double? notchSpacing;
  final double? notchRadius;
  final double? notchCornerRadius;
  final double? bottomPadding;
  final bool useSystemBottomPadding;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.centerItemIndex,
    this.height,
    this.backgroundColor = Colors.white,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.floatingButtonColor = Colors.blue,
    this.floatingButtonSize,
    this.iconSize,
    this.floatingButtonIconSize,
    this.showLabels = false,
    this.showIndicatorDot = true,
    this.notchStyle = NotchStyle.circular,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.floatingButtonHeight,
    this.notchSpacing,
    this.notchRadius,
    this.notchCornerRadius,
    this.textSize,
    this.bottomPadding,
    this.useSystemBottomPadding = true,
  });

  _ResponsiveSizes _calculateSizes(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = screenWidth.clamp(320.0, 428.0);
    final scaleFactor = ((constrainedWidth - 320) / 108 * 0.2 + 0.8).clamp(
      0.8,
      1.0,
    );

    final systemBottomPadding = useSystemBottomPadding
        ? MediaQuery.of(context).padding.bottom
        : 0.0;
    final finalBottomPadding = bottomPadding ?? systemBottomPadding;

    return _ResponsiveSizes(
      height: height ?? (60 + (scaleFactor - 0.8) * 25).clamp(60, 70),
      buttonSize:
          floatingButtonSize ?? (52 + (scaleFactor - 0.8) * 20).clamp(52, 64),
      iconSize: iconSize ?? (22 + (scaleFactor - 0.8) * 6).clamp(22, 26),
      textSize: textSize ?? (10 + (scaleFactor - 0.8) * 2).clamp(10, 12),
      spacing: notchSpacing ?? (6 + (scaleFactor - 0.8) * 4).clamp(6, 8),
      cornerRadius:
          notchCornerRadius ?? (18 + (scaleFactor - 0.8) * 8).clamp(18, 24),
      buttonHeight:
          floatingButtonHeight ?? (-5 + (scaleFactor - 0.8) * 2).clamp(-5, -3),
      bottomPadding: finalBottomPadding,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (centerItemIndex != null && notchStyle != NotchStyle.none) {
      return _buildWithNotch(context);
    }
    return _buildWithoutNotch(context);
  }

  Widget _buildWithNotch(BuildContext context) {
    final sizes = _calculateSizes(context);
    final calculatedNotchRadius =
        notchRadius ?? (sizes.buttonSize / 2 + sizes.spacing);
    final totalHeight = sizes.height + sizes.bottomPadding;

    return Container(
      height: totalHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, totalHeight),
            painter: NotchPainter(
              notchStyle: notchStyle,
              backgroundColor: backgroundColor,
              notchRadius: calculatedNotchRadius,
              notchSpacing: sizes.spacing,
              notchCornerRadius: sizes.cornerRadius,
              notchVerticalOffset: sizes.buttonHeight,
              bottomPadding: sizes.bottomPadding,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: sizes.bottomPadding,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(children: _buildNavItems(context, sizes)),
            ),
          ),

          if (centerItemIndex != null) _buildFloatingButton(context, sizes),
        ],
      ),
    );
  }

  Widget _buildWithoutNotch(BuildContext context) {
    final sizes = _calculateSizes(context);
    final totalHeight = sizes.height + sizes.bottomPadding;

    return Container(
      height: totalHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: sizes.bottomPadding,
            child: Row(children: _buildNavItems(context, sizes)),
          ),
          if (centerItemIndex != null) _buildFloatingButton(context, sizes),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context, _ResponsiveSizes sizes) {
    List<Widget> navItems = [];

    for (int i = 0; i < items.length; i++) {
      if (centerItemIndex != null && i == centerItemIndex) {
        navItems.add(Expanded(child: SizedBox.shrink()));
        continue;
      }

      navItems.add(Expanded(child: _buildNavItem(items[i], i, sizes)));
    }

    return navItems;
  }

  Widget _buildNavItem(
    CustomBottomnavitem item,
    int index,
    _ResponsiveSizes sizes,
  ) {
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
                  child: _buildIcon(item, isSelected, sizes),
                ),
                if (item.hasIndicator)
                  Positioned(
                    right: -6,
                    top: -3,
                    child: AnimatedScale(
                      scale: isSelected && enableAnimation ? 1.2 : 1.0,
                      duration: animationDuration,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedColor,
                          border: Border.all(
                            color: backgroundColor,
                            width: 1.5,
                          ),
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
                  fontSize: sizes.textSize,
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
                width: isSelected ? 4 : 0,
                height: isSelected ? 4 : 0,
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

  Widget _buildIcon(
    CustomBottomnavitem item,
    bool isSelected,
    _ResponsiveSizes sizes,
  ) {
    // Prioritize builders for proper sizing
    if (isSelected && item.customIconSelectedBuilder != null) {
      return item.customIconSelectedBuilder!(sizes.iconSize);
    }
    if (!isSelected && item.customIconUnselectedBuilder != null) {
      return item.customIconUnselectedBuilder!(sizes.iconSize);
    }

    // Fallback to deprecated direct widgets
    if (isSelected && item.customIconSelected != null) {
      return item.customIconSelected!;
    }
    if (!isSelected && item.customIconUnselected != null) {
      return item.customIconUnselected!;
    }

    // Final fallback to icon
    return Icon(
      item.icon,
      color: isSelected ? selectedColor : unselectedColor,
      size: sizes.iconSize,
    );
  }

  Widget _buildFloatingButton(BuildContext context, _ResponsiveSizes sizes) {
    if (centerItemIndex == null) return const SizedBox.shrink();

    final item = items[centerItemIndex!];
    final screenWidth = MediaQuery.of(context).size.width;
    final isSelected = currentIndex == centerItemIndex;

    final floatingIconSize =
        floatingButtonIconSize ?? iconSize ?? (sizes.iconSize + 4);

    return Positioned(
      left: screenWidth / 2 - (sizes.buttonSize / 2),
      top: notchStyle != NotchStyle.none
          ? -(sizes.buttonSize / 2) + sizes.buttonHeight
          : -(sizes.buttonSize / 2) + 15,
      child: GestureDetector(
        onTap: () => onTap(centerItemIndex!),
        child: Container(
          width: sizes.buttonSize,
          height: sizes.buttonSize,
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
          child: _buildFloatingIcon(item, isSelected, floatingIconSize),
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(
    CustomBottomnavitem item,
    bool isSelected,
    double size,
  ) {
    Widget icon;

    if (isSelected && item.customIconSelectedBuilder != null) {
      icon = item.customIconSelectedBuilder!(size);
    } else if (!isSelected && item.customIconUnselectedBuilder != null) {
      icon = item.customIconUnselectedBuilder!(size);
    } else {
      icon = Icon(item.icon, color: Colors.white, size: size);
    }

    return SizedBox(
      width: size,
      height: size,
      child: Center(child: icon),
    );
  }
}

class _ResponsiveSizes {
  final double height;
  final double buttonSize;
  final double iconSize;
  final double textSize;
  final double spacing;
  final double cornerRadius;
  final double buttonHeight;
  final double bottomPadding;

  _ResponsiveSizes({
    required this.height,
    required this.buttonSize,
    required this.iconSize,
    required this.textSize,
    required this.spacing,
    required this.cornerRadius,
    required this.buttonHeight,
    required this.bottomPadding,
  });
}
