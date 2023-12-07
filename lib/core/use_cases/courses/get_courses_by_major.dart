part of '../../use_cases.dart';

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
