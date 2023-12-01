import 'package:edspert_fl_adv/core/entities/course/course.dart';
import 'package:edspert_fl_adv/core/services/api/courses_service.dart';

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
