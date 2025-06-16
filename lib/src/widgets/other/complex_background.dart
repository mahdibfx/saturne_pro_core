import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

import '../../assets/assets.dart';

class ComplexBackground extends StatefulWidget {
  const ComplexBackground({super.key});

  @override
  State<ComplexBackground> createState() => _ComplexBackgroundState();
}

class _ComplexBackgroundState extends State<ComplexBackground> {
  @override
  void initState() {
    super.initState();
    // Precache the pattern image
    precacheImage(
      AssetImage(SaturneProImages.pattern, package: packageName),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: ds.gradients.primary),
          foregroundDecoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(SaturneProImages.pattern, package: packageName),
              fit: BoxFit.fill,
              opacity: .3,
            ),
          ),
          height: double.infinity,
          width: double.infinity,
        ),
        Positioned(
          top: 22.75.dh,
          right: 52.9.dw,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ds.colors.secondary.shade500.withValues(alpha: .8),
              ),
            ),
          ),
        ),
        Positioned(
          top: 18.95.dh,
          left: 66.dw,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              width: 156,
              height: 156,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ds.colors.secondary.shade500,
              ),
            ),
          ),
        ),
        Positioned(
          top: 51.6.dh,
          left: 48.18.dw,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              width: 293,
              height: 293,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ds.colors.secondary.shade500.withValues(alpha: .4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
