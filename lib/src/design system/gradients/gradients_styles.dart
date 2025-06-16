import 'package:flutter/material.dart';

import '../../design%20system/gradients/gradients_data.dart';

/// Represents a collection of gradient styles, each defining specific gradient values.
class GradientsStyles {
  /// Creates a set of gradient styles with specified values for different types.
  GradientsStyles({
    required this.primary,
    required this.danger,
  });

  /// Gradient value for primary style.
  final LinearGradient primary;

  /// Gradient value for danger style.
  final LinearGradient danger;

  /// Creates a copy of [GradientsStyles] with specified values replaced.
  GradientsStyles copyWith({
    LinearGradient? primary,
    LinearGradient? danger,
  }) {
    return GradientsStyles(
      primary: primary ?? this.primary,
      danger: danger ?? this.danger,
    );
  }

  /// Linearly interpolates between two [GradientsStyles] instances.
  static GradientsStyles lerp(GradientsStyles? a, GradientsStyles? b, double t) {
    if (a == null && b == null) {
      // If both styles are null, return a default set of gradient values.
      return GradientsStyles(
        primary: GradientsData.primaryGradient,
        danger: GradientsData.dangerGradient,
      );
    }

    // Linearly interpolate each gradient value.
    return GradientsStyles(
      primary: LinearGradient.lerp(a?.primary, b?.primary, t)!,
      danger: LinearGradient.lerp(a?.danger, b?.danger, t)!,
    );
  }
}