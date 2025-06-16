import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';
import 'package:saturne_pro_core/src/widgets/indicators/indicators.dart';

/// Data class representing an item in the bottom navigation bar.
class BottomNavBarItemData {
  /// The label text to display below the icon
  final String label;

  /// The icon to display
  final IconData icon;

  /// Whether this item is currently selected
  final bool isSelected;

  /// Callback function when this item is tapped
  final VoidCallback onTap;

  const BottomNavBarItemData({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
}

/// A custom bottom navigation bar widget that displays a row of items with icons and labels.
class CustomBottomNavBar extends StatelessWidget {
  /// The list of items to display in the navigation bar
  final List<BottomNavBarItemData> items;

  const CustomBottomNavBar({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Container(
      width: 100.dw,
      padding: EdgeInsets.only(
        bottom: ds.spacing.xl,
        right: ds.spacing.s,
        left: ds.spacing.s,
      ),
      color: ds.colors.primary.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            BottomNavBarItemWidget(
              item: items[i],
              width: (100.dw - 2 * ds.spacing.s) / items.length,
            ),
          ],
        ],
      ),
    );
  }
}

/// A widget representing a single item in the bottom navigation bar.
class BottomNavBarItemWidget extends StatelessWidget {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _animationCurve = Curves.fastLinearToSlowEaseIn;
  static const _selectedOpacity = 1.0;
  static const _unselectedOpacity = 0.6;
  static const _indicatorWidthFactor = 0.9;
  static const _iconSizeFactor = 0.75;
  static const _topPaddingFactor = 0.8;

  /// The data for this navigation item
  final BottomNavBarItemData item;

  /// The width allocated for this item
  final double width;

  const BottomNavBarItemWidget({
    super.key,
    required this.item,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return CustomTooltip(
      message: item.label,
      preferBelow: false,
      verticalOffset: 1.5 * ds.spacing.l,
      child: GestureDetector(
        onTap: item.onTap,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: ds.spacing.xs,
            children: [
              AnimatedContainer(
                duration: _animationDuration,
                curve: _animationCurve,
                height: .7 * ds.spacing.xs,
                width: item.isSelected ? _indicatorWidthFactor * width : 0,
                decoration: BoxDecoration(
                  color: ds.colors.primary.shade500,
                  borderRadius: ds.borderRadii.radiusFull,
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.only(top: _topPaddingFactor * ds.spacing.l),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: ds.spacing.xs,
                  children: [
                    Icon(
                      item.icon,
                      size: _iconSizeFactor * ds.spacing.xl,
                      color: ds.colors.primary.shade500.withValues(
                        alpha:
                            item.isSelected
                                ? _selectedOpacity
                                : _unselectedOpacity,
                      ),
                    ),
                    CustomText(
                      text: item.label,
                      style: CustomTextStyle.captionM,
                      color: ds.colors.primary.shade500.withValues(
                        alpha:
                            item.isSelected
                                ? _selectedOpacity
                                : _unselectedOpacity,
                      ),
                      fontWeight:
                          item.isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
