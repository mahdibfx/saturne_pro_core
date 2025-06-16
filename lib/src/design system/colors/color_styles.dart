import 'package:flutter/material.dart';

import 'colors_data.dart';

class BaseColor {
  const BaseColor({
    required this.shade50,
    required this.shade100,
    required this.shade200,
    required this.shade300,
    required this.shade400,
    required this.shade500,
    required this.shade600,
    required this.shade700,
    required this.shade800,
    required this.shade900,
  });

  final Color shade50;
  final Color shade100;
  final Color shade200;
  final Color shade300;
  final Color shade400;
  final Color shade500;
  final Color shade600;
  final Color shade700;
  final Color shade800;
  final Color shade900;

  BaseColor copyWith({
    Color? shade50,
    Color? shade100,
    Color? shade200,
    Color? shade300,
    Color? shade400,
    Color? shade500,
    Color? shade600,
    Color? shade700,
    Color? shade800,
    Color? shade900,
  }) {
    return BaseColor(
      shade50: shade50 ?? this.shade50,
      shade100: shade100 ?? this.shade100,
      shade200: shade200 ?? this.shade200,
      shade300: shade300 ?? this.shade300,
      shade400: shade400 ?? this.shade400,
      shade500: shade500 ?? this.shade500,
      shade600: shade600 ?? this.shade600,
      shade700: shade700 ?? this.shade700,
      shade800: shade800 ?? this.shade800,
      shade900: shade900 ?? this.shade900,
    );
  }

  static BaseColor lerp(BaseColor? a, BaseColor? b, double t) {
    if (a == null && b == null) {
      return const BaseColor(
        shade50: Colors.transparent,
        shade100: Colors.transparent,
        shade200: Colors.transparent,
        shade300: Colors.transparent,
        shade400: Colors.transparent,
        shade500: Colors.transparent,
        shade600: Colors.transparent,
        shade700: Colors.transparent,
        shade800: Colors.transparent,
        shade900: Colors.transparent,
      );
    }
    return BaseColor(
      shade50: Color.lerp(a?.shade50, b?.shade50, t) ?? Colors.transparent,
      shade100: Color.lerp(a?.shade100, b?.shade100, t) ?? Colors.transparent,
      shade200: Color.lerp(a?.shade200, b?.shade200, t) ?? Colors.transparent,
      shade300: Color.lerp(a?.shade300, b?.shade300, t) ?? Colors.transparent,
      shade400: Color.lerp(a?.shade400, b?.shade400, t) ?? Colors.transparent,
      shade500: Color.lerp(a?.shade500, b?.shade500, t) ?? Colors.transparent,
      shade600: Color.lerp(a?.shade600, b?.shade600, t) ?? Colors.transparent,
      shade700: Color.lerp(a?.shade700, b?.shade700, t) ?? Colors.transparent,
      shade800: Color.lerp(a?.shade800, b?.shade800, t) ?? Colors.transparent,
      shade900: Color.lerp(a?.shade900, b?.shade900, t) ?? Colors.transparent,
    );
  }
}

class ColorStyles {
  const ColorStyles({
    required this.primary,
    required this.secondary,
    required this.warning,
    required this.danger,
    required this.success,
    required this.shade,
  });

  final BaseColor primary;
  final BaseColor secondary;
  final BaseColor warning;
  final BaseColor danger;
  final BaseColor success;
  final BaseColor shade;

  ColorStyles copyWith({
    BaseColor? primary,
    BaseColor? secondary,
    BaseColor? warning,
    BaseColor? danger,
    BaseColor? success,
    BaseColor? shade,
  }) {
    return ColorStyles(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      success: success ?? this.success,
      shade: shade ?? this.shade,
    );
  }

  static ColorStyles lerp(ColorStyles? a, ColorStyles? b, double t) {
    if (a == null && b == null) {
      return const ColorStyles(
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
      );
    }
    return ColorStyles(
      primary: BaseColor.lerp(a?.primary, b?.primary, t),
      secondary: BaseColor.lerp(a?.secondary, b?.secondary, t),
      warning: BaseColor.lerp(a?.warning, b?.warning, t),
      danger: BaseColor.lerp(a?.danger, b?.danger, t),
      success: BaseColor.lerp(a?.success, b?.success, t),
      shade: BaseColor.lerp(a?.shade, b?.shade, t),
    );
  }
}
