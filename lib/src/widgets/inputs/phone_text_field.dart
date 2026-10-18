import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

import 'text_field.dart';

/// Phone input with the fixed French "+33" box in front of the number field.
class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final String? errorText;

  const PhoneTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 1.5 * ds.spacing.xs,
      children: [
        CustomText(
          text: labelText,
          style: CustomTextStyle.captionM,
          fontWeight: FontWeight.w500,
          color: ds.colors.shade.shade700,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3 * ds.spacing.xs,
          children: [
            Container(
              height: 13 * ds.spacing.xs,
              padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: ds.borderRadii.radiusS,
                border: Border.all(color: ds.colors.shade.shade200),
              ),
              alignment: Alignment.center,
              // ponytail: France only; swap for a country picker if the app opens abroad.
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: ds.spacing.s,
                children: [
                  const Text('🇫🇷', style: TextStyle(fontSize: 20)),
                  CustomText(
                    text: '+33',
                    style: CustomTextStyle.bodyS,
                    fontWeight: FontWeight.w600,
                    color: ds.colors.primary.shade900,
                  ),
                ],
              ),
            ),
            Expanded(
              child: CustomTextField(
                controller: controller,
                focusNode: focusNode,
                labelText: '',
                hintText: hintText,
                errorText: errorText,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
