import 'dart:io';

import 'package:flutter/widgets.dart';

// One caveat is i need to wait for the WidgetsBinding.instance to be ready (before running the app) ...

/// **Get Device Height**:
///
/// Calculates the height of the device's screen in logical pixels.
///
/// Usage: `double height = deviceHeight;`
/// Returns the height of the device's screen in logical pixels.
double get deviceHeight =>
    WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height /
    WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

/// **Get Device Width**:
///
/// Calculates the width of the device's screen in logical pixels.
///
/// Usage: `double width = deviceWidth;`
/// Returns the width of the device's screen in logical pixels.
double get deviceWidth =>
    WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
    WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

/// **Get Device Aspect Ratio**:
///
/// Calculates the aspect ratio of the device's screen.
///
/// Usage: `double aspectRatio = deviceAspectRatio;`
/// Returns the aspect ratio of the device's screen.
double get deviceAspectRatio => deviceHeight / deviceWidth;

/// **Responsive Size Extension**
///
/// An extension for numerical values to calculate responsive sizes based on device characteristics.
///
/// - `h`: Calculate responsive height based on the device's aspect ratio.
/// - `w`: Calculate responsive width based on the device's aspect ratio.
/// - `dh`: Calculate responsive height based on a percentage of the device's height.
/// - `dw`: Calculate responsive width based on a percentage of the device's width.
extension MediaQueryExt on num {
  /// - `_aH()`: Calculate responsive height based on the device's aspect ratio.
  double _aH() {
    double i = .96;

    if (Platform.isIOS) {
      if (deviceAspectRatio <= 1.78) {
        i = 1.15;
      } else if (deviceAspectRatio >= 1.78 && deviceAspectRatio <= 2.04) {
        i = .96;
      } else if (deviceAspectRatio >= 2.04 && deviceAspectRatio <= 2.11) {
        i = .96;
      } else if (deviceAspectRatio >= 2.11 && deviceAspectRatio <= 2.16) {
        i = .96;
      } else if (deviceAspectRatio >= 2.16) {
        i = 1.0;
      }
    }
    if (Platform.isAndroid) {
      if (deviceAspectRatio <= 1.78) {
        i = .985;
      } else if (deviceAspectRatio >= 1.78 && deviceAspectRatio <= 2.04) {
        i = 1.0;
      } else if (deviceAspectRatio >= 2.04 && deviceAspectRatio <= 2.11) {
        i = .985;
      } else if (deviceAspectRatio >= 2.11 && deviceAspectRatio <= 2.16) {
        i = .985;
      } else if (deviceAspectRatio >= 2.16) {
        i = 1.06;
      }
    }

    return i * this * deviceHeight / 100;
  }

  /// - `_aW()`: Calculate responsive width based on the device's aspect ratio.
  double _aW() {
    double i = .96;

    if (deviceAspectRatio <= 1.33) {
      i = .845;
    } else if (deviceAspectRatio >= 1.33 && deviceAspectRatio <= 1.6) {
      i = 1.1;
    } else if (deviceAspectRatio >= 1.6 && deviceAspectRatio <= 1.78) {
      i = 0.94;
    } else if (deviceAspectRatio >= 1.78 && deviceAspectRatio <= 1.5) {
      i = 0.985;
    } else if (deviceAspectRatio >= 1.5) {
      i = 0.94;
    }

    return i * this * deviceWidth / 100;
  }

  /// - `h`: Calculate responsive height based on the device's aspect ratio.
  /// Usage: `double size = 23.h;`
  double get h => _aH();

  /// - `w`: Calculate responsive width based on the device's aspect ratio.
  /// Usage: `double size = 23.w;`
  double get w => _aW();

  /// - `dh`: Calculate responsive height based on a percentage of the device's height.
  /// Usage: `double size = 23.dh;`
  double get dh => this * deviceHeight / 100;

  /// - `dw`: Calculate responsive width based on a percentage of the device's width.
  /// Usage: `double size = 23.dw;`
  double get dw => this * deviceWidth / 100;
}
