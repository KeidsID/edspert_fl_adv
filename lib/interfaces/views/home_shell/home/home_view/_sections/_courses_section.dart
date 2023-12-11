part of '../home_view.dart';

class _CoursesSection extends StatefulWidget {
  const _CoursesSection();

  static const _initialMajor = SchoolMajor.ipa;

  @override
  State<_CoursesSection> createState() => _CoursesSectionState();
}

class _CoursesSectionState extends State<_CoursesSection> {
  SchoolMajor selectedMajor = _CoursesSection._initialMajor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pilih Pelajaran', style: textTheme.headlineSmall),
            TextButton(
              onPressed: () =>
                  CoursesRoute(major: selectedMajor.toString()).go(context),
              child: const Text('Lihat Semua'),
            ),
          ],
        ),
        SchoolMajorFormField(
          initialValue: _CoursesSection._initialMajor,
          onSaved: (val) => setState(() => selectedMajor = val!),
        ),
        const SizedBox(height: kSpacerValue / 2),
        _CoursesColumn(major: selectedMajor),
      ],
    );
  }
}

class _CoursesColumn extends StatelessWidget {
  const _CoursesColumn({this.major = SchoolMajor.ipa});

  final SchoolMajor major;

  @override
  Widget build(BuildContext context) {
    final CoursesCubit coursesCubit = major == SchoolMajor.ipa
        ? context.watch<IpaCoursesCubit>()
        : context.watch<IpsCoursesCubit>();

    final coursesAsync = coursesCubit.state;

    final mediaQuery = MediaQuery.of(context);
    final minH = (mediaQuery.orientation == Orientation.portrait)
        ? mediaQuery.size.height * 0.21
        : mediaQuery.size.width * 0.21;

    return coursesAsync.when(
      loading: () => SizedCircularIndicator(
        width: double.maxFinite,
        height: minH,
      ),

      //
      error: (error) => CommonErrorWidget(
        error,
        width: double.maxFinite,
        height: minH,
        action: ElevatedButton.icon(
          onPressed: () => coursesCubit.refresh(),
          icon: const Icon(Icons.refresh_outlined),
          label: const Text('Refresh'),
        ),
      ),

      //
      data: (data) {
        if (data.isEmpty) {
          return SizedBox(
            width: double.maxFinite,
            height: minH,
            child: const Center(child: Text('Tidak ada pelajaran')),
          );
        }

        final courses = data.length > 3 ? data.sublist(0, 3) : data;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: courses.map((course) {
            return CourseCard(course);
          }).toList(),
        );
      },
    );
  }
}
