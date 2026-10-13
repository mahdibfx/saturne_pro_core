import 'package:flutter/widgets.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../widgets.dart';

/// A widget that displays a section header with a bold title and optional description.
///
/// This widget provides a consistent way to display section headers throughout the app,
/// with support for multi-line titles, optional descriptions, and center alignment.
class SectionHeader extends StatelessWidget {
  /// The title, joined into one wrapping paragraph.
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

  /// Lines are joined and left to wrap; the Tellot title has no underline.
  Widget _buildTitle(AppDesignSystem ds) {
    return CustomText(
      text: titleLines.join(' '),
      style: isSmall ? CustomTextStyle.headingL : CustomTextStyle.displayL,
      color: ds.colors.primary.shade900,
      fontWeight: FontWeight.w700,
      textAlign: _getTextAlignment(),
      maxLines: 4,
    );
  }

  Widget _buildDescription(AppDesignSystem ds) {
    return CustomText(
      text: description!,
      textAlign: _getTextAlignment(),
      maxLines: 5,
      style: CustomTextStyle.bodyS,
      fontWeight: FontWeight.w400,
      color: ds.colors.shade.shade600,
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
