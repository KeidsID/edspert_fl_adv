import 'package:root_lib/core/entities/course/course.dart';
import 'package:root_lib/core/services/api/courses_service.dart';

class GetCoursesByMajor {
  final CoursesService _coursesService;

  const GetCoursesByMajor({required CoursesService coursesService})
      : _coursesService = coursesService;

  Future<List<Course>> execute(
    String email, {
    SchoolMajor major = SchoolMajor.ipa,
  }) =>
      _coursesService.getCoursesByMajor(email, major: major);
}
