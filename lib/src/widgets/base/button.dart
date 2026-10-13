import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/widgets.dart';
import 'package:tap_builder/tap_builder.dart';

import '../../design system/design_system.dart';

enum ButtonType { filled, outlined, plain }

class Button extends StatelessWidget {
  final ButtonType type;
  final String label;
  final Gradient? backgroundColor;
  final Color? labelColor;
  final bool expand;
  final bool isDisabled;
  final Function() onTap;
  final Function()? onLongPress;

  const Button.filled({
    super.key,
    this.type = ButtonType.filled,
    required this.label,
    required this.backgroundColor,
    required this.labelColor,
    this.expand = true,
    required this.onTap,
    this.isDisabled = false,
    this.onLongPress,
  }) : assert(
         backgroundColor != null,
         'Filled button requires a background gradient',
       ),
       assert(labelColor != null, 'Filled button requires a label color'),
       assert(
         type == ButtonType.filled,
         'CustomButton.filled constructor must be used with ButtonType.filled',
       );

  const Button.outlined({
    super.key,
    this.type = ButtonType.outlined,
    required this.label,
    this.backgroundColor,
    required this.labelColor,
    this.expand = true,
    required this.onTap,
    this.isDisabled = false,
    this.onLongPress,
  }) : assert(
         labelColor != null,
         'Outlined button requires a label color for both text and border',
       ),
       assert(
         type == ButtonType.outlined,
         'CustomButton.outlined constructor must be used with ButtonType.outlined',
       ),
       assert(
         backgroundColor == null,
         'Outlined button should not have a background gradient',
       );

  const Button.plain({
    super.key,
    this.type = ButtonType.plain,
    required this.label,
    required this.labelColor,
    this.backgroundColor,
    this.expand = true,
    required this.onTap,
    this.isDisabled = false,
    this.onLongPress,
  }) : assert(labelColor != null, 'Plain button requires a label color'),
       assert(
         type == ButtonType.plain,
         'CustomButton.plain constructor must be used with ButtonType.plain',
       ),
       assert(
         backgroundColor == null,
         'Plain button should not have a background gradient',
       );

  BoxDecoration _getBackgroundDecoration(AppDesignSystem ds) {
    switch (type) {
      case ButtonType.filled:
        return BoxDecoration(
          gradient: backgroundColor,
          borderRadius: ds.borderRadii.radiusM,
        );
      case ButtonType.outlined:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: labelColor!),
          borderRadius: ds.borderRadii.radiusM,
        );
      case ButtonType.plain:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: ds.borderRadii.radiusM,
        );
    }
  }

  static const _animationDuration = Duration(milliseconds: 700);
  static const _animationCurve = Curves.fastLinearToSlowEaseIn;

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: TapBuilder(
          onTap: isDisabled ? null : onTap,
          onLongPress: onLongPress,
          builder:
              (context, tapState, isFocused) => AnimatedScale(
                scale: tapState == TapState.pressed ? .985 : 1.0,
                duration: _animationDuration,
                curve: _animationCurve,
                child: AnimatedContainer(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  decoration: _getBackgroundDecoration(ds),
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withValues(
                      alpha:
                          tapState == TapState.pressed
                              ? .08
                              : tapState == TapState.hover
                              ? .05
                              : 0,
                    ),
                    borderRadius: ds.borderRadii.radiusM,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 4 * ds.spacing.xs,
                    horizontal: ds.spacing.l + 2 * ds.spacing.xs,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: label,
                          style: CustomTextStyle.bodyL,
                          fontWeight: FontWeight.w700,
                          color: labelColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
