import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

/// Horizontally scrolling pills; the selected one is brand yellow.
class FilterChips extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const FilterChips({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return SizedBox(
      height: 9 * ds.spacing.xs,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
        itemCount: labels.length,
        separatorBuilder: (_, _) => SizedBox(width: ds.spacing.s),
        itemBuilder: (context, i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 3 * ds.spacing.xs),
              decoration: BoxDecoration(
                color: selected ? const Color(0xffFFC607) : Colors.white,
                borderRadius: ds.borderRadii.radiusFull,
              ),
              child: CustomText(
                text: labels[i],
                style: CustomTextStyle.captionM,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color:
                    selected
                        ? ds.colors.primary.shade500
                        : ds.colors.shade.shade600,
              ),
            ),
          );
        },
      ),
    );
  }
}
