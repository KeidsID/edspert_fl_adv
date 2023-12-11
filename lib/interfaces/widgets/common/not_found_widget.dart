import 'package:flutter/material.dart';

import 'package:root_lib/common/assets_paths.dart';
import 'package:root_lib/common/constants.dart';
import 'package:root_lib/interfaces/utils/text_style_x.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key, required this.message, this.detail});

  final String message;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(kPaddingValue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(AssetsPaths.notFound),
            ),
            Text(message, style: textTheme.headlineMedium),
            ...(detail == null)
                ? []
                : [
                    const SizedBox(height: kSpacerValue),
                    Text(
                      detail!,
                      style: textTheme.bodyMedium?.withOpacity(0.5),
                      textAlign: TextAlign.center,
                    ),
                  ],
          ],
        ),
      ),
    );
  }
}
