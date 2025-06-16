import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/design_system_helper_methodes.dart';
import '../base/base.dart';

/// A widget that displays multiple lines of text with customizable underlines.
///
/// This widget automatically measures text dimensions and positions underlines
/// accordingly. It supports various text styling options and alignment.
class UnderlinedText extends StatefulWidget {
  /// The list of text lines to display with underlines.
  final List<String> textLines;

  /// The spacing between text lines. Defaults to 0.0.
  final double? gutter;

  /// Custom text style to apply to all text lines.
  final CustomTextStyle? style;

  /// Text color override. If null, uses the style's color.
  final Color? color;

  /// Font weight override. If null, uses the style's font weight.
  final FontWeight? fontWeight;

  /// Font size override. If null, uses the style's font size.
  final double? fontSize;

  /// The color of the underline.
  final Color lineColor;

  /// The thickness of the underline. If null, defaults to 35% of text height.
  final double? lineThickness;

  /// Text alignment for all lines.
  final TextAlign? textAlign;

  const UnderlinedText({
    super.key,
    required this.textLines,
    required this.lineColor,
    this.lineThickness,
    this.gutter,
    this.style,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
  }) : assert(textLines.length > 0, 'textLines cannot be empty');

  @override
  State<UnderlinedText> createState() => _UnderlinedTextState();
}

class _UnderlinedTextState extends State<UnderlinedText> {
  late final List<GlobalKey> _keys;
  late List<Size> _sizes;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeKeys();
    _schedulePostFrameCallback();
  }

  @override
  void didUpdateWidget(UnderlinedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinitialize if the number of text lines changed
    if (oldWidget.textLines.length != widget.textLines.length) {
      _initializeKeys();
      _schedulePostFrameCallback();
    }
  }

  void _initializeKeys() {
    _keys = List.generate(
      widget.textLines.length,
      (_) => GlobalKey(),
      growable: false,
    );
    _sizes = List<Size>.filled(widget.textLines.length, Size.zero);
    _isInitialized = false;
  }

  void _schedulePostFrameCallback() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureTextSizes());
  }

  void _measureTextSizes() {
    if (!mounted) return;

    bool hasChanges = false;
    final newSizes = <Size>[];

    for (int i = 0; i < _keys.length; i++) {
      final renderBox =
          _keys[i].currentContext?.findRenderObject() as RenderBox?;
      final size = renderBox?.size ?? Size.zero;
      newSizes.add(size);

      if (_sizes[i] != size) {
        hasChanges = true;
      }
    }

    if (hasChanges) {
      setState(() {
        _sizes = newSizes;
        _isInitialized = true;
      });
    }
  }

  /// Determines the cross-axis alignment based on text alignment.
  CrossAxisAlignment _getCrossAxisAlignment() {
    return widget.textAlign == TextAlign.center
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
  }

  /// Builds a single underlined text item.
  Widget _buildUnderlinedTextItem(int index, AppDesignSystem ds) {
    final textSize = _sizes[index];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Underline positioned behind the text
        if (_isInitialized && textSize.width > 0)
          _buildUnderline(index, textSize, ds),
        // Text widget
        _buildTextWidget(index),
      ],
    );
  }

  /// Builds the underline widget for a text item.
  Widget _buildUnderline(int index, Size textSize, AppDesignSystem ds) {
    const double topPositionRatio = 0.57;
    const double defaultThicknessRatio = 0.35;
    const double widthRatio = 0.96;

    return Positioned(
      top: topPositionRatio * textSize.height,
      left: ds.spacing.s,
      child: Container(
        height:
            widget.lineThickness ?? (defaultThicknessRatio * textSize.height),
        width: textSize.width * widthRatio,
        color: widget.lineColor,
      ),
    );
  }

  /// Builds the text widget for a text item.
  Widget _buildTextWidget(int index) {
    return CustomText(
      key: _keys[index],
      text: widget.textLines[index],
      style: widget.style,
      color: widget.color,
      textAlign: widget.textAlign,
      fontWeight: widget.fontWeight,
      fontSize: widget.fontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: _getCrossAxisAlignment(),
      spacing: widget.gutter ?? 0.0,
      children: List.generate(
        widget.textLines.length,
        (index) => _buildUnderlinedTextItem(index, ds),
      ),
    );
  }
}
