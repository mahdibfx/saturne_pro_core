import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/assets/assets.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

class CustomCheckBox extends StatefulWidget {
  final bool checked;
  final void Function(bool value)? onChanged;
  final bool isCircularShaped;

  const CustomCheckBox({
    super.key,
    this.checked = false,
    this.isCircularShaped = false,
    this.onChanged,
  });

  @override
  CustomCheckBoxState createState() => CustomCheckBoxState();
}

class CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.checked;
  }

  @override
  void didUpdateWidget(CustomCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checked != oldWidget.checked) {
      _checked = widget.checked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    final isEnabled = widget.onChanged != null;
    return GestureDetector(
      onTap:
          isEnabled
              ? () {
                setState(() {
                  _checked = !_checked;
                });
                widget.onChanged!(_checked);
              }
              : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastEaseInToSlowEaseOut,
          width: ds.spacing.l,
          height: ds.spacing.l,
          decoration: BoxDecoration(
            color:
                _checked
                    ? ds.colors.primary.shade500.withValues(alpha: 0.8)
                    : Colors.transparent,
            shape:
                widget.isCircularShaped ? BoxShape.circle : BoxShape.rectangle,
            borderRadius:
                widget.isCircularShaped
                    ? null
                    : BorderRadius.circular(.75 * ds.spacing.xs),
            border: Border.all(color: ds.colors.primary.shade500, width: 1),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastEaseInToSlowEaseOut,
              opacity: _checked ? 1 : 0,
              child: AnimatedScale(
                scale: _checked ? 1 : .6,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastEaseInToSlowEaseOut,
                child: Icon(
                  SaturneProIcons.check,
                  size: 1.8 * ds.spacing.s,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
