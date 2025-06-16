import 'package:flutter/widgets.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

class CustomRadioButton extends StatefulWidget {
  final bool selected;
  final void Function(bool value)? onChanged;

  const CustomRadioButton({super.key, this.selected = false, this.onChanged});

  @override
  CustomRadioButtonState createState() => CustomRadioButtonState();
}

class CustomRadioButtonState extends State<CustomRadioButton> {
  late bool _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(CustomRadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      _selected = widget.selected;
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
                  _selected = !_selected;
                });
                widget.onChanged!(_selected);
              }
              : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: Container(
          width: ds.spacing.l,
          height: ds.spacing.l,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ds.colors.primary.shade500, width: 1),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastEaseInToSlowEaseOut,
              opacity: _selected ? 1 : 0,
              child: AnimatedScale(
                scale: _selected ? 1 : .8,
                duration: const Duration(milliseconds: 100),
                curve: Curves.fastEaseInToSlowEaseOut,
                child: Center(
                  child: Container(
                    width: .65 * ds.spacing.l,
                    height: .65 * ds.spacing.l,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ds.colors.primary.shade500.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
