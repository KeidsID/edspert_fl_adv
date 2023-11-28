import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';

class HomeViewHeadlineCard extends StatelessWidget {
  final double height;

  const HomeViewHeadlineCard({super.key, this.height = 200.0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      width: double.maxFinite,
      height: height,
      child: Card(
        color: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  'Mau kerjain latihan soal apa hari ini?',
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: LayoutBuilder(builder: (_, constraints) {
                  final height = constraints.maxHeight;

                  return SizedBox(
                    height: height * 0.6,
                    child: Image.asset(
                      AssetsPaths.homePageHeadline,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
