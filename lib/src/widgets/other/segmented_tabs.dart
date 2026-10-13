import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

/// White pill track with a navy pill on the selected tab ("KPIs | Stats").
class SegmentedTabs extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SegmentedTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Container(
      height: 12 * ds.spacing.xs,
      padding: EdgeInsets.all(ds.spacing.xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: ds.borderRadii.radiusFull,
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        spacing: 2 * ds.spacing.xs,
        children: [
          for (final (i, label) in labels.indexed)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        i == selectedIndex
                            ? ds.colors.primary.shade500
                            : Colors.transparent,
                    borderRadius: ds.borderRadii.radiusFull,
                  ),
                  child: CustomText(
                    text: label,
                    style: CustomTextStyle.bodyS,
                    fontWeight:
                        i == selectedIndex ? FontWeight.w700 : FontWeight.w600,
                    color:
                        i == selectedIndex
                            ? Colors.white
                            : const Color(0xff666B78),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
