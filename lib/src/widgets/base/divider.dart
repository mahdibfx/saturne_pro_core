import 'package:flutter/material.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';

class CustomDivider extends StatelessWidget {
  final String? label;
  final Widget? trailingWidget;

  const CustomDivider({super.key, this.label, this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Row(
      spacing: 3 * ds.spacing.xs,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (label != null) ...[
          CustomText(
            text: label!,
            style: CustomTextStyle.bodyL,
            fontWeight: FontWeight.w400,
            color: ds.colors.primary.shade900.withValues(alpha: .5),
          ),
        ],
        if (trailingWidget != null) ...[trailingWidget!],
        Expanded(
          child: Divider(
            thickness: .5,
            color: ds.colors.primary.shade500.withValues(alpha: .2),
          ),
        ),
      ],
    );
  }
}
