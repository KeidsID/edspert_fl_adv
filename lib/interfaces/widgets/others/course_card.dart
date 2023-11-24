import 'package:flutter/material.dart';

import 'package:edspert_fl_adv/common/assets_paths.dart';

class CourseCard extends StatelessWidget {
  final double height;

  const CourseCard({super.key, this.height = 150.0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SizedBox(
      width: double.maxFinite,
      height: height,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  'Mau kerjain latihan soal apa hari ini?',
                  style: textTheme.headlineMedium,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: height * 0.6,
                  child: Image.asset(AssetsPaths.homePageHeadline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
