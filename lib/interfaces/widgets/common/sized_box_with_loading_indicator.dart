import 'package:flutter/material.dart';

class SizedBoxWithLoadingIndicator extends StatelessWidget {
  const SizedBoxWithLoadingIndicator({super.key, this.width, this.height});

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
