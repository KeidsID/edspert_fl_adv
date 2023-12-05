import 'package:flutter/material.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/interfaces/widgets/common/common_network_image.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(this.course, {super.key, this.onTap});

  final Course course;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AspectRatio(
      aspectRatio: 2.5 / 1,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(kPaddingValue),
            child: Row(
              children: [
                // course cover image
                AspectRatio(
                  aspectRatio: 1, // 1:1 (Square)
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CommonNetworkImage(
                        course.coverImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: kSpacerValue / 2),

                // course info
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        course.name,
                        style: textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${course.completedStudiesCount}/${course.studiesCount} '
                        'Paket latihan soal',
                      ),
                      const SizedBox(height: kSpacerValue / 2),
                      LinearProgressIndicator(
                        value:
                            course.completedStudiesCount / course.studiesCount,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
