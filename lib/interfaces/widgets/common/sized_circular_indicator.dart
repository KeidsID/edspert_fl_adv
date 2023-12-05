import 'package:flutter/material.dart';

/// {@template lib.interfaces.widgets.common.sized_circular_indicator}
/// [CircularProgressIndicator] wrapped with [SizedBox] and [Center].
/// {@endtemplate}
class SizedCircularIndicator extends StatelessWidget {
  /// {@macro lib.interfaces.widgets.common.sized_circular_indicator}
  const SizedCircularIndicator({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
