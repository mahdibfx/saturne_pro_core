import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/design%20system/design_system.dart';

import '../widgets.dart';

enum ActionButtonsLayout { row, column }

class SectionLayout extends StatelessWidget {
  final List<String> titleLines;
  final String? description;
  final String? mainButtonTitle;
  final String? secondaryButtonTitle;
  final VoidCallback? onMainButtonTapped;
  final VoidCallback? onSecondaryButtonTapped;
  final LinearGradient? mainButtonGradient;
  final Widget? footer;
  final Widget content;
  final Widget? appBarTrailing;
  final Widget? appBarChild;
  final bool useSafeArea;
  final ActionButtonsLayout actionButtonsLayout;
  final VoidCallback? onBackTapped;
  final double? height;
  final bool showAppBar;
  final bool centerHeader;
  final int step;
  final Widget? illustration;
  final int? stepCount;

  const SectionLayout._({
    super.key,
    required this.titleLines,
    required this.content,
    required this.onBackTapped,
    this.description,
    this.mainButtonTitle,
    this.secondaryButtonTitle,
    this.onMainButtonTapped,
    this.onSecondaryButtonTapped,
    this.mainButtonGradient,
    this.footer,
    this.appBarTrailing,
    this.appBarChild,
    this.useSafeArea = false,
    this.actionButtonsLayout = ActionButtonsLayout.row,
    this.height,
    this.showAppBar = true,
    this.centerHeader = false,
    this.step = 1,
    this.stepCount,
    this.illustration,
  }) : assert(
         showAppBar ||
             (appBarTrailing == null &&
                 appBarChild == null &&
                 onBackTapped == null &&
                 useSafeArea == false),
         'If showAppBar is false, appBarTrailing, appBarChild, onBackTapped must be null, and useSafeArea must be false',
       );

  factory SectionLayout.withActionButtons({
    Key? key,
    required List<String> titleLines,
    required Widget content,
    required VoidCallback? onBackTapped,
    required String mainButtonTitle,
    required VoidCallback onMainButtonTapped,
    String? description,
    String? secondaryButtonTitle,
    VoidCallback? onSecondaryButtonTapped,
    LinearGradient? mainButtonGradient,
    Widget? footer,
    Widget? appBarTrailing,
    Widget? appBarChild,
    bool useSafeArea = false,
    ActionButtonsLayout actionButtonsLayout = ActionButtonsLayout.row,
    double? height,
    bool showAppBar = true,
    bool centerHeader = false,
    int step = 1,
    int? stepCount,
    Widget? illustration,
  }) {
    assert(mainButtonTitle.isNotEmpty, 'Main button title cannot be empty');
    if (secondaryButtonTitle != null) {
      assert(
        onSecondaryButtonTapped != null,
        'Secondary button callback must be provided when title is set',
      );
    }
    if (onSecondaryButtonTapped != null) {
      assert(
        secondaryButtonTitle != null,
        'Secondary button title must be provided when callback is set',
      );
    }
    assert(
      showAppBar ||
          (appBarTrailing == null &&
              appBarChild == null &&
              onBackTapped == null &&
              useSafeArea == false),
      'If showAppBar is false, appBarTrailing, appBarChild, onBackTapped must be null, and useSafeArea must be false',
    );

    return SectionLayout._(
      key: key,
      titleLines: titleLines,
      content: content,
      onBackTapped: onBackTapped,
      description: description,
      mainButtonTitle: mainButtonTitle,
      secondaryButtonTitle: secondaryButtonTitle,
      onMainButtonTapped: onMainButtonTapped,
      onSecondaryButtonTapped: onSecondaryButtonTapped,
      mainButtonGradient: mainButtonGradient,
      footer: footer,
      appBarTrailing: appBarTrailing,
      appBarChild: appBarChild,
      useSafeArea: useSafeArea,
      actionButtonsLayout: actionButtonsLayout,
      height: height,
      showAppBar: showAppBar,
      centerHeader: centerHeader,
      step: step,
      stepCount: stepCount,
      illustration: illustration,
    );
  }

