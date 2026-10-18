import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../widgets.dart';

class CustomAppBar extends StatefulWidget {
  final String? title;
  final String? subLabel;

  /// Null on root tabs: no arrow, title stays centred.
  final VoidCallback? onBackTapped;
  final Widget? trailingWidget;
  final Color? backgroundColor;
  final Widget? child;
  final double? height;
  final bool useSafeArea;

  const CustomAppBar({
    super.key,
    this.title,
    this.onBackTapped,
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

  /// Null on root tabs: no arrow, title stays centred.
  final VoidCallback? onBackTapped;
  final Widget? trailingWidget;
  final Color? backgroundColor;
  final Widget? child;
  final double height;
  final bool useSafeArea;

  /// Tellot bar: 66px of navy under the status bar.
  static double get _defaultHeight =>
      66 +
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.first,
      ).padding.top;

  CustomAppBarDelegate({
    this.title,
    this.subLabel,
    this.onBackTapped,
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
    final side =
        10.5 * ds.spacing.xs; // 42px tap targets keep the title centred

    // Fixed 66px row: without it the centred title stretches to the full
    // bar height wherever no SafeArea caps it (bottom sheets).
    Widget content = Container(
      height: 66,
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onBackTapped,
            child: SizedBox.square(
              dimension: side,
              child:
                  onBackTapped == null
                      ? null
                      : Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 5.25 * ds.spacing.xs,
                      ),
            ),
          ),
          Expanded(
            child: DefaultTextStyle.merge(
              style: const TextStyle(color: Colors.white),
              child: Center(
                child:
                    child ??
                    (title == null
                        ? const SizedBox.shrink()
                        : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: title!,
                              style: CustomTextStyle.headingM,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                            if (subLabel != null)
                              CustomText(
                                text: subLabel!,
                                style: CustomTextStyle.captionM,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: .7),
                                maxLines: 1,
                              ),
                          ],
                        )),
              ),
            ),
          ),
          SizedBox(width: side, child: Center(child: trailingWidget)),
        ],
      ),
    );

    // White status-bar icons over the navy bar.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: backgroundColor ?? ds.colors.primary.shade500,
        alignment: Alignment.bottomCenter,
        child: useSafeArea ? SafeArea(bottom: false, child: content) : content,
      ),
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
