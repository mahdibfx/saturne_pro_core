import 'package:flutter/widgets.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

class FilterPill extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSelected;
  final double? iconSize;

  FilterPill.label({
    super.key,
    required this.label,
    this.onTap,
    this.isSelected = false,
  }) : icon = null,
       iconSize = null {
    assert(label.isNotEmpty, 'Label cannot be empty for FilterPill.label');
  }

  FilterPill.icon({
    super.key,
    required this.icon,
    this.onTap,
    this.isSelected = false,
    this.iconSize,
  }) : label = '' {
    assert(icon != null, 'Icon cannot be null for FilterPill.icon');
    assert(
      iconSize == null || iconSize! > 0,
      'Icon size must be positive if provided',
    );
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 5.8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 5.8.h,
          width: icon != null && label.isEmpty ? 5.8.h : null,
          padding:
              icon != null
                  ? null
                  : EdgeInsets.symmetric(horizontal: 1.5 * ds.spacing.l),
          decoration: BoxDecoration(
            color: ds.colors.primary.shade50,
            borderRadius: ds.borderRadii.radiusFull,
            border:
                isSelected
                    ? Border.all(color: ds.colors.secondary.shade500, width: .8)
                    : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: ds.spacing.s,
            children: [
              if (label.isNotEmpty)
                CustomText(
                  text: label,
                  style: CustomTextStyle.bodyL,
                  color: ds.colors.primary.shade500,
                  fontWeight: FontWeight.w500,
                ),
              Icon(
                icon ?? SaturneProIcons.angleDown,
                size: iconSize ?? 2.84.h,
                color: ds.colors.primary.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
