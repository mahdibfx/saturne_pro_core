import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

/// Six 52px boxes; the focused one gets the brand-yellow border.
class OtpTextField extends StatelessWidget {
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

  const OtpTextField({super.key, this.onCompleted, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    const yellow = Color(0xffFFC400);
    final gap = 1.5 * ds.spacing.xs;
    return LayoutBuilder(
      builder: (context, constraints) {
        // 52px boxes, shrunk to fit narrow screens.
        final box = ((constraints.maxWidth - 5 * gap) / 6).clamp(
          0.0,
          13 * ds.spacing.xs,
        );
        PinTheme theme(Color border, double width, Color text) => PinTheme(
          width: box,
          height: box,
          textStyle: ds.typography.headingL.copyWith(
            fontWeight: FontWeight.w600,
            color: text,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: border, width: width),
            borderRadius: ds.borderRadii.radiusM,
          ),
        );

        return Pinput(
          defaultPinTheme: theme(
            const Color(0xffEDEDF2),
            1,
            ds.colors.primary.shade900,
          ),
          focusedPinTheme: theme(yellow, 2, yellow),
          submittedPinTheme: theme(
            ds.colors.shade.shade200,
            1,
            ds.colors.primary.shade900,
          ),
          length: 6,
          separatorBuilder: (_) => SizedBox(width: gap),
          pinputAutovalidateMode: PinputAutovalidateMode.disabled,
          pinAnimationType: PinAnimationType.scale,
          showCursor: true,
          onCompleted: onCompleted,
          onChanged: onChanged,
        );
      },
    );
  }
}
