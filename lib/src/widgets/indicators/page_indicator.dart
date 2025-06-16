import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  final int activeIndex;
  final int pagesCount;

  const CustomPageIndicator({
    super.key,
    required this.pagesCount,
    this.activeIndex = 0,
  }) : assert(pagesCount > 0, 'pages count should be greater than 0'),
       assert(
         pagesCount <= 10,
         'This indicator was not meant for such a large amount of pages.',
       ),
       assert(
         activeIndex < pagesCount,
         'the activeIndex should not be greater than the pagesCount',
       );

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ds.spacing.s,
        horizontal: ds.spacing.l - ds.spacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.5 * ds.spacing.xs),
        color: ds.colors.primary.shade500.withValues(alpha: .04),
      ),
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: pagesCount,
        effect: WormEffect(
          dotWidth: ds.spacing.s,
          dotHeight: ds.spacing.s,
          activeDotColor: ds.colors.secondary.shade500,
          dotColor: ds.colors.secondary.shade500.withValues(alpha: .3),
        ),
      ),
    );
  }
}
