import 'package:flutter/material.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities/course/exercise.dart';
import 'package:root_lib/interfaces/utils/text_style_x.dart';
import 'package:root_lib/interfaces/widgets/common/common_network_image.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard(this.exercise, {super.key});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: null,
        child: Padding(
          padding: const EdgeInsets.all(kPaddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.square(
                dimension: MediaQuery.of(context).size.width * 0.25,
                child: Card(
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  child: CommonNetworkImage(exercise.iconUrl),
                ),
              ),

              //
              const SizedBox(height: kSpacerValue),
              Text(
                exercise.title,
                style: textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              //
              Text(
                '${exercise.completedCount}/${exercise.count} Soal',
                style: textTheme.bodyMedium?.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
