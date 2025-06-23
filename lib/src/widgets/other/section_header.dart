import 'package:flutter/widgets.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../widgets.dart';

/// A widget that displays a section header with an underlined title and optional description.
///
/// This widget provides a consistent way to display section headers throughout the app,
/// with support for multi-line titles, optional descriptions, and center alignment.
class SectionHeader extends StatelessWidget {
  /// The list of text lines for the title. Each line will be underlined.
  final List<String> titleLines;

  /// Optional description text displayed below the title.
  final String? description;

  /// Whether the header should be center-aligned. Defaults to false (left-aligned).
  final bool isCenteredAligned;

  final bool isSmall;

  const SectionHeader({
    super.key,
    required this.titleLines,
    this.description,
    this.isCenteredAligned = false,
    this.isSmall = false,
  }) : assert(titleLines.length > 0, 'titleLines cannot be empty');

  /// Determines the cross-axis alignment based on the centered alignment flag.
  CrossAxisAlignment _getCrossAxisAlignment() {
    return isCenteredAligned
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
  }

  /// Determines the text alignment based on the centered alignment flag.
  TextAlign _getTextAlignment() {
    return isCenteredAligned ? TextAlign.center : TextAlign.start;
  }

  /// Builds the underlined title widget.
  Widget _buildTitle(AppDesignSystem ds) {
    return UnderlinedText(
      textLines: titleLines,
      lineColor: ds.colors.secondary.shade500.withValues(alpha: .2),
      style: isSmall ? CustomTextStyle.headingM : CustomTextStyle.headingXL,
      color: ds.colors.primary.shade900,
      lineThickness: .76 * ds.spacing.l,
      fontWeight: FontWeight.w700,
      textAlign: _getTextAlignment(),
    );
  }

  /// Builds the description text widget.
  Widget _buildDescription(AppDesignSystem ds) {
    return CustomText(
      text: description!,
      textAlign: _getTextAlignment(),
      maxLines: 5,
      style: isSmall ? CustomTextStyle.captionM : CustomTextStyle.bodyL,
      fontWeight: FontWeight.w300,
      color: ds.colors.primary.shade900.withValues(alpha: .8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return SizedBox(
      key: key,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: _getCrossAxisAlignment(),
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: ds.spacing.s,
        children: [
          _buildTitle(ds),
          if (description != null) _buildDescription(ds),
        ],
      ),
    );
  }
}
