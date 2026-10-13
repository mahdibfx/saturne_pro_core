import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/design%20system/gradients/gradients_data.dart';
import 'package:saturne_pro_core/src/design%20system/gradients/gradients_styles.dart';

import 'border radii/border_radii_data.dart';
import 'border radii/border_radii_styles.dart';
import 'colors/color_styles.dart';
import 'colors/colors_data.dart';
import 'saturne_pro_theme_extension.dart';
import 'spacing/spacing_data.dart';
import 'spacing/spacing_styles.dart';
import 'typography/typography_data.dart';
import 'typography/typography_styles.dart';

/// Singleton class representing the design system for the SaturneProCore application.
class SaturneProDesignSystem {
  SaturneProDesignSystem._();

  static final SaturneProDesignSystem _instance = SaturneProDesignSystem._();

  factory SaturneProDesignSystem() {
    return _instance;
  }

  /// Get the current theme based on the brightness.
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightMode : darkMode;
  }

  /// Theme data for the light mode of the SaturneProCore application.
  static final ThemeData lightMode = ThemeData(
    // Tellot screen background (#F3F5F7 on every app frame).
    scaffoldBackgroundColor: const Color(0xffF3F5F7),
    extensions: [
      AppDesignSystem(
        colors: const ColorStyles(
          primary: BaseColor(
            shade50: ColorsData.kcPrimary50,
            shade100: ColorsData.kcPrimary100,
            shade200: ColorsData.kcPrimary200,
            shade300: ColorsData.kcPrimary300,
            shade400: ColorsData.kcPrimary400,
            shade500: ColorsData.kcPrimary500,
            shade600: ColorsData.kcPrimary600,
            shade700: ColorsData.kcPrimary700,
            shade800: ColorsData.kcPrimary800,
            shade900: ColorsData.kcPrimary900,
          ),
          secondary: BaseColor(
            shade50: ColorsData.kcSecondary50,
            shade100: ColorsData.kcSecondary100,
            shade200: ColorsData.kcSecondary200,
            shade300: ColorsData.kcSecondary300,
            shade400: ColorsData.kcSecondary400,
            shade500: ColorsData.kcSecondary500,
            shade600: ColorsData.kcSecondary600,
            shade700: ColorsData.kcSecondary700,
            shade800: ColorsData.kcSecondary800,
            shade900: ColorsData.kcSecondary900,
          ),
          warning: BaseColor(
            shade50: ColorsData.kcWarning50,
            shade100: ColorsData.kcWarning100,
            shade200: ColorsData.kcWarning200,
            shade300: ColorsData.kcWarning300,
            shade400: ColorsData.kcWarning400,
            shade500: ColorsData.kcWarning500,
            shade600: ColorsData.kcWarning600,
            shade700: ColorsData.kcWarning700,
            shade800: ColorsData.kcWarning800,
            shade900: ColorsData.kcWarning900,
          ),
          danger: BaseColor(
            shade50: ColorsData.kcDanger50,
            shade100: ColorsData.kcDanger100,
            shade200: ColorsData.kcDanger200,
            shade300: ColorsData.kcDanger300,
            shade400: ColorsData.kcDanger400,
            shade500: ColorsData.kcDanger500,
            shade600: ColorsData.kcDanger600,
            shade700: ColorsData.kcDanger700,
            shade800: ColorsData.kcDanger800,
            shade900: ColorsData.kcDanger900,
          ),
          success: BaseColor(
            shade50: ColorsData.kcSuccess50,
            shade100: ColorsData.kcSuccess100,
            shade200: ColorsData.kcSuccess200,
            shade300: ColorsData.kcSuccess300,
            shade400: ColorsData.kcSuccess400,
            shade500: ColorsData.kcSuccess500,
            shade600: ColorsData.kcSuccess600,
            shade700: ColorsData.kcSuccess700,
            shade800: ColorsData.kcSuccess800,
            shade900: ColorsData.kcSuccess900,
          ),
          shade: BaseColor(
            shade50: ColorsData.kcShade50,
            shade100: ColorsData.kcShade100,
            shade200: ColorsData.kcShade200,
            shade300: ColorsData.kcShade300,
            shade400: ColorsData.kcShade400,
            shade500: ColorsData.kcShade500,
            shade600: ColorsData.kcShade600,
            shade700: ColorsData.kcShade700,
            shade800: ColorsData.kcShade800,
            shade900: ColorsData.kcShade900,
          ),
        ),

        gradients: GradientsStyles(
          primary: GradientsData.primaryGradient,
          danger: GradientsData.dangerGradient,
        ),

        spacing: SpacingStyles(
          xs: SpacingData.extraSmallSpacing,
          s: SpacingData.smallSpacing,
          l: SpacingData.largeSpacing,
          xl: SpacingData.extraLargeSpacing,
        ),

        borderRadii: BorderRadiiStyles(
          radiusFull: BorderRadiiData.borderRadiusFull,
          radiusS: BorderRadiiData.borderRadiusS,
          radiusM: BorderRadiiData.borderRadiusM,
          radiusL: BorderRadiiData.borderRadiusL,
        ),

        typography: TypographyStyles(
          displayXL: TypographyData.displayXL,
          displayL: TypographyData.displayL,
          headingXL: TypographyData.headingXL,
          headingL: TypographyData.headingL,
          headingM: TypographyData.headingM,
          bodyL: TypographyData.bodyL,
          bodyM: TypographyData.bodyM,
          bodyS: TypographyData.bodyS,
          captionM: TypographyData.captionM,
        ),
      ),
    ],
  );

  /// Theme data for the dark mode of the SaturneProCore application.
  static final ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: ColorsData.kcShade50,
    brightness: Brightness.dark,
    extensions: [
      AppDesignSystem(
        colors: const ColorStyles(
          primary: BaseColor(
            shade50: ColorsData.kcPrimary50,
            shade100: ColorsData.kcPrimary100,
            shade200: ColorsData.kcPrimary200,
            shade300: ColorsData.kcPrimary300,
            shade400: ColorsData.kcPrimary400,
            shade500: ColorsData.kcPrimary500,
            shade600: ColorsData.kcPrimary600,
            shade700: ColorsData.kcPrimary700,
            shade800: ColorsData.kcPrimary800,
            shade900: ColorsData.kcPrimary900,
          ),
          secondary: BaseColor(
            shade50: ColorsData.kcSecondary50,
            shade100: ColorsData.kcSecondary100,
            shade200: ColorsData.kcSecondary200,
            shade300: ColorsData.kcSecondary300,
            shade400: ColorsData.kcSecondary400,
            shade500: ColorsData.kcSecondary500,
            shade600: ColorsData.kcSecondary600,
            shade700: ColorsData.kcSecondary700,
            shade800: ColorsData.kcSecondary800,
            shade900: ColorsData.kcSecondary900,
          ),
          warning: BaseColor(
            shade50: ColorsData.kcWarning50,
            shade100: ColorsData.kcWarning100,
            shade200: ColorsData.kcWarning200,
            shade300: ColorsData.kcWarning300,
            shade400: ColorsData.kcWarning400,
            shade500: ColorsData.kcWarning500,
            shade600: ColorsData.kcWarning600,
            shade700: ColorsData.kcWarning700,
            shade800: ColorsData.kcWarning800,
            shade900: ColorsData.kcWarning900,
          ),
          danger: BaseColor(
            shade50: ColorsData.kcDanger50,
            shade100: ColorsData.kcDanger100,
            shade200: ColorsData.kcDanger200,
            shade300: ColorsData.kcDanger300,
            shade400: ColorsData.kcDanger400,
            shade500: ColorsData.kcDanger500,
            shade600: ColorsData.kcDanger600,
            shade700: ColorsData.kcDanger700,
            shade800: ColorsData.kcDanger800,
            shade900: ColorsData.kcDanger900,
          ),
          success: BaseColor(
            shade50: ColorsData.kcSuccess50,
            shade100: ColorsData.kcSuccess100,
            shade200: ColorsData.kcSuccess200,
            shade300: ColorsData.kcSuccess300,
            shade400: ColorsData.kcSuccess400,
            shade500: ColorsData.kcSuccess500,
            shade600: ColorsData.kcSuccess600,
            shade700: ColorsData.kcSuccess700,
            shade800: ColorsData.kcSuccess800,
            shade900: ColorsData.kcSuccess900,
          ),
          shade: BaseColor(
            shade50: ColorsData.kcShade50,
            shade100: ColorsData.kcShade100,
            shade200: ColorsData.kcShade200,
            shade300: ColorsData.kcShade300,
            shade400: ColorsData.kcShade400,
            shade500: ColorsData.kcShade500,
            shade600: ColorsData.kcShade600,
            shade700: ColorsData.kcShade700,
            shade800: ColorsData.kcShade800,
            shade900: ColorsData.kcShade900,
          ),
        ),
        spacing: SpacingStyles(
          xs: SpacingData.extraSmallSpacing,
          s: SpacingData.smallSpacing,
          l: SpacingData.largeSpacing,
          xl: SpacingData.extraLargeSpacing,
        ),
        borderRadii: BorderRadiiStyles(
          radiusFull: BorderRadiiData.borderRadiusFull,
          radiusS: BorderRadiiData.borderRadiusS,
          radiusM: BorderRadiiData.borderRadiusM,
          radiusL: BorderRadiiData.borderRadiusL,
        ),
        typography: TypographyStyles(
          displayXL: TypographyData.displayXL,
          displayL: TypographyData.displayL,
          headingXL: TypographyData.headingXL,
          headingL: TypographyData.headingL,
          headingM: TypographyData.headingM,
          bodyL: TypographyData.bodyL,
          bodyM: TypographyData.bodyM,
          bodyS: TypographyData.bodyS,
          captionM: TypographyData.captionM,
        ),
        gradients: GradientsStyles(
          primary: GradientsData.primaryGradient,
          danger: GradientsData.dangerGradient,
        ),
      ),
    ],
  );
}
