import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

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
  final VoidCallback onBackTapped;
  final double? height;

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
  });

  factory SectionLayout.withActionButtons({
    Key? key,
    required List<String> titleLines,
    required Widget content,
    required VoidCallback onBackTapped,
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
    );
  }

  factory SectionLayout.withoutActionButtons({
    Key? key,
    required List<String> titleLines,
    required Widget content,
    required VoidCallback onBackTapped,
    String? description,
    Widget? footer,
    Widget? appBarTrailing,
    Widget? appBarChild,
    bool useSafeArea = false,
    double? height,
  }) {
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
    );
  }

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
            CustomAppBar(
              onBackTapped: onBackTapped,
              backgroundColor: Colors.white,
              height: useSafeArea ? null : ds.spacing.xl * 2.5,
              useSafeArea: useSafeArea,
              trailingWidget: appBarTrailing,
              child: appBarChild,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(
                  titleLines: titleLines,
                  description: description,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: ds.spacing.l,
                vertical: 1.5 * ds.spacing.l,
              ),
              sliver: SliverToBoxAdapter(child: content),
            ),
            if (mainButtonTitle != null)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
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
                              if (secondaryButtonTitle != null)
                                Button.outlined(
                                  label: secondaryButtonTitle!,
                                  labelColor: ds.colors.secondary.shade500,
                                  onTap: onSecondaryButtonTapped!,
                                ),
                              Button.filled(
                                label: mainButtonTitle!,
                                backgroundColor:
                                    mainButtonGradient ?? ds.gradients.primary,
                                labelColor: Colors.white,
                                onTap: onMainButtonTapped!,
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
                                  labelColor: Colors.white,
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
