import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/widgets.dart';
import 'package:tap_builder/tap_builder.dart';

/// Defines the available sizes for the PillButton widget.
enum PillButtonSize {
  /// Normal size with standard padding
  normal,

  /// Tiny size with reduced padding
  tiny,
}

class PillButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function() onTap;
  final Function()? onLongPress;
  final PillButtonSize size;

  const PillButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    this.onLongPress,
    this.size = PillButtonSize.tiny,
  });

  static const _animationDuration = Duration(milliseconds: 700);
  static const _animationCurve = Curves.fastLinearToSlowEaseIn;

  /// Returns the appropriate padding based on the button size
  EdgeInsets _getPadding(AppDesignSystem ds) {
    switch (size) {
      case PillButtonSize.normal:
        return EdgeInsets.symmetric(
          vertical: ds.spacing.s,
          horizontal: ds.spacing.l - (ds.spacing.xs / 2),
        );
      case PillButtonSize.tiny:
        return EdgeInsets.symmetric(
          vertical: ds.spacing.xs,
          horizontal: ds.spacing.l - ds.spacing.xs,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    return TapBuilder(
      onTap: onTap,
      onLongPress: onLongPress,
      builder:
          (context, tapState, isFocused) => AnimatedScale(
            scale: tapState == TapState.pressed ? .985 : 1.0,
            duration: _animationDuration,
            curve: _animationCurve,
            child: AnimatedContainer(
              duration: _animationDuration,
              curve: _animationCurve,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: ds.borderRadii.radiusFull,
              ),
              foregroundDecoration: BoxDecoration(
                color: Colors.black.withValues(
                  alpha:
                      tapState == TapState.pressed
                          ? .08
                          : tapState == TapState.hover
                          ? .05
                          : 0,
                ),
                borderRadius: ds.borderRadii.radiusFull,
              ),
              padding: _getPadding(ds),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CustomText(
                      text: label,
                      style:
                          size == PillButtonSize.normal
                              ? CustomTextStyle.bodyM
                              : CustomTextStyle.bodyS,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
