import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:edspert_fl_adv/core/entities/course/course.dart';
import 'package:edspert_fl_adv/core/use_cases/courses/get_courses_by_major.dart';
import 'package:edspert_fl_adv/infrastructures/services.dart' as services;
import 'package:edspert_fl_adv/interfaces/providers/auth/user_cache_provider.dart';

part 'courses_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [UserCache])
Future<List<Course>> courses(
  CoursesRef ref, {
  SchoolMajor major = SchoolMajor.ipa,
}) {
  final user = ref.watch(userCacheProvider).valueOrNull;

  return services.locator<GetCoursesByMajor>().execute(
        user?.email ?? 'testerngbayu@gmail.com',
        major: major,
      );
}
