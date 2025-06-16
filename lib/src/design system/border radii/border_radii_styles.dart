import 'package:flutter/material.dart';

import '../../design%20system/border%20radii/border_radii_data.dart';

/// Represents a collection of border radii styles, each defining specific radii values.
class BorderRadiiStyles {
  /// Creates a set of border radii styles with specified values for different sizes.
  BorderRadiiStyles({
    required this.radiusS,
    required this.radiusM,
    required this.radiusL,
    required this.radiusFull,
  });

  /// Border radius value for small size (8.0).
  final BorderRadius radiusS;

  /// Border radius value for medium size (12.0).
  final BorderRadius radiusM;

  /// Border radius value for large size (14.0).
  final BorderRadius radiusL;

  /// Border radius value for full circular radius.
  final BorderRadius radiusFull;

  /// Creates a copy of [BorderRadiiStyles] with specified values replaced.
  BorderRadiiStyles copyWith({
    BorderRadius? radiusS,
    BorderRadius? radiusM,
    BorderRadius? radiusL,
    BorderRadius? radiusFull,
  }) {
    return BorderRadiiStyles(
      radiusS: radiusS ?? this.radiusS,
      radiusM: radiusM ?? this.radiusM,
      radiusL: radiusL ?? this.radiusL,
      radiusFull: radiusFull ?? this.radiusFull,
    );
  }

  /// Linearly interpolates between two [BorderRadiiStyles] instances.
  static BorderRadiiStyles lerp(
    BorderRadiiStyles? a,
    BorderRadiiStyles? b,
    double t,
  ) {
    if (a == null && b == null) {
      // If both styles are null, return a default set of radii values.
      return BorderRadiiStyles(
        radiusS: BorderRadiiData.borderRadiusS,
        radiusM: BorderRadiiData.borderRadiusM,
        radiusL: BorderRadiiData.borderRadiusL,
        radiusFull: BorderRadiiData.borderRadiusFull,
      );
    }

    // Linearly interpolate each radius value.
    return BorderRadiiStyles(
      radiusS: BorderRadius.lerp(a?.radiusS, b?.radiusS, t)!,
      radiusM: BorderRadius.lerp(a?.radiusM, b?.radiusM, t)!,
      radiusL: BorderRadius.lerp(a?.radiusL, b?.radiusL, t)!,
      radiusFull: BorderRadius.lerp(a?.radiusFull, b?.radiusFull, t)!,
    );
  }
}
