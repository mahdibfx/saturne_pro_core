import 'package:flutter/material.dart';

import '../design system/saturne_pro_theme_extension.dart';
import '../exceptions/theme_not_found_exception.dart';
import 'constants.dart';

/// Retrieves the [AppDesignSystem] from the current [BuildContext]'s theme.
///
/// Throws a [DesignSystemModeNotFoundException] if the design system is not found.
/// This typically occurs when the theme is not properly set with one of the provided
/// design system modes from the `saturne_pro_core` package.
///
/// Example usage:
/// ```dart
/// MaterialApp(
///   // ...
///   theme: SaturneProDesignSystem.lightMode, // Replace with your chosen mode
///   // other properties ...
/// )
/// ```
AppDesignSystem? appDesignSystem(BuildContext context) {
  try {
    return Theme.of(context).extension<AppDesignSystem>();
  } catch (e) {
    throw DesignSystemModeNotFoundException(
      'Failed to retrieve AppDesignSystem: $e\n\n'
      'Please make sure to set one of the provided design system modes from the $packageName package. '
      'You can use them as follows:\n\n'
      'MaterialApp(\n'
      '  // ...\n'
      '  theme: SaturneProDesignSystem.lightMode, // Replace with your chosen mode\n'
      '  // other properties ...\n'
      ')\n',
    );
  }
}

/// Extension on [BuildContext] to easily access the [AppDesignSystem].
extension DesignSystemExtension on BuildContext {
  /// Retrieves the [AppDesignSystem] from the current [BuildContext]'s theme.
  ///
  /// Throws a [DesignSystemModeNotFoundException] if the design system is not found.
  /// This typically occurs when the theme is not properly set with one of the provided
  /// design system modes from the `saturne_pro_core` package.
  ///
  /// Example usage:
  /// ```dart
  /// AppDesignSystem designSystem = context.designSystem;
  /// ```
  AppDesignSystem get designSystem {
    try {
      return Theme.of(this).extension<AppDesignSystem>()!;
    } catch (e) {
      throw DesignSystemModeNotFoundException(
        'Failed to retrieve AppDesignSystem: $e\n\n'
        'Please make sure to set one of the provided design system modes from the $packageName package. '
        'You can use them as follows:\n\n'
        'MaterialApp(\n'
        '  // ...\n'
        '  theme: SaturneProDesignSystem.lightMode, // Replace with your chosen mode\n'
        '  // other properties ...\n'
        ')\n',
      );
    }
  }
}
