import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/infrastructures/services/remote/api/errors/common_response_exception.dart';
import 'package:root_lib/interfaces/providers.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';
import 'package:root_lib/interfaces/router/router.dart';
import 'package:root_lib/interfaces/widgets.dart';
import 'package:root_lib/interfaces/widgets/common/not_found_widget.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView(this.courseId, {super.key});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final major = SchoolMajor.fromString(
        GoRouterState.of(context).uri.queryParameters['major'] ??
            '${SchoolMajor.ipa}');

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: Builder(builder: (context) {
          final CoursesCubit coursesCubit = (major == SchoolMajor.ipa)
              ? context.read<IpaCoursesCubit>()
              : context.read<IpsCoursesCubit>();
          final courses = coursesCubit.state.value;

          if (courses == null || courses.isEmpty) {
            return const Text('Soal-soal');
          }

          final course =
              courses.firstWhere((element) => element.id == courseId);

          return Text(course.name);
        }),
      ),
      body: BlocProvider(
        create: (context) => ExercisesCubit(context, courseId: courseId),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kSpacerValue),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kPaddingValue),
              child: Text('Pilih Paket Soal'),
            ),
            const SizedBox(height: kSpacerValue),
            Expanded(
              child: Builder(builder: (context) {
                final exercisesCubit = context.watch<ExercisesCubit>();
                final exercisesAsync = exercisesCubit.state;

                return exercisesAsync.when(
                  loading: () => const SizedCircularIndicator.expand(),

                  //
                  error: (error) {
                    if (error is CommonResponseException) {
                      if (error.message == 'data not found') {
                        return _notFoundWidget();
                      }
                    }

                    return CommonErrorWidget.expand(
                      error,
                      action: ElevatedButton.icon(
                        onPressed: () => exercisesCubit.refresh(),
                        icon: const Icon(Icons.refresh_outlined),
                        label: const Text('Refresh'),
                      ),
                    );
                  },

                  //
                  data: (exercises) {
                    if (exercises.isEmpty) return _notFoundWidget();

                    return GridView.builder(
                      padding: const EdgeInsets.all(kPaddingValue).copyWith(
                        top: 0,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width <= 600.0)
                                ? 1
                                : 2,
                        childAspectRatio: 3 / 1.8,
                      ),
                      itemCount: exercises.length,
                      itemBuilder: (_, index) => ExerciseCard(exercises[index]),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notFoundWidget() {
    return const NotFoundWidget(
      message: 'Yah, Paket tidak tersedia',
      detail: 'Tenang, masih banyak yang bisa kamu pelajari. cari lagi yuk!',
    );
  }
}
