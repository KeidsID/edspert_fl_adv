import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/core/use_cases/courses/get_courses_by_major.dart';
import 'package:root_lib/infrastructures/services.dart' as services;
import 'package:root_lib/interfaces/providers/res/user_cache_cubit.dart';

import '../utils/future_cubit.dart';

abstract base class CoursesCubit extends FutureCubit<List<Course>> {
  CoursesCubit(String email, {major = SchoolMajor.ipa})
      : super(services.locator<GetCoursesByMajor>().execute(
              email,
              major: major,
            ));
}

/// Cubit for [SchoolMajor.ipa] courses.
///
/// Its depend on [UserCacheCubit], so make sure the user cubit are provided
/// first.
final class IpaCoursesCubit extends CoursesCubit {
  IpaCoursesCubit(BuildContext context)
      : super(
          context.read<UserCacheCubit>().state.value?.email ?? '',
          major: SchoolMajor.ipa,
        );
}

/// Cubit for [SchoolMajor.ips] courses.
///
/// Its depend on [UserCacheCubit], so make sure the user cubit are provided
/// first.
final class IpsCoursesCubit extends CoursesCubit {
  IpsCoursesCubit(BuildContext context)
      : super(
          context.read<UserCacheCubit>().state.value?.email ?? '',
          major: SchoolMajor.ips,
        );
}
