import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:edspert_fl_adv/core/entities/course/course.dart';
import 'package:edspert_fl_adv/core/use_cases/courses/get_courses_by_major.dart';
import 'package:edspert_fl_adv/infrastructures/services.dart' as services;
import 'package:edspert_fl_adv/interfaces/providers/res/user_cache_cubit.dart';

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
