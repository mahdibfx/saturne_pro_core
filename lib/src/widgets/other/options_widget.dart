import 'package:flutter/material.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/text.dart';
import 'package:saturne_pro_core/src/widgets/inputs/radio_button.dart';

enum OptionsWidgetType { selectable, nonSelectable }

class OptionsWidget extends StatelessWidget {
  final IconData? leadingIcon;
  final Widget? leadingChild;
  final BoxDecoration? leadingBoxDecoration;
  final String title;
  final String? flagLabel;
  final Widget? trailingWidget;
  final bool titleOnTopOfFlagLabel;
  final OptionsWidgetType type;
  final bool selected;
  final void Function(bool value)? onChanged;
  final bool showDefaultArrowTrailingWidget;
  final VoidCallback? onTap;

  const OptionsWidget({
    super.key,
    this.leadingIcon,
    this.leadingChild,
    this.leadingBoxDecoration,
    required this.title,
    this.flagLabel,
    this.trailingWidget,
    this.titleOnTopOfFlagLabel = false,
    required this.type,
    this.selected = false,
    this.onChanged,
    this.showDefaultArrowTrailingWidget = true,
    this.onTap,
  });

  /// Creates a selectable OptionsWidget with radio button functionality
  const OptionsWidget.selectable({
    super.key,
    this.leadingIcon,
    this.leadingChild,
    this.leadingBoxDecoration,
    required this.title,
    this.flagLabel,
    this.titleOnTopOfFlagLabel = false,
    this.selected = false,
    this.onChanged,
  }) : type = OptionsWidgetType.selectable,
       trailingWidget = null,
       showDefaultArrowTrailingWidget = false,
       onTap = null;

  /// Creates a non-selectable OptionsWidget
  const OptionsWidget.nonSelectable({
    super.key,
    this.leadingIcon,
    this.leadingChild,
    this.leadingBoxDecoration,
    required this.title,
    this.flagLabel,
    this.trailingWidget,
    this.titleOnTopOfFlagLabel = false,
    this.showDefaultArrowTrailingWidget = true,
    this.onTap,
  }) : type = OptionsWidgetType.nonSelectable,
       selected = false,
       onChanged = null;

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    // Determine the trailing widget based on type
    Widget? finalTrailingWidget;
    if (type == OptionsWidgetType.selectable) {
      finalTrailingWidget = CustomRadioButton(
        selected: selected,
        onChanged: onChanged,
      );
    } else {
      // For non-selectable, use provided trailing widget or default arrow icon (if showDefaultArrow is true)
      finalTrailingWidget =
          trailingWidget ??
          (showDefaultArrowTrailingWidget
              ? Container(
                padding: EdgeInsets.only(
                  left: ds.spacing.s,
                  top: ds.spacing.xs,
                  bottom: ds.spacing.xs,
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: ds.colors.shade.shade500,
                  size: 5 * ds.spacing.xs,
                ),
              )
              : null);
    }

    return GestureDetector(
      onTap:
          type == OptionsWidgetType.selectable && onChanged != null
              ? () => onChanged!(!selected)
              : onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: .875 * ds.spacing.l,
                children: [
                  if (leadingIcon != null || leadingChild != null)
                    if (leadingChild is Image)
                      // Tellot glass icons already carry their own circle.
                      SizedBox.square(
                        dimension: 12 * ds.spacing.xs,
                        child: leadingChild,
                      )
                    else
                      Container(
                        height: 10 * ds.spacing.xs,
                        width: 10 * ds.spacing.xs,
                        decoration: BoxDecoration(
                          color: leadingBoxDecoration?.color ?? Colors.white,
                          border:
                              leadingBoxDecoration?.border ??
                              Border.all(color: ds.colors.shade.shade200),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(ds.spacing.s),
                        child:
                            leadingChild ??
                            Icon(
                              leadingIcon!,
                              color: ds.colors.primary.shade900,
                              size: 5 * ds.spacing.xs,
                            ),
                      ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (titleOnTopOfFlagLabel)
                          CustomText(
                            text: title,
                            style: CustomTextStyle.bodyM,
                            fontWeight: FontWeight.w600,
                            color: ds.colors.primary.shade900,
                            maxLines: 2,
                          ),
                        if (flagLabel != null)
                          CustomText(
                            text: flagLabel!,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                titleOnTopOfFlagLabel
                                    ? ds.colors.shade.shade600
                                    : ds.colors.shade.shade400,
                            maxLines: 2,
                          ),
                        if (!titleOnTopOfFlagLabel)
                          CustomText(
                            text: title,
                            style: CustomTextStyle.bodyM,
                            fontWeight: FontWeight.w500,
                            color: ds.colors.primary.shade900,
                            maxLines: 2,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (finalTrailingWidget != null) finalTrailingWidget,
          ],
        ),
      ),
    );
  }
}
