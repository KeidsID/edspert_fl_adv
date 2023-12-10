import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/core/use_cases.dart';
import 'package:root_lib/infrastructures/container/container.dart' as container;
import 'package:root_lib/interfaces/providers/res/user_cache_cubit.dart';

import '../utils/future_cubit.dart';

abstract base class CoursesCubit extends FutureCubit<List<Course>> {
  CoursesCubit(BuildContext context, {major = SchoolMajor.ipa})
      : super(container.locator<GetCoursesByMajor>().execute(
              context.read<UserCacheCubit>().state.value?.email ?? '',
              major: major,
            ));
}

/// Cubit for [SchoolMajor.ipa] courses.
///
/// Its depend on [UserCacheCubit], so make sure the user cubit are provided
/// first.
final class IpaCoursesCubit extends CoursesCubit {
  IpaCoursesCubit(super.context) : super(major: SchoolMajor.ipa);
}

/// Cubit for [SchoolMajor.ips] courses.
///
/// Its depend on [UserCacheCubit], so make sure the user cubit are provided
/// first.
final class IpsCoursesCubit extends CoursesCubit {
  IpsCoursesCubit(super.context) : super(major: SchoolMajor.ips);
}
