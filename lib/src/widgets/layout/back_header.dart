import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../widgets.dart';

/// Tellot screen header: "‹ Retour" on the left and, in multi-step flows,
/// a green progress bar with "Étape n/N" on the right.
class BackHeader extends StatelessWidget {
  final VoidCallback onBackTapped;

  /// 1-based current step; the progress is hidden when [stepCount] is null.
  final int step;
  final int? stepCount;

  /// Shown on the right instead of "Étape n/N".
  final Widget? trailing;

  const BackHeader({
    super.key,
    required this.onBackTapped,
    this.step = 1,
    this.stepCount,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    final total = stepCount;
    final isFrench = Localizations.localeOf(context).languageCode == 'fr';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 6 * ds.spacing.xs,
        vertical: ds.spacing.s,
      ),
      child: SizedBox(
        height: 8 * ds.spacing.xs,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onBackTapped,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: ds.spacing.xs,
                    children: [
                      Icon(
                        Icons.chevron_left_rounded,
                        size: 5 * ds.spacing.xs,
                        color: ds.colors.primary.shade500,
                      ),
                      CustomText(
                        text:
                            MaterialLocalizations.of(context).backButtonTooltip,
                        style: CustomTextStyle.bodyM,
                        fontWeight: FontWeight.w600,
                        color: ds.colors.primary.shade500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (total != null)
              ClipRRect(
                borderRadius: ds.borderRadii.radiusFull,
                child: SizedBox(
                  width: 20 * ds.spacing.xs,
                  height: ds.spacing.s,
                  child: LinearProgressIndicator(
                    value: step / total,
                    backgroundColor: const Color(0xffF1F3F3),
                    color: const Color(0xff47C47D),
                  ),
                ),
              ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child:
                    trailing ??
                    (total == null
                        ? const SizedBox.shrink()
                        : CustomText(
                          text: '${isFrench ? 'Étape' : 'Step'} $step/$total',
                          style: CustomTextStyle.bodyS,
                          fontWeight: FontWeight.w700,
                          color: ds.colors.shade.shade600,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
