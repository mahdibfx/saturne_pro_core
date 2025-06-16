import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:tap_builder/tap_builder.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double? iconSize;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconSize,
  });

  static const _animationDuration = Duration(milliseconds: 700);
  static const _animationCurve = Curves.fastLinearToSlowEaseIn;

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return TapBuilder(
      onTap: onTap,
      builder:
          (context, tapState, isFocused) => AnimatedScale(
            scale: tapState == TapState.pressed ? .92 : 1.0,
            duration: _animationDuration,
            curve: _animationCurve,
            child: Container(
              width: 1.5 * ds.spacing.xl,
              height: 1.5 * ds.spacing.xl,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ds.colors.primary.shade900.withValues(alpha: .05),
                    offset: Offset(0, .93 * ds.spacing.l),
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: ds.colors.primary.shade900,
                size: iconSize ?? .78 * ds.spacing.xl,
              ),
            ),
          ),
    );
  }
}
