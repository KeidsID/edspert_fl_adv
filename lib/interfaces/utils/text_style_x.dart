/// Extension for [TextStyle].
library text_style_x;

import 'package:flutter/material.dart';

extension TextStyleX on TextStyle {
  /// Creates a copy of this text style but with new color opacity
  /// (which ranges from 0.0 to 1.0).
  ///
  /// Out of range values will have unexpected effects.
  TextStyle withOpacity(double opacity) {
    final color = this.color;

    return copyWith(color: color?.withOpacity(opacity));
  }
}
