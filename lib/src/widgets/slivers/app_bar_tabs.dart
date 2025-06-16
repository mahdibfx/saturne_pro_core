import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../widgets.dart';

/// A widget that creates a persistent tab bar in the app bar area.
///
/// This widget creates a [SliverPersistentHeader] with tabs that can be pinned
/// to the top of the screen. It's useful for creating tabbed navigation within
/// a scrollable view.
///
/// The tabs can be configured to be scrollable or fixed width, and can be
/// hidden/shown with an animation.
///
/// Example:
/// ```dart
/// AppBarTabs(
///   tabItems: [
///     TabItem(icon: Icons.home, label: 'Home'),
///     TabItem(icon: Icons.settings, label: 'Settings'),
///   ],
///   onTabChanged: (index) {
///     // Handle tab change
///   },
/// )
/// ```
class AppBarTabs extends StatefulWidget {
  /// The list of tab items to display in the tab bar.
  final List<TabItem> tabItems;

  /// Callback function that is called when a tab is selected.
  final Function(int) onTabChanged;

  /// Whether the tab bar should be scrollable horizontally.
  ///
  /// If true, the tabs will scroll horizontally when they don't fit the screen.
  /// If false, the tabs will be distributed evenly across the available width.
  final bool isScrollable;

  /// Whether the tab bar should be hidden.
  ///
  /// When true, the tab bar will be visible. When false, it will be hidden
  /// with an animation.
  final bool hidden;

  const AppBarTabs({
    super.key,
    required this.tabItems,
    required this.onTabChanged,
    this.isScrollable = false,
    this.hidden = false,
  });

  @override
  State<AppBarTabs> createState() => _AppBarTabsState();
}

class _AppBarTabsState extends State<AppBarTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabItems.length, vsync: this);
    _controller.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_controller.indexIsChanging) {
      widget.onTabChanged(_controller.index);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: AppBarTabsDelegate(
        tabItems: widget.tabItems,
        controller: _controller,
        isScrollable: widget.isScrollable,
        hidden: widget.hidden,
      ),
    );
  }
}

/// A delegate class that builds the persistent header for the tab bar.
///
/// This class is responsible for creating the actual tab bar widget that will
/// be displayed in the persistent header. It handles the layout and animation
/// of the tab bar.
class AppBarTabsDelegate extends SliverPersistentHeaderDelegate {
  /// The list of tab items to display in the tab bar.
  final List<TabItem> tabItems;

  /// The controller that manages the tab selection state.
  final TabController controller;

  /// Whether the tab bar should be scrollable horizontally.
  final bool isScrollable;

  /// Whether the tab bar should be hidden.
  final bool hidden;

  /// The fixed height of the tab bar.
  static const double _height = 55.6;

  AppBarTabsDelegate({
    required this.tabItems,
    required this.controller,
    this.isScrollable = false,
    this.hidden = false,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final ds = context.designSystem;
    return IgnorePointer(
      ignoring: !hidden,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        opacity: hidden ? 1.0 : .0,
        child: Container(
          color: ds.colors.primary.shade50,
          child: CustomTabBar(
            isScrollable: isScrollable,
            tabItems: tabItems,
            controller: controller,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _height;

  @override
  double get minExtent => _height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is AppBarTabsDelegate) {
      return oldDelegate.tabItems != tabItems ||
          oldDelegate.controller != controller ||
          oldDelegate.isScrollable != isScrollable ||
          oldDelegate.hidden != hidden;
    }
    return true;
  }
}
