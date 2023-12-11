import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/core/entities/course/exercise.dart';
import 'package:root_lib/core/use_cases.dart';
import 'package:root_lib/infrastructures/container/container.dart' as container;
import 'package:root_lib/interfaces/providers/res/auth/user_cache_cubit.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';

final class ExercisesCubit extends FutureCubit<List<Exercise>> {
  ExercisesCubit(BuildContext context, {required String courseId})
      : super(() => container.locator<GetExercisesFromCourse>().execute(
              courseId: courseId,
              email: context.read<UserCacheCubit>().state.value?.email ?? '',
            ));
}
