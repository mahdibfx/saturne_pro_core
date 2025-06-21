import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/assets/icons.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../widgets.dart';

class CustomAppBar extends StatefulWidget {
  final String? title;
  final String? subLabel;
  final VoidCallback onBackTapped;
  final Widget? trailingWidget;
  final Color? backgroundColor;
  final Widget? child;
  final double? height;
  final bool useSafeArea;

  const CustomAppBar({
    super.key,
    this.title,
    required this.onBackTapped,
    this.subLabel,
    this.trailingWidget,
    this.backgroundColor,
    this.child,
    this.height,
    this.useSafeArea = true,
  }) : assert(
         (title == null && child == null) ||
             (title != null && child == null) ||
             (title == null && child != null),
         'Either title or child can be provided, but not both',
       );

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomAppBarDelegate(
        title: widget.title,
        subLabel: widget.subLabel,
        onBackTapped: widget.onBackTapped,
        trailingWidget: widget.trailingWidget,
        backgroundColor: widget.backgroundColor,
        child: widget.child,
        height: widget.height,
        useSafeArea: widget.useSafeArea,
      ),
    );
  }
}

class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  final String? title;
  final String? subLabel;
  final VoidCallback onBackTapped;
  final Widget? trailingWidget;
  final Color? backgroundColor;
  final Widget? child;
  final double height;
  final bool useSafeArea;
  static final double _defaultHeight = 14.5.dh;

  CustomAppBarDelegate({
    this.title,
    this.subLabel,
    required this.onBackTapped,
    this.trailingWidget,
    this.backgroundColor,
    this.child,
    double? height,
    this.useSafeArea = true,
  }) : height = height ?? _defaultHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final ds = context.designSystem;

    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: ds.spacing.xs,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: ds.spacing.l,
            right: ds.spacing.l,
            bottom: ds.spacing.l,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIconButton(
                icon: SaturneProIcons.arrowLeft,
                onTap: onBackTapped,
              ),
              if (child != null)
                child!
              else if (title != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UnderlinedText(
                      textLines: [title!],
                      style: CustomTextStyle.headingXL,
                      color: ds.colors.primary.shade500,
                      lineColor: ds.colors.secondary.shade500.withValues(
                        alpha: .2,
                      ),
                    ),
                    if (subLabel != null) ...[
                      CustomText(
                        text: subLabel!,
                        style: CustomTextStyle.bodyS,
                        fontWeight: FontWeight.w400,
                        color: ds.colors.primary.shade900.withValues(alpha: .4),
                      ),
                    ],
                  ],
                ),
              trailingWidget ?? SizedBox(width: 1.5 * ds.spacing.xl),
            ],
          ),
        ),
      ],
    );

    return Container(
      color: backgroundColor ?? ds.colors.primary.shade50,
      child: useSafeArea ? SafeArea(bottom: false, child: content) : content,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
