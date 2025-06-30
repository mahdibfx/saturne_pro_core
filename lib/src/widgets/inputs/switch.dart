import 'package:flutter/cupertino.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

class CustomSwitch extends StatefulWidget {
  final bool initialValue;
  final void Function(bool value)? onChanged;

  const CustomSwitch({super.key, this.initialValue = false, this.onChanged});

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    final isEnabled = widget.onChanged != null;
    return Transform.scale(
      scale: .9,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap:
            isEnabled
                ? () {
                  setState(() {
                    _value = !_value;
                  });
                  widget.onChanged!(_value);
                }
                : null,
        child: Opacity(
          opacity: isEnabled ? 1.0 : 0.5,
          child: CupertinoSwitch(
            value: _value,
            onChanged:
                isEnabled
                    ? (value) {
                      setState(() {
                        _value = value;
                      });
                      widget.onChanged!(value);
                    }
                    : null,
            inactiveTrackColor: ds.colors.shade.shade50,
            activeTrackColor: ds.colors.secondary.shade500,
          ),
        ),
      ),
    );
  }
}
