import 'package:flutter/material.dart';

import 'border radii/border_radii_styles.dart';
import 'colors/color_styles.dart';
import 'gradients/gradients_styles.dart';
import 'spacing/spacing_styles.dart';
import 'typography/typography_styles.dart';

/// A theme extension that provides access to the SaturneProDesignSystem.
class AppDesignSystem extends ThemeExtension<AppDesignSystem> {
  const AppDesignSystem({
    required this.colors,
    required this.spacing,
    required this.borderRadii,
    required this.typography,
    required this.gradients,
  });

  final ColorStyles colors;
  final SpacingStyles spacing;
  final BorderRadiiStyles borderRadii;
  final TypographyStyles typography;
  final GradientsStyles gradients;

  @override
  ThemeExtension<AppDesignSystem> copyWith({
    ColorStyles? colors,
    SpacingStyles? spacing,
    BorderRadiiStyles? borderRadii,
    TypographyStyles? typography,
    GradientsStyles? gradients,
  }) {
    return AppDesignSystem(
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      borderRadii: borderRadii ?? this.borderRadii,
      typography: typography ?? this.typography,
      gradients: gradients ?? this.gradients,
    );
  }

  @override
  ThemeExtension<AppDesignSystem> lerp(
    covariant ThemeExtension<AppDesignSystem>? other,
    double t,
  ) {
    if (other is! AppDesignSystem) {
      return this;
    }

    return AppDesignSystem(
      colors: ColorStyles.lerp(colors, other.colors, t),
      spacing: SpacingStyles.lerp(spacing, other.spacing, t),
      borderRadii: BorderRadiiStyles.lerp(borderRadii, other.borderRadii, t),
      typography: TypographyStyles.lerp(typography, other.typography, t),
      gradients: GradientsStyles.lerp(gradients, other.gradients, t),
    );
  }

  /// Get the design system from the given [BuildContext].
  static AppDesignSystem of(BuildContext context) {
    return Theme.of(context).extension<AppDesignSystem>()!;
  }
}
