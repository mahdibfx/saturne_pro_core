import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

// Enum for defining available gap sizes.
enum GapSize {
  xs, // Extra small
  s, // Small
  l, // Large
  xl, // Extra large
}

/// A reusable widget for creating flexible visual gaps in layouts.
///
/// Offers options for both predefined and custom gap sizes,
/// as well as the ability to create sliver gaps for scrolling contexts.
class CustomGap extends StatelessWidget {
  /// The desired gap size, selected from the [GapSize] enum.
  ///
  /// Cannot be provided if [customSizeValue] is also set.
  final GapSize? gapSize;

  /// A custom gap size value, used when a specific size not available in [GapSize] is needed.
  ///
  /// Cannot be provided if [gapSize] is also set.
  final double? customSizeValue;

  /// Determines whether to use a [SliverGap] for scrolling contexts.
  ///
  /// Defaults to false, using a regular [Gap] widget.
  final bool isSliverGap;

  /// Creates a [CustomGap] instance.
  ///
  /// Throws an assertion error if both [gapSize] and [customSizeValue] are provided,
  /// as only one method of specifying the gap size is allowed.
  const CustomGap({
    super.key,
    this.gapSize,
    this.customSizeValue,
    this.isSliverGap = false,
  }) : assert(
         (gapSize == null && customSizeValue != null) ||
             (gapSize != null && customSizeValue == null),
         'CustomGap must be provided with either a gapSize or a customSizeValue, but not both.',
       );

  /// Retrieves the appropriate gap size based on the provided configuration.
  double _getGapSize(AppDesignSystem designSystem) {
    late double size;
    if (customSizeValue != null) {
      size = customSizeValue!;
      return size;
    }

    // Map the selected [gapSize] to the corresponding spacing value from the design system.
    switch (gapSize) {
      case GapSize.xs:
        size = designSystem.spacing.xs;
        break;
      case GapSize.s:
        size = designSystem.spacing.s;
        break;
      case GapSize.l:
        size = designSystem.spacing.l;
        break;
      case GapSize.xl:
        size = designSystem.spacing.xl;
        break;
      default:
        size =
            designSystem
                .spacing
                .l; // Default to large size for unknown gapSize values.
    }

    return size;
  }

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    // Determine the appropriate gap widget based on [isSliverGap].
    return isSliverGap
        ? SliverGap(_getGapSize(designSystem))
        : Gap(_getGapSize(designSystem));
  }
}
