import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

/// Grey box of rules with a green tick for the met ones (password rules).
class ChecklistBox extends StatelessWidget {
  final List<(String label, bool isMet)> items;

  const ChecklistBox({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3 * ds.spacing.xs),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: ds.borderRadii.radiusS,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.s,
        children: [
          for (final (label, isMet) in items)
            Row(
              spacing: ds.spacing.s,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: ds.spacing.l,
                  height: ds.spacing.l,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isMet
                            ? const Color(0xffE6F4EA)
                            : const Color(0xffE2E8F0),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 2.5 * ds.spacing.xs,
                    color:
                        isMet
                            ? const Color(0xff10B981)
                            : const Color(0xff94A3B8),
                  ),
                ),
                CustomText(
                  text: label,
                  style: CustomTextStyle.captionM,
                  fontWeight: FontWeight.w500,
                  color:
                      isMet
                          ? ds.colors.primary.shade900
                          : ds.colors.shade.shade600,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
