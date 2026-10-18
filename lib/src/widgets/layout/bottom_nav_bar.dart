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

  /// Shown instead of [icon] when selected (Tellot glass icons).
  final Widget? selectedIcon;

  const BottomNavBarItemData({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.selectedIcon,
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
        top: ds.spacing.s,
        bottom: ds.spacing.l,
        right: ds.spacing.s,
        left: ds.spacing.s,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xffEDEDED))),
      ),
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
              Container(
                width: width,
                padding: EdgeInsets.only(top: 1.5 * ds.spacing.xs),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: ds.spacing.xs,
                  children: [
                    if (item.isSelected && item.selectedIcon != null)
                      SizedBox.square(
                        dimension: 6 * ds.spacing.xs,
                        child: item.selectedIcon,
                      )
                    else
                      Icon(
                        item.icon,
                        size: 6 * ds.spacing.xs,
                        color:
                            item.isSelected
                                ? ds.colors.primary.shade500
                                : ds.colors.shade.shade400,
                      ),
                    // Long labels ("Télétransmission") shrink instead of
                    // ellipsing in a fifth of the screen.
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomText(
                        text: item.label,
                        fontSize: 10,
                        maxLines: 1,
                        color:
                            item.isSelected
                                ? ds.colors.primary.shade500
                                : ds.colors.shade.shade400,
                        fontWeight:
                            item.isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
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
