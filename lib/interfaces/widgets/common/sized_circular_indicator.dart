import 'package:flutter/material.dart';

/// {@template lib.interfaces.widgets.common.sized_circular_indicator}
/// [CircularProgressIndicator] wrapped with [SizedBox] and [Center].
/// {@endtemplate}
class SizedCircularIndicator extends SizedBox {
  /// {@macro lib.interfaces.widgets.common.sized_circular_indicator}
  const SizedCircularIndicator({super.key, super.width, super.height})
      : super(child: _child);

  /// {@macro lib.interfaces.widgets.common.sized_circular_indicator}
  ///
  /// This constructor using [SizedBox.expand].
  const SizedCircularIndicator.expand({super.key})
      : super(width: double.infinity, height: double.infinity, child: _child);

  /// {@macro lib.interfaces.widgets.common.sized_circular_indicator}
  ///
  /// This constructor using [SizedBox.shrink].
  const SizedCircularIndicator.shrink({super.key})
      : super(width: 0.0, height: 0.0, child: _child);

  /// {@macro lib.interfaces.widgets.common.sized_circular_indicator}
  ///
  /// This constructor using [SizedBox.fromSize].
  SizedCircularIndicator.fromSize({super.key, Size? size})
      : super(width: size?.width, height: size?.height, child: _child);

  /// {@macro lib.interfaces.widgets.common.sized_circular_indicator}
  ///
  /// This constructor using [SizedBox.square].
  const SizedCircularIndicator.square({super.key, double? dimension})
      : super(width: dimension, height: dimension, child: _child);

  static const _child = Center(child: CircularProgressIndicator());
}
