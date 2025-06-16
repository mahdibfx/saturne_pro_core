import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';
import 'package:saturne_pro_core/src/assets/assets.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

/// A widget that displays a file upload container with a dotted border.
///
/// This widget provides a user interface for uploading files, either by selecting
/// from local storage or by taking a picture. It displays an illustration and
/// informational text about allowed file types, along with two action buttons.
///
/// The container has a dotted border and uses the app's design system for styling.
///
/// Example usage:
/// ```dart
/// UploadFileContainer(
///   onSelectFromLocalFilesTapped: () => _pickFile(),
///   onTakeAPicTapped: () => _takePicture(),
///   label: 'Allowed file extensions (PDF, JPEG, JPG, PNG)',
/// )
/// ```
class UploadFileContainer extends StatelessWidget {
  /// Callback function triggered when the "Select from files" button is tapped.
  final Function() onSelectFromLocalFilesTapped;

  /// Callback function triggered when the "Take a picture" button is tapped.
  final Function() onTakeAPicTapped;

  /// Optional text to display as information about allowed file types.
  /// Defaults to "extensions de fichiers autorisées (PDF, JPEG, JPG, PNG)" if not provided.
  final String? label;

  /// Optional text to display on the "Select from files" button.
  /// Defaults to "Sélectionner parmi les fichiers" if not provided.
  final String? selectFromLocalFilesLabel;

  /// Optional text to display on the "Take a picture" button.
  /// Defaults to "Prenez une photo" if not provided.
  final String? takeAPicLabel;

  /// Creates an [UploadFileContainer] widget.
  ///
  /// The [onSelectFromLocalFilesTapped] and [onTakeAPicTapped] parameters are required
  /// and define the actions to perform when the respective buttons are tapped.
  ///
  /// The [label], [selectFromLocalFilesLabel], and [takeAPicLabel] parameters are optional
  /// and can be used to customize the text displayed in the widget.
  const UploadFileContainer({
    super.key,
    required this.onSelectFromLocalFilesTapped,
    required this.onTakeAPicTapped,
    this.label,
    this.selectFromLocalFilesLabel,
    this.takeAPicLabel,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: [4, 4],
        strokeWidth: 1,
        color: ds.colors.secondary.shade500,
        padding: EdgeInsets.zero,
        radius: Radius.circular(ds.spacing.xs + ds.spacing.s),
      ),
      child: CustomCard(
        padding: EdgeInsets.symmetric(
          vertical: ds.spacing.xl,
          horizontal: ds.spacing.s,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: .875 * ds.spacing.xl,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: .75 * ds.spacing.xl,
              children: [
                Image.asset(
                  SaturneProImages.uploadFileIllustration,
                  package: packageName,
                  height: 2.34 * ds.spacing.xl,
                ),
                CustomText(
                  text:
                      label ??
                      "extensions de fichiers autorisées\n(PDF, JPEG, JPG, PNG)",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.bodyS,
                  fontWeight: FontWeight.w400,
                  color: ds.colors.primary.shade900.withValues(alpha: .3),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: .75 * ds.spacing.l,
              children: [
                PillButton(
                  size: PillButtonSize.normal,
                  label:
                      selectFromLocalFilesLabel ??
                      'Sélectionner parmi les fichiers',
                  color: ds.colors.secondary.shade500,
                  onTap: onSelectFromLocalFilesTapped,
                ),
                PillButton(
                  size: PillButtonSize.normal,
                  label: takeAPicLabel ?? 'Prenez une photo',
                  color: ds.colors.secondary.shade500,
                  onTap: onSelectFromLocalFilesTapped,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
