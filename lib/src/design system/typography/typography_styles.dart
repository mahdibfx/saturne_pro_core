import 'package:flutter/material.dart';

import 'typography_data.dart';

/// Represents a collection of typography styles, each defining a set of text styles.
class TypographyStyles {
  /// Creates a set of typography styles with specified text styles for different elements.
  TypographyStyles({
    required this.displayXL,
    required this.displayL,
    required this.headingXL,
    required this.headingL,
    required this.headingM,
    required this.bodyL,
    required this.bodyM,
    required this.bodyS,
    required this.captionM,
  });

  /// Typography style for extra large display text (42px).
  final TextStyle displayXL;

  /// Typography style for large display text (28px).
  final TextStyle displayL;

  /// Typography style for extra large headings (22px).
  final TextStyle headingXL;

  /// Typography style for large headings (20px).
  final TextStyle headingL;

  /// Typography style for medium headings (18px).
  final TextStyle headingM;

  /// Typography style for large body text (16px).
  final TextStyle bodyL;

  /// Typography style for medium body text (15px).
  final TextStyle bodyM;

  /// Typography style for small body text (14px).
  final TextStyle bodyS;

  /// Typography style for medium captions (12px).
  final TextStyle captionM;

  /// Creates a copy of [TypographyStyles] with specified values replaced.
  TypographyStyles copyWith({
    TextStyle? displayXL,
    TextStyle? displayL,
    TextStyle? headingXL,
    TextStyle? headingL,
    TextStyle? headingM,
    TextStyle? bodyL,
    TextStyle? bodyM,
    TextStyle? bodyS,
    TextStyle? captionM,
  }) {
    return TypographyStyles(
      displayXL: displayXL ?? this.displayXL,
      displayL: displayL ?? this.displayL,
      headingXL: headingXL ?? this.headingXL,
      headingL: headingL ?? this.headingL,
      headingM: headingM ?? this.headingM,
      bodyL: bodyL ?? this.bodyL,
      bodyM: bodyM ?? this.bodyM,
      bodyS: bodyS ?? this.bodyS,
      captionM: captionM ?? this.captionM,
    );
  }

  /// Linearly interpolates between two [TypographyStyles] instances.
  static TypographyStyles lerp(
    TypographyStyles? a,
    TypographyStyles? b,
    double t,
  ) {
    if (a == null && b == null) {
      // If both styles are null, return a default set of text styles based on TypographyData.
      return TypographyStyles(
        displayXL: TypographyData.displayXL,
        displayL: TypographyData.displayL,
        headingXL: TypographyData.headingXL,
        headingL: TypographyData.headingL,
        headingM: TypographyData.headingM,
        bodyL: TypographyData.bodyL,
        bodyM: TypographyData.bodyM,
        bodyS: TypographyData.bodyS,
        captionM: TypographyData.captionM,
      );
    }

    // Linearly interpolate each text style.
    return TypographyStyles(
      displayXL: TextStyle.lerp(a?.displayXL, b?.displayXL, t)!,
      displayL: TextStyle.lerp(a?.displayL, b?.displayL, t)!,
      headingXL: TextStyle.lerp(a?.headingXL, b?.headingXL, t)!,
      headingL: TextStyle.lerp(a?.headingL, b?.headingL, t)!,
      headingM: TextStyle.lerp(a?.headingM, b?.headingM, t)!,
      bodyL: TextStyle.lerp(a?.bodyL, b?.bodyL, t)!,
      bodyM: TextStyle.lerp(a?.bodyM, b?.bodyM, t)!,
      bodyS: TextStyle.lerp(a?.bodyS, b?.bodyS, t)!,
      captionM: TextStyle.lerp(a?.captionM, b?.captionM, t)!,
    );
  }
}
