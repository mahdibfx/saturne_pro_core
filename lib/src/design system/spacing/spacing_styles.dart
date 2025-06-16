import 'dart:ui';

import '../../design%20system/spacing/spacing_data.dart';

/// Represents a collection of spacing styles, each defining specific spacing values.
class SpacingStyles {
  /// Creates a set of spacing styles with specified values for different sizes.
  SpacingStyles({
    required this.xs,
    required this.s,
    required this.l,
    required this.xl,
  });

  /// Spacing value for extra small size.
  final double xs;

  /// Spacing value for small size.
  final double s;

  /// Spacing value for large size.
  final double l;

  /// Spacing value for extra large size.
  final double xl;

  /// Creates a copy of [SpacingStyles] with specified values replaced.
  SpacingStyles copyWith({double? xs, double? s, double? l, double? xl}) {
    return SpacingStyles(
      xs: xs ?? this.xs,
      s: s ?? this.s,
      l: l ?? this.l,
      xl: xl ?? this.xl,
    );
  }

  /// Linearly interpolates between two [SpacingStyles] instances.
  static SpacingStyles lerp(SpacingStyles? a, SpacingStyles? b, double t) {
    if (a == null && b == null) {
      // If both styles are null, return a default set of spacing values.
      return SpacingStyles(
        xs: SpacingData.extraSmallSpacing,
        s: SpacingData.smallSpacing,
        l: SpacingData.largeSpacing,
        xl: SpacingData.extraLargeSpacing,
      );
    }

    // Linearly interpolate each spacing value.
    return SpacingStyles(
      xs: lerpDouble(a?.xs, b?.xs, t)!,
      s: lerpDouble(a?.s, b?.s, t)!,
      l: lerpDouble(a?.l, b?.l, t)!,
      xl: lerpDouble(a?.xl, b?.xl, t)!,
    );
  }
}
