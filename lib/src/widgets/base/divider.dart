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
            style: CustomTextStyle.bodyS,
            fontWeight: FontWeight.w500,
            color: const Color(0xff4F6262),
          ),
        ],
        if (trailingWidget != null) ...[trailingWidget!],
        Expanded(child: Divider(thickness: 1, color: const Color(0xffE4E9E9))),
      ],
    );
  }
}
