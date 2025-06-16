import 'package:flutter/widgets.dart';

import '../../helpers/helpers.dart';

class BorderRadiiData {
  BorderRadiiData._();

  /// Border Radius Full
  static const borderRadiusFull = BorderRadius.all(Radius.circular(100000));

  /// Border Radius of 8.0
  static final borderRadiusS = BorderRadius.all(Radius.circular(Dimensions.s));

  /// Border Radius of 12.0
  static final borderRadiusM = BorderRadius.all(
    Radius.circular(Dimensions.xs + Dimensions.s),
  );

  /// Border Radius of 14.0
  static final borderRadiusL = BorderRadius.all(
    Radius.circular(Dimensions.l - (Dimensions.xs / 2)),
  );
}
