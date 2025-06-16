import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

class OtpTextField extends StatelessWidget {
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

  const OtpTextField({super.key, this.onCompleted, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Pinput(
      defaultPinTheme: PinTheme(
        width: 1.64 * ds.spacing.xl,
        height: 1.5 * ds.spacing.xl,
        textStyle: ds.typography.bodyL.copyWith(
          color: ds.colors.primary.shade900,
        ),
        decoration: BoxDecoration(
          color: ds.colors.primary.shade50,
          border: Border.all(
            color: ds.colors.primary.shade500.withValues(alpha: .3),
            width: .2,
          ),
          borderRadius: ds.borderRadii.radiusS,
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 1.64 * ds.spacing.xl,
        height: 1.5 * ds.spacing.xl,
        textStyle: ds.typography.bodyL.copyWith(
          color: ds.colors.primary.shade900,
        ),
        decoration: BoxDecoration(
          color: ds.colors.primary.shade50,
          border: Border.all(
            color: ds.colors.primary.shade500.withValues(alpha: .6),
            width: 1,
          ),
          borderRadius: ds.borderRadii.radiusS,
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 1.64 * ds.spacing.xl,
        height: 1.5 * ds.spacing.xl,
        textStyle: ds.typography.headingM.copyWith(
          color: ds.colors.primary.shade900,
        ),
        decoration: BoxDecoration(
          color: ds.colors.primary.shade100,
          border: Border.all(
            color: ds.colors.primary.shade500.withValues(alpha: .6),
            width: .2,
          ),
          borderRadius: ds.borderRadii.radiusS,
        ),
      ),
      length: 6,
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
      pinAnimationType: PinAnimationType.scale,
      showCursor: true,
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}
