import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/common/constants.dart';
import 'package:root_lib/core/entities.dart';
import 'package:root_lib/infrastructures/services/remote/api/errors/common_response_exception.dart';
import 'package:root_lib/interfaces/providers/res/courses_cubit.dart';
import 'package:root_lib/interfaces/providers/utils/future_cubit.dart';
import 'package:root_lib/interfaces/widgets.dart';

class CoursesView extends StatelessWidget {
  const CoursesView(this.major, {super.key});

  /// Selected major from previous page.
  final SchoolMajor major;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Pelajaran')),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kPaddingValue,
          ).copyWith(
            top: kPaddingValue,
          ),
          child: _CoursesContents(major),
        ),
      ),
    );
  }
}

class _CoursesContents extends StatefulWidget {
  const _CoursesContents(this.major);

  final SchoolMajor major;

  @override
  State<_CoursesContents> createState() => _CoursesContentsState();
}

class _CoursesContentsState extends State<_CoursesContents> {
  late SchoolMajor selectedMajor;

  @override
  void initState() {
    super.initState();

    selectedMajor = widget.major;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SchoolMajorFormField(
          initialValue: widget.major,
          onSaved: (val) => setState(() => selectedMajor = val!),
        ),
        const SizedBox(height: kSpacerValue / 2),
        Expanded(
          child: Builder(builder: (context) {
            final CoursesCubit coursesCubit = selectedMajor == SchoolMajor.ipa
                ? context.watch<IpaCoursesCubit>()
                : context.watch<IpsCoursesCubit>();

            final coursesAsync = coursesCubit.state;

            return coursesAsync.when(
              loading: () => const SizedCircularIndicator(),
              error: (e) {
                if (e is CommonResponseException) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(e.message, textAlign: TextAlign.center),
                      OutlinedButton.icon(
                        onPressed: () => coursesCubit.refresh(),
                        icon: const Icon(Icons.refresh_outlined),
                        label: const Text('Refresh'),
                      ),
                    ],
                  );
                }

                kLogger.f('coursesProvider', error: e);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Terjadi kesalahan',
                        textAlign: TextAlign.center),
                    OutlinedButton.icon(
                      onPressed: () => coursesCubit.refresh(),
                      icon: const Icon(Icons.refresh_outlined),
                      label: const Text('Refresh'),
                    ),
                  ],
                );
              },
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
    );
  }
}
