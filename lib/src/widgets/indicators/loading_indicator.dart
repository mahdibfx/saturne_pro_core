import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/design_system_helper_methodes.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  LoadingIndicatorState createState() => LoadingIndicatorState();
}

class LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: ds.spacing.xs,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double phase = (_controller.value + (index / 3)) % 1.0;
            // Smoothly interpolate between 1.0, 0.6, and 0.2 over the cycle
            double opacity;
            if (phase < 1 / 3) {
              opacity = 1.0 - (phase * 0.4 / (1 / 3)); // 1.0 to 0.6
            } else if (phase < 2 / 3) {
              opacity = 0.6 - ((phase - 1 / 3) * 0.4 / (1 / 3)); // 0.6 to 0.2
            } else {
              opacity = 0.2 + ((phase - 2 / 3) * 0.4 / (1 / 3)); // 0.2 to 1.0
            }
            return Opacity(
              opacity: opacity.clamp(0.0, 1.0),
              child: Container(
                width: 1.75 * ds.spacing.xs,
                height: 1.75 * ds.spacing.xs,
                color: Colors.teal,
              ),
            );
          },
        );
      }),
    );
  }
}
