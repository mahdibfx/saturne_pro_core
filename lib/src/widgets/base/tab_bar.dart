import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

class TabItem {
  final Key? key;
  final String label;
  final IconData? icon;

  const TabItem({this.key, required this.label, this.icon});
}

class CustomTabBar extends StatefulWidget {
  final TabController controller;
  final List<TabItem> tabItems;
  final bool isScrollable;

  /// Creates a custom tab bar.
  ///
  /// If [isScrollable] is false, the maximum number of tabs is limited to 2.
  /// If [isScrollable] is true, there's no limit to the number of tabs.
  const CustomTabBar({
    super.key,
    required this.tabItems,
    required this.controller,
    this.isScrollable = false,
  }) : assert(
         isScrollable || tabItems.length <= 2,
         'When isScrollable is false, the maximum number of tabs is limited to 2',
       );

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  // Listener callback as a class field to avoid recreating it
  VoidCallback? _controllerListener;

  void _setupControllerListener() {
    // Remove previous listener if exists
    _removeControllerListener();

    // Create and store the listener
    _controllerListener = () {
      if (mounted) setState(() {});
    };

    // Add the listener after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.addListener(_controllerListener!);
    });
  }

  void _removeControllerListener() {
    if (_controllerListener != null) {
      widget.controller.removeListener(_controllerListener!);
      _controllerListener = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _setupControllerListener();
  }

  @override
  void didUpdateWidget(CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _setupControllerListener();
    }
  }

  @override
  void dispose() {
    _removeControllerListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return TabBar(
      isScrollable: widget.isScrollable,
      tabAlignment: widget.isScrollable ? TabAlignment.start : null,
      physics: defaultScrollPhysics,
      controller: widget.controller,
      indicator: _buildIndicatorDecoration(ds),
      splashBorderRadius: _buildBorderRadius(ds),
      overlayColor: WidgetStateProperty.all(
        ds.colors.primary.shade100.withValues(alpha: .2),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: ds.colors.primary.shade500.withValues(alpha: .2),
      dividerHeight: .5,
      indicatorAnimation: TabIndicatorAnimation.elastic,
      tabs: _buildTabs(ds),
    );
  }

  // Extract decoration to a separate method for better readability
  BoxDecoration _buildIndicatorDecoration(AppDesignSystem ds) {
    return BoxDecoration(
      color: ds.colors.primary.shade100,
      borderRadius: _buildBorderRadius(ds),
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: ds.colors.primary.shade500,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    );
  }

  // Extract border radius to avoid duplication
  BorderRadius _buildBorderRadius(AppDesignSystem ds) {
    return BorderRadius.only(
      topLeft: Radius.circular(ds.spacing.xs),
      topRight: Radius.circular(ds.spacing.xs),
      bottomLeft: Radius.circular(ds.spacing.xs / 2),
      bottomRight: Radius.circular(ds.spacing.xs / 2),
    );
  }

  // Extract tab building logic for better organization
  List<Widget> _buildTabs(AppDesignSystem ds) {
    return List.generate(widget.tabItems.length, (index) {
      final tabItem = widget.tabItems[index];
      final isSelected = index == widget.controller.index;
      final isLastTab = index == widget.tabItems.length - 1;
      final showDivider =
          !isSelected && index != widget.controller.index - 1 && !isLastTab;

      return Padding(
        key: tabItem.key,
        padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            _buildTabContent(tabItem, isSelected, ds),
            _buildTabDivider(showDivider, ds),
          ],
        ),
      );
    });
  }

  // Build the tab content (icon and text)
  Widget _buildTabContent(
    TabItem tabItem,
    bool isSelected,
    AppDesignSystem ds,
  ) {
    final alpha = isSelected ? 1.0 : 0.5;
    final fontWeight = isSelected ? FontWeight.w500 : FontWeight.w400;

    return Tab(
      height: 3.4 * ds.spacing.l,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: ds.spacing.l,
        children: [
          if (tabItem.icon != null)
            Icon(
              tabItem.icon,
              color: ds.colors.primary.shade500.withValues(alpha: alpha),
            ),
          CustomText(
            text: tabItem.label,
            style: CustomTextStyle.bodyL,
            color: ds.colors.primary.shade500.withValues(alpha: alpha),
            fontWeight: fontWeight,
          ),
        ],
      ),
    );
  }

  // Build the vertical divider between tabs
  Widget _buildTabDivider(bool showDivider, AppDesignSystem ds) {
    return Positioned(
      right: -(ds.spacing.xl + .4 * ds.spacing.xs),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastLinearToSlowEaseIn,
        height: showDivider ? 1.625 * ds.spacing.l : 0.0,
        child: VerticalDivider(
          thickness: 1.0,
          width: 1.0,
          color: ds.colors.primary.shade500.withValues(alpha: .1),
        ),
      ),
    );
  }
}