  factory SectionLayout.withoutActionButtons({
    Key? key,
    required List<String> titleLines,
    required Widget content,
    required VoidCallback? onBackTapped,
    String? description,
    Widget? footer,
    Widget? appBarTrailing,
    Widget? appBarChild,
    bool useSafeArea = false,
    double? height,
    bool showAppBar = true,
    bool centerHeader = false,
  }) {
    assert(
      showAppBar ||
          (appBarTrailing == null &&
              appBarChild == null &&
              onBackTapped == null &&
              useSafeArea == false),
      'If showAppBar is false, appBarTrailing, appBarChild, onBackTapped must be null, and useSafeArea must be false',
    );

    return SectionLayout._(
      key: key,
      titleLines: titleLines,
      content: content,
      onBackTapped: onBackTapped,
      description: description,
      footer: footer,
      appBarTrailing: appBarTrailing,
      appBarChild: appBarChild,
      useSafeArea: useSafeArea,
      height: height,
      showAppBar: showAppBar,
      centerHeader: centerHeader,
    );
  }

  Color _mainLabelColor(AppDesignSystem ds) =>
      mainButtonGradient == null ? ds.colors.primary.shade500 : Colors.white;

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return RepaintBoundary(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastLinearToSlowEaseIn,
        height: height ?? 90.dh,
        child: CustomScrollView(
          slivers: [
            if (showAppBar)
              SliverToBoxAdapter(
                child: SafeArea(
                  top: useSafeArea,
                  bottom: false,
                  child: BackHeader(
                    onBackTapped: onBackTapped!,
                    step: step,
                    stepCount: stepCount,
                    trailing: appBarTrailing ?? appBarChild,
                  ),
                ),
              ),
            SliverToBoxAdapter(child: CustomGap(gapSize: GapSize.l)),
            if (illustration != null)
              SliverPadding(
                padding: EdgeInsets.only(
                  top: ds.spacing.xl,
                  bottom: ds.spacing.xl,
                ),
                sliver: SliverToBoxAdapter(child: illustration),
              ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 6 * ds.spacing.xs),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(
                  titleLines: titleLines,
                  description: description,
                  isCenteredAligned: centerHeader,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 6 * ds.spacing.xs,
                vertical: 1.5 * ds.spacing.l,
              ),
              sliver: SliverToBoxAdapter(child: content),
            ),
            if (mainButtonTitle != null)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 6 * ds.spacing.xs),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: ds.spacing.l,
                      children: [
                        if (actionButtonsLayout == ActionButtonsLayout.column)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: ds.spacing.l,
                            children: [
                              Button.filled(
                                label: mainButtonTitle!,
                                backgroundColor:
                                    mainButtonGradient ?? ds.gradients.primary,
                                labelColor: _mainLabelColor(ds),
                                onTap: onMainButtonTapped!,
                              ),
                              if (secondaryButtonTitle != null)
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: ds.borderRadii.radiusM,
                                    border: Border.all(
                                      color: ds.colors.shade.shade200,
                                    ),
                                  ),
                                  child: Button.filled(
                                    label: secondaryButtonTitle!,
                                    backgroundColor: LinearGradient(
                                      colors: [
                                        ds.colors.primary.shade50,
                                        ds.colors.primary.shade50,
                                      ],
                                    ),
                                    labelColor: ds.colors.primary.shade500,
                                    onTap: onSecondaryButtonTapped!,
                                  ),
                                ),
                            ],
                          ),
                        if (actionButtonsLayout == ActionButtonsLayout.row)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: ds.spacing.l,
                            children: [
                              if (secondaryButtonTitle != null)
                                Expanded(
                                  child: Button.plain(
                                    label: secondaryButtonTitle!,
                                    labelColor: ds.colors.secondary.shade500,
                                    onTap: onSecondaryButtonTapped!,
                                  ),
                                ),
                              Flexible(
                                flex: 2,
                                child: Button.filled(
                                  label: mainButtonTitle!,
                                  backgroundColor:
                                      mainButtonGradient ??
                                      ds.gradients.primary,
                                  labelColor: _mainLabelColor(ds),
                                  onTap: onMainButtonTapped!,
                                ),
                              ),
                            ],
                          ),
                        if (footer != null)
                          Padding(
                            padding: EdgeInsets.only(bottom: ds.spacing.s),
                            child: footer!,
                          ),
                        CustomGap(customSizeValue: .6 * ds.spacing.l),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
