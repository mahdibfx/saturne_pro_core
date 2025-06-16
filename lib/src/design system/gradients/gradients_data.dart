import 'package:flutter/material.dart';

/// A utility class for defining gradient values commonly used in the design system.
class GradientsData {
  // Private constructor to prevent instantiation.
  GradientsData._();

  /// Represents a primary gradient.
  static final LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xff036666), Color(0xff40AFB8)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  /// Represents a danger gradient.
  static final LinearGradient dangerGradient = LinearGradient(
    colors: [Color(0xffFF0004), Color(0xffFF3F42)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
