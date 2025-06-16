import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

/// A custom tooltip widget that provides consistent styling across the app.
class CustomTooltip extends StatelessWidget {
  /// The message to display in the tooltip
  final String message;

  /// The child widget that will trigger the tooltip
  final Widget child;

  /// Whether to prefer showing the tooltip below the child
  final bool preferBelow;

  /// The vertical offset of the tooltip from the child
  final double verticalOffset;

  const CustomTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = false,
    this.verticalOffset = 24,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      verticalOffset: verticalOffset,
      decoration: BoxDecoration(
        color: ds.colors.primary.shade900,
        borderRadius: ds.borderRadii.radiusS,
      ),
      textStyle: ds.typography.bodyS.copyWith(
        color: ds.colors.primary.shade200,
      ),
      child: child,
    );
  }
}
