import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/other/other.dart';
import '../base/base.dart';

/// A customizable header widget that can be used in a [CustomScrollView].
///
/// This widget provides a persistent header with optional tabs and trailing widgets.
/// It automatically handles the tab controller lifecycle and provides callbacks for tab changes.
///
/// Example with tabs:
/// ```dart
/// CustomHeader.withTabs(
///   title: 'Dashboard',
///   tabItems: [
///     TabItem(label: 'Overview', icon: Icons.dashboard),
///     TabItem(label: 'Details', icon: Icons.info),
///   ],
///   onTabChanged: (index) {
///     // Handle tab change
///   },
/// )
/// ```
///
/// Example without tabs:
/// ```dart
/// CustomHeader.withoutTabs(
///   title: 'Profile',
///   smallLabel: 'Welcome back',
/// )
/// ```
class CustomHeader extends StatefulWidget {
  /// The main title displayed in the header.
  final String title;

  /// An optional small label displayed above the title.
  final String? smallLabel;

  /// The list of tab items to display in the header.
  /// Only used when [withTabs] constructor is used.
  final List<TabItem>? tabItems;

  /// An optional widget displayed at the end of the header.
  final Widget? trailingWidget;

  /// Callback function triggered when a tab is selected.
  /// Only used when [withTabs] constructor is used.
  final Function(int)? onTabChanged;

  /// Creates a header with tabs.
  ///
  /// This constructor requires both [tabItems] and [onTabChanged] to be provided.
  const CustomHeader.withTabs({
    super.key,
    required this.title,
    required List<TabItem> this.tabItems,
    required Function(int) this.onTabChanged,
    this.smallLabel,
    this.trailingWidget,
  });

  /// Creates a header without tabs.
  ///
  /// This constructor is simpler and only requires a [title].
  const CustomHeader.withoutTabs({
    super.key,
    required this.title,
    this.smallLabel,
    this.trailingWidget,
  }) : tabItems = null,
       onTabChanged = null;

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader>
    with TickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    if (widget.tabItems != null) {
      _tabController = TabController(
        length: widget.tabItems!.length,
        vsync: this,
      );
      _tabController?.addListener(_handleTabChange);
    } else {
      _tabController = null;
    }
  }

  void _handleTabChange() {
    if (_tabController?.indexIsChanging ?? false) {
      widget.onTabChanged?.call(_tabController!.index);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: CustomHeaderDelegate(
        title: widget.title,
        smallLabel: widget.smallLabel,
        tabBar:
            widget.tabItems != null
                ? CustomTabBar(
                  tabItems: widget.tabItems!,
                  controller: _tabController!,
                )
                : null,
        trailingWidget: widget.trailingWidget,
      ),
    );
  }
}

/// A delegate for the [CustomHeader] that handles the persistent header behavior.
class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final String? smallLabel;
  final Widget? tabBar;
  final Widget? trailingWidget;

  CustomHeaderDelegate({
    required this.title,
    required this.smallLabel,
    required this.tabBar,
    required this.trailingWidget,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final ds = context.designSystem;

    return Container(
      color: ds.colors.primary.shade50,
      alignment: Alignment.bottomLeft,

      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (smallLabel != null) ...[
                        Transform.translate(
                          offset: Offset(0, ds.spacing.xs),
                          child: CustomText(
                            text: smallLabel!,
                            style: CustomTextStyle.bodyS,
                            fontWeight: FontWeight.w400,
                            color: ds.colors.primary.shade500,
                          ),
                        ),
                      ],
                      UnderlinedText(
                        textLines: _titleLines,
                        style: CustomTextStyle.displayL,
                        color: ds.colors.primary.shade500,
                        lineColor: ds.colors.secondary.shade500.withValues(
                          alpha: .2,
                        ),
                      ),
                    ],
                  ),
                  if (trailingWidget != null) ...[trailingWidget!],
                ],
              ),
            ),
            if (tabBar != null) ...[tabBar!],
          ],
        ),
      ),
    );
  }

  /// A title carrying `\n` is laid out as several underlined lines rather
  /// than being cut with an ellipsis — the underline is measured per line, so
  /// the break has to be explicit.
  List<String> get _titleLines => title.split('\n');

  /// One displayL line is ~28px of glyph plus leading; the header grows by
  /// that much for every extra line so the title never overflows its box.
  static const double _extraLineHeight = 40;

  @override
  double get maxExtent =>
      (tabBar != null ? 204 : 160) +
      (_titleLines.length - 1) * _extraLineHeight;

  @override
  double get minExtent => maxExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
