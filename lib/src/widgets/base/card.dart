import 'package:flutter/widgets.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

/// A customizable card widget that follows the design system guidelines.
///
/// This widget creates a container with standardized styling from the design system,
/// including background color and border radius. It can be configured to take
/// full width or wrap its content, and allows for custom padding and border.
///
/// Example usage:
/// ```dart
/// CustomCard(
///   child: Text('Card content'),
///   isFullWidth: false,
///   padding: EdgeInsets.all(16.0),
///   border: Border.all(color: Colors.grey),
/// )
/// ```
class CustomCard extends StatelessWidget {
  /// Optional padding for the card content.
  /// If not provided, uses the small spacing from the design system.
  final EdgeInsetsGeometry? padding;

  /// Whether the card should take the full available width.
  /// Defaults to `true`.
  final bool isFullWidth;

  /// The content to be displayed inside the card.
  final Widget child;

  /// Optional border for the card.
  /// If not provided, no border will be shown.
  final Border? border;

  /// Creates a [CustomCard] widget.
  ///
  /// The [child] parameter is required and represents the content of the card.
  /// The [isFullWidth] parameter determines if the card takes full width (defaults to true).
  /// The [padding] parameter allows custom padding (defaults to design system's small spacing).
  /// The [border] parameter allows custom border styling (defaults to null).
  const CustomCard({
    super.key,
    this.padding,
    required this.child,
    this.isFullWidth = true,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: padding ?? EdgeInsets.all(ds.spacing.s),
      decoration: BoxDecoration(
        color: ds.colors.primary.shade50,
        borderRadius: ds.borderRadii.radiusS,
        border: border,
      ),
      child: child,
    );
  }
}
