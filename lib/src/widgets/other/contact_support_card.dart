import 'package:flutter/widgets.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/widgets.dart';

/// A card widget that displays contact support information with a call-to-action button.
///
/// This widget is typically used to show contact information and provide a way for users
/// to get support or contact the support team.
class ContactSupportCard extends StatelessWidget {
  /// The main contact information text to be displayed.
  final String contactInfoLabel;

  /// The context or description text for the contact information.
  final String contactInfoContextLabel;

  /// The text to be displayed on the call-to-action button.
  final String ctaLabel;

  /// Callback function triggered when the CTA button is pressed.
  final VoidCallback onCtaPressed;

  /// Creates a contact support card.
  ///
  /// All parameters are required and must not be null.
  const ContactSupportCard({
    super.key,
    required this.contactInfoLabel,
    required this.contactInfoContextLabel,
    required this.ctaLabel,
    required this.onCtaPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return CustomCard(
      padding: EdgeInsets.all(ds.spacing.l),
      border: Border.all(
        width: .2,
        color: ds.colors.primary.shade500.withValues(alpha: .2),
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: ds.spacing.xs / 10,
              children: [
                CustomText(
                  text: contactInfoContextLabel,
                  style: CustomTextStyle.captionM,
                  color: ds.colors.primary.shade900.withValues(alpha: .5),
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: contactInfoLabel,
                  style: CustomTextStyle.bodyL,
                  color: ds.colors.primary.shade500,
                ),
              ],
            ),
          ),
          PillButton(
            label: ctaLabel,
            color: ds.colors.secondary.shade500,
            onTap: onCtaPressed,
          ),
        ],
      ),
    );
  }
}
