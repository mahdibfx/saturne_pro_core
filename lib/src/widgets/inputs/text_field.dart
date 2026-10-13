import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

/// Tellot input: label above a white 52px field with a 1px border.
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final String? errorText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? suffixWidget;
  final IconData? prefixIcon;
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
    this.prefixIcon,
    this.maxLength,
    this.readOnly = false,
    this.onChanged,
    this.onSuffixWidgetTapped,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  void _rebuild() => setState(() {});

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_rebuild);
    widget.controller.addListener(_rebuild);
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      oldWidget.focusNode.removeListener(_rebuild);
      widget.focusNode.addListener(_rebuild);
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_rebuild);
      widget.controller.addListener(_rebuild);
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_rebuild);
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  bool get _hasError => widget.errorText != null;

  Color _borderColor(AppDesignSystem ds) {
    if (_hasError) return ds.colors.danger.shade500;
    if (widget.focusNode.hasFocus) return ds.colors.primary.shade500;
    return ds.colors.shade.shade200;
  }

  Widget _buildSuffixWidget(AppDesignSystem ds) {
    final suffix = widget.suffixWidget!;
    final Widget child = switch (suffix) {
      Icon() => Icon(
        suffix.icon,
        size: suffix.size ?? 5 * ds.spacing.xs,
        color: _hasError ? ds.colors.danger.shade500 : ds.colors.shade.shade500,
      ),
      PillButton() => PillButton(
        label: suffix.label,
        color: _hasError ? ds.colors.danger.shade500 : suffix.color,
        onTap: suffix.onTap,
      ),
      _ => suffix,
    };
    if (widget.onSuffixWidgetTapped == null) return child;
    return GestureDetector(onTap: widget.onSuffixWidgetTapped, child: child);
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    final textStyle = ds.typography.bodyS.copyWith(
      fontWeight: FontWeight.w400,
      height: 20 / 14,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 1.5 * ds.spacing.xs,
      children: [
        if (widget.labelText.isNotEmpty)
          CustomText(
            text: widget.labelText,
            style: CustomTextStyle.captionM,
            fontWeight: FontWeight.w500,
            color: ds.colors.shade.shade700,
          ),
        GestureDetector(
          onTap: widget.focusNode.requestFocus,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 13 * ds.spacing.xs,
            padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
            decoration: BoxDecoration(
              color: widget.readOnly ? ds.colors.shade.shade50 : Colors.white,
              borderRadius: ds.borderRadii.radiusS,
              border: Border.all(color: _borderColor(ds)),
            ),
            child: Row(
              spacing: ds.spacing.s,
              children: [
                if (widget.prefixIcon != null)
                  Icon(
                    widget.prefixIcon,
                    size: 5 * ds.spacing.xs,
                    color: ds.colors.shade.shade400,
                  ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    maxLength: widget.maxLength,
                    onChanged: widget.onChanged,
                    cursorColor: ds.colors.primary.shade500,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.isPassword,
                    readOnly: widget.readOnly,
                    buildCounter:
                        (
                          _, {
                          required currentLength,
                          required isFocused,
                          maxLength,
                        }) => null,
                    style: textStyle.copyWith(
                      color: ds.colors.primary.shade900,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hintText,
                      hintStyle: textStyle.copyWith(
                        color: ds.colors.shade.shade400,
                      ),
                    ),
                  ),
                ),
                if (widget.suffixWidget != null) _buildSuffixWidget(ds),
              ],
            ),
          ),
        ),
        if (_hasError || widget.maxLength != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: ds.spacing.s,
            children: [
              if (_hasError)
                Flexible(
                  child: CustomText(
                    text: widget.errorText!,
                    color: ds.colors.danger.shade500,
                    fontWeight: FontWeight.w500,
                    style: CustomTextStyle.captionM,
                    maxLines: 3,
                  ),
                )
              else
                const SizedBox.shrink(),
              if (widget.maxLength != null)
                CustomText(
                  text:
                      '${widget.controller.text.length} / ${widget.maxLength}',
                  color: ds.colors.shade.shade500,
                  fontWeight: FontWeight.w500,
                  style: CustomTextStyle.captionM,
                ),
            ],
          ),
      ],
    );
  }
}
