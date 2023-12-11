import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities.dart';
import 'package:root_lib/interfaces/providers/res/courses/courses_cubit.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';
import 'package:root_lib/interfaces/router/routes/routes.dart';
import 'package:root_lib/interfaces/widgets.dart';

class CoursesView extends StatelessWidget {
  const CoursesView(this.major, {super.key});

  /// Selected major from previous page.
  final SchoolMajor major;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: const Text('Pilih Pelajaran'),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kPaddingValue,
          ).copyWith(
            top: kPaddingValue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SchoolMajorFormField(
                initialValue: major,
                onSaved: (val) => CoursesRoute(major: '$val').go(context),
              ),
              const SizedBox(height: kSpacerValue / 2),
              Expanded(
                child: Builder(builder: (context) {
                  final CoursesCubit coursesCubit = major == SchoolMajor.ipa
                      ? context.watch<IpaCoursesCubit>()
                      : context.watch<IpsCoursesCubit>();

                  final coursesAsync = coursesCubit.state;

                  return coursesAsync.when(
                    loading: () => const SizedCircularIndicator.expand(),

                    //
                    error: (error) => CommonErrorWidget.expand(
                      error,
                      action: ElevatedButton.icon(
                        onPressed: () => coursesCubit.refresh(),
                        icon: const Icon(Icons.refresh_outlined),
                        label: const Text('Refresh'),
                      ),
                    ),

                    //
                    data: (courses) {
                      if (courses.isEmpty) {
                        return const Center(child: Text('Tidak ada pelajaran'));
                      }

                      return ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final course = courses[index];

                          return CourseCard(course);
                        },
                      );
                    },
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
