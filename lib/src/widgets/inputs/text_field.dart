import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final String? errorText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? suffixWidget;
  final Function()? onSuffixWidgetTapped;
  final int? maxLength;
  final bool readOnly;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    this.errorText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.suffixWidget,
    this.maxLength,
    this.readOnly = false,
    this.onChanged,
    this.onSuffixWidgetTapped,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hasError = false;
  final _labelKey = GlobalKey();
  double labelWidth = .0;
  int? _counter;

  bool get _shouldShowFloatingLabel =>
      widget.focusNode.hasFocus || widget.controller.text.isNotEmpty;

  void setHasError(bool value) {
    if (_hasError != value) {
      setState(() {
        _hasError = value;
      });
    }
  }

  void _handleFocusChange() {
    setState(() {});
  }

  void _handleTextChanged(String value) {
    final newCounter = value.length;
    if (_counter != newCounter) {
      setState(() {
        _counter = newCounter;
      });
    }
    widget.onChanged?.call(value);
  }

  void _getLabelWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _labelKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final newWidth = renderBox.size.width;
        if (labelWidth != newWidth) {
          setState(() {
            labelWidth = newWidth;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
    _hasError = widget.errorText != null;
    _counter = widget.controller.text.length;
    _getLabelWidth();
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only update error state if it changed
    if (widget.errorText != oldWidget.errorText) {
      setHasError(widget.errorText != null);
    }

    // Only measure label width if label text changed
    if (widget.labelText != oldWidget.labelText) {
      _getLabelWidth();
    }

    // Update counter if maxLength changed
    if (widget.maxLength != oldWidget.maxLength) {
      _counter = widget.controller.text.length;
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  Color _getFillColor(AppDesignSystem ds) {
    return _hasError
        ? ds.colors.danger.shade400.withValues(alpha: .03)
        : ds.colors.primary.shade50;
  }

  Border _getBorder(AppDesignSystem ds) {
    Border defaultBorder = Border.all(
      color: ds.colors.primary.shade500.withValues(alpha: .05),
      width: .2,
      strokeAlign: BorderSide.strokeAlignOutside,
    );

    Border focusedBorder = Border.all(
      color: ds.colors.primary.shade500.withValues(alpha: .6),
      width: 1.0,
      strokeAlign: BorderSide.strokeAlignOutside,
    );

    Border errorBorder = Border.all(
      color: ds.colors.danger.shade400.withValues(alpha: .6),
      width: 1.0,
      strokeAlign: BorderSide.strokeAlignOutside,
    );

    Border focusedErrorBorder = Border.all(
      color: ds.colors.danger.shade400.withValues(alpha: .05),
      width: .2,
      strokeAlign: BorderSide.strokeAlignOutside,
    );

    if (_hasError && !widget.focusNode.hasFocus) return focusedErrorBorder;
    if (_hasError) return errorBorder;
    if (widget.focusNode.hasFocus) return focusedBorder;

    return defaultBorder;
  }

  Color _getLabelTextColor(AppDesignSystem ds) {
    return _hasError ? ds.colors.danger.shade400 : ds.colors.primary.shade500;
  }

  Color _getVerticalDividerColor(AppDesignSystem ds) {
    return _hasError
        ? ds.colors.danger.shade400.withValues(alpha: .1)
        : ds.colors.primary.shade500.withValues(alpha: .1);
  }

  Color _getHintTextColor(AppDesignSystem ds) {
    return _hasError
        ? ds.colors.danger.shade400.withValues(alpha: .3)
        : ds.colors.primary.shade500.withValues(alpha: .3);
  }

  Widget _buildSuffixWidget(AppDesignSystem ds) {
    if (widget.suffixWidget == null) return const SizedBox.shrink();

    final suffixWidget = widget.suffixWidget!;

    if (suffixWidget is Icon) {
      return Icon(
        suffixWidget.icon,
        size: suffixWidget.size,
        color: _getLabelTextColor(ds),
      );
    } else if (suffixWidget is PillButton) {
      return PillButton(
        label: suffixWidget.label,
        color: _hasError ? ds.colors.danger.shade400 : suffixWidget.color,
        onTap: suffixWidget.onTap,
      );
    } else {
      return suffixWidget;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: ds.spacing.s,
      children: [
        RepaintBoundary(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn,
            padding: EdgeInsets.symmetric(
              vertical: ds.spacing.l,
              horizontal: ds.spacing.l + .75 * ds.spacing.xs,
            ),
            decoration: BoxDecoration(
              borderRadius: ds.borderRadii.radiusS,
              color: _getFillColor(ds),
              border: _getBorder(ds),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.none,
                    fit: StackFit.loose,
                    children: [
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastLinearToSlowEaseIn,
                        offset:
                            !_shouldShowFloatingLabel
                                ? Offset.zero
                                : const Offset(0, -1.35),
                        child: GestureDetector(
                          onTap: () => widget.focusNode.requestFocus(),
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              key: _labelKey,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RepaintBoundary(
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    alignment: Alignment.centerLeft,
                                    scale: !_shouldShowFloatingLabel ? 1.0 : .8,
                                    child: RepaintBoundary(
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 400,
                                        ),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        padding: EdgeInsets.only(
                                          right: ds.spacing.xs / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha:
                                                widget.focusNode.hasFocus
                                                    ? 1.0
                                                    : .0,
                                          ),
                                          borderRadius:
                                              ds.borderRadii.radiusFull,
                                        ),
                                        foregroundDecoration: BoxDecoration(
                                          color:
                                              widget.focusNode.hasFocus
                                                  ? _getFillColor(
                                                    ds,
                                                  ).withValues(alpha: .01)
                                                  : Colors.transparent,
                                          borderRadius:
                                              ds.borderRadii.radiusFull,
                                        ),
                                        child: CustomText(
                                          text: widget.labelText,
                                          style: CustomTextStyle.bodyL,
                                          color: _getLabelTextColor(ds),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (!_shouldShowFloatingLabel) ...[
                                  CustomGap(gapSize: GapSize.l),
                                  SizedBox(
                                    height: ds.spacing.l + 1.8 * ds.spacing.xs,
                                    child: VerticalDivider(
                                      thickness: 1.0,
                                      width: 1.0,
                                      color: _getVerticalDividerColor(ds),
                                    ),
                                  ),
                                  CustomGap(gapSize: GapSize.l),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastLinearToSlowEaseIn,
                        left: _shouldShowFloatingLabel ? .0 : labelWidth,
                        right: 0,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SizedBox(
                              width: constraints.maxWidth,
                              child: TextField(
                                controller: widget.controller,
                                focusNode: widget.focusNode,
                                maxLength: widget.maxLength,
                                onChanged: _handleTextChanged,
                                cursorColor: _getLabelTextColor(ds),
                                keyboardType: widget.keyboardType,
                                obscureText: widget.isPassword,
                                readOnly: widget.readOnly,
                                buildCounter: (
                                  BuildContext context, {
                                  required int currentLength,
                                  required int? maxLength,
                                  required bool isFocused,
                                }) {
                                  _counter = currentLength;
                                  return null;
                                },
                                style: ds.typography.bodyL.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: ds.colors.primary.shade500,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: widget.hintText,
                                  hintFadeDuration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  hintStyle: ds.typography.bodyL.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: _getHintTextColor(ds),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.suffixWidget != null) _buildSuffixWidget(ds),
              ],
            ),
          ),
        ),

        if (_hasError || widget.maxLength != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ds.spacing.s),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: ds.spacing.s,
              children: [
                if (_hasError)
                  Flexible(
                    child: CustomText(
                      text: widget.errorText!,
                      color: ds.colors.danger.shade400,
                      fontWeight: FontWeight.w500,
                      style: CustomTextStyle.bodyS,
                      maxLines: 3,
                    ),
                  )
                else
                  const SizedBox.shrink(),

                if (widget.maxLength != null)
                  CustomText(
                    text: '$_counter / ${widget.maxLength}',
                    color: _getLabelTextColor(ds),
                    fontWeight: FontWeight.w500,
                    style: CustomTextStyle.bodyS,
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
