import 'package:fl_valrn/components/navbar/custom_bottomNavItem.dart';
import 'package:fl_valrn/components/navbar/notch/notch_painter.dart';
import 'package:fl_valrn/components/navbar/notch/notch_style.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  /// Index item yang sedang dipilih
  final int currentIndex;

  /// Callback ketika item di-tap
  final Function(int) onTap;

  /// List item navigasi
  final List<CustomBottomnavitem> items;

  /// Index item yang akan dijadikan floating button (null jika tidak ada)
  final int? centerItemIndex;

  /// Tinggi bottom bar
  final double height;

  /// Warna background
  final Color backgroundColor;

  /// Warna item yang dipilih
  final Color selectedColor;

  /// Warna item yang tidak dipilih
  final Color unselectedColor;

  /// Warna floating button
  final Color floatingButtonColor;

  /// Ukuran floating button
  final double floatingButtonSize;

  /// Ukuran ikon
  final double iconSize;

  /// Tampilkan label atau tidak
  final bool showLabels;

  /// Tampilkan indicator dot atau tidak
  final bool showIndicatorDot;

  /// Style notch untuk floating button
  final NotchStyle notchStyle;

  /// Aktifkan animasi atau tidak
  final bool enableAnimation;

  /// Durasi animasi
  final Duration animationDuration;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.centerItemIndex,
    this.height = 80,
    this.backgroundColor = Colors.white,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.floatingButtonColor = Colors.blue,
    this.floatingButtonSize = 70,
    this.iconSize = 28,
    this.showLabels = false,
    this.showIndicatorDot = true,
    this.notchStyle = NotchStyle.circular,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    // Jika ada notch, gunakan custom shape
    if (centerItemIndex != null && notchStyle != NotchStyle.none) {
      return _buildWithNotch(context);
    }

    return _buildWithoutNotch(context);
  }

  Widget _buildWithNotch(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background dengan notch
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, height),
            painter: NotchPainter(
              notchStyle: notchStyle,
              backgroundColor: backgroundColor,
              notchRadius: floatingButtonSize / 2 + 10,
            ),
          ),
          // Bottom navigation items
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildNavItems(context),
            ),
          ),
          // Floating button
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
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildNavItems(context),
          ),
          if (centerItemIndex != null) _buildFloatingButton(context),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    List<Widget> navItems = [];

    for (int i = 0; i < items.length; i++) {
      // Skip atau tambah space untuk floating button
      if (centerItemIndex != null && i == centerItemIndex) {
        if (notchStyle == NotchStyle.none) {
          navItems.add(SizedBox(width: floatingButtonSize));
        } else {
          navItems.add(SizedBox(width: floatingButtonSize + 20));
        }
        continue;
      }

      navItems.add(_buildNavItem(items[i], i));
    }

    return navItems;
  }

  Widget _buildNavItem(CustomBottomnavitem item, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: enableAnimation ? animationDuration : Duration.zero,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    right: -8,
                    top: -4,
                    child: AnimatedScale(
                      scale: isSelected && enableAnimation ? 1.2 : 1.0,
                      duration: animationDuration,
                      child: Container(
                        width: 12,
                        height: 12,
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
                  fontSize: 12,
                  color: isSelected ? selectedColor : unselectedColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                child: Text(item.label),
              ),
            ] else if (showIndicatorDot) ...[
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: enableAnimation ? animationDuration : Duration.zero,
                width: isSelected ? 6 : 0,
                height: isSelected ? 6 : 0,
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
          ? -(floatingButtonSize / 2) + 10
          : -(floatingButtonSize / 2) + 15,
      child: GestureDetector(
        onTap: () => onTap(centerItemIndex!),
        child: AnimatedScale(
          scale: isSelected && enableAnimation ? 1.15 : 1.0,
          duration: animationDuration,
          child: AnimatedContainer(
            duration: enableAnimation ? animationDuration : Duration.zero,
            width: floatingButtonSize,
            height: floatingButtonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: floatingButtonColor,
              boxShadow: [
                BoxShadow(
                  color: floatingButtonColor.withValues(alpha: 0.3),
                  blurRadius: isSelected ? 20 : 15,
                  spreadRadius: isSelected ? 3 : 2,
                ),
              ],
            ),
            child: AnimatedRotation(
              turns: isSelected && enableAnimation ? 0.125 : 0,
              duration: animationDuration,
              child:
                  item.customIcon ??
                  Icon(item.icon, color: Colors.white, size: iconSize + 7),
            ),
          ),
        ),
      ),
    );
  }
}
