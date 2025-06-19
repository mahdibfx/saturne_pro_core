import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../../design system/design_system.dart';

enum CustomTextStyle {
  displayXL,
  displayL,
  headingXL,
  headingL,
  headingM,
  bodyL,
  bodyM,
  bodyS,
  captionM,
}

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextStyle? style;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextDecoration? textDecoration;
  final TextDecorationStyle? textDecorationStyle;
  final Color? textDecorationColor;
  final TextAlign? textAlign;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textDecoration,
    this.textDecorationStyle,
    this.textDecorationColor,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  });

  TextStyle _getTextStyle(AppDesignSystem designSystem) {
    late TextStyle textStyle;
    if (style == null) {
      textStyle = designSystem.typography.bodyM;
      return textStyle;
    }
    switch (style) {
      case CustomTextStyle.displayXL:
        textStyle = designSystem.typography.displayXL;
        break;
      case CustomTextStyle.displayL:
        textStyle = designSystem.typography.displayL;
        break;
      case CustomTextStyle.headingXL:
        textStyle = designSystem.typography.headingXL;
        break;
      case CustomTextStyle.headingL:
        textStyle = designSystem.typography.headingL;
        break;
      case CustomTextStyle.headingM:
        textStyle = designSystem.typography.headingM;
        break;
      case CustomTextStyle.bodyL:
        textStyle = designSystem.typography.bodyL;
        break;
      case CustomTextStyle.bodyM:
        textStyle = designSystem.typography.bodyM;
        break;
      case CustomTextStyle.bodyS:
        textStyle = designSystem.typography.bodyS;
        break;
      case CustomTextStyle.captionM:
        textStyle = designSystem.typography.captionM;
        break;
      default:
        textStyle = designSystem.typography.bodyM;
        break;
    }
    return textStyle;
  }

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: _getTextStyle(designSystem).copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
        decoration: textDecoration,
        decorationStyle: textDecorationStyle,
        decorationColor:
            textDecorationColor ?? designSystem.colors.secondary.shade500,
      ),
    );
  }
}
