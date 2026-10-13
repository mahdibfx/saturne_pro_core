import 'package:flutter/material.dart';

import '../../helpers/helpers.dart';

/// A utility class for defining typography styles using the Plus Jakarta Sans font.
class TypographyData {
  // Private constructor to prevent instantiation.
  TypographyData._();

  static const String _fontFamily = 'PlusJakartaSans';
  static const String _package = packageName;

  // Display styles: L, XL
  // ----------------------------------------
  /// Typography style for displayXL text 42 px
  static final TextStyle displayXL = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 10.5 * Dimensions.xs,
    fontWeight: FontWeight.w800,
  );

  /// Typography style for displayL text 28 px
  static final TextStyle displayL = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 7 * Dimensions.xs,
    fontWeight: FontWeight.w700,
  );

  // Heading styles: M, L, XL
  // ----------------------------------------
  /// Typography style for headingXL. 22 px
  static final TextStyle headingXL = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 5.5 * Dimensions.xs,
    fontWeight: FontWeight.w700,
  );

  /// Typography style for headingL 20 px
  static final TextStyle headingL = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 5 * Dimensions.xs,
    fontWeight: FontWeight.w700,
  );

  /// Typography style for headingM 18 px
  static final TextStyle headingM = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 4.5 * Dimensions.xs,
    fontWeight: FontWeight.w500,
  );

  // Body styles: S, M, L
  // ----------------------------------------
  /// Typography style for bodyL text 16 px
  static final TextStyle bodyL = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 4 * Dimensions.xs,
    fontWeight: FontWeight.w500,
  );

  /// Typography style for bodyM text 15 px
  static final TextStyle bodyM = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 3.75 * Dimensions.xs,
    fontWeight: FontWeight.w300,
  );

  /// Typography style for bodyS text 14 px
  static final TextStyle bodyS = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 3.5 * Dimensions.xs,
    fontWeight: FontWeight.w500,
  );

  // Caption style: M
  // ----------------------------------------
  /// Typography style for captionM 12 px
  static final TextStyle captionM = TextStyle(
    fontFamily: _fontFamily,
    package: _package,
    fontSize: 3 * Dimensions.xs,
    fontWeight: FontWeight.w500,
  );
}
