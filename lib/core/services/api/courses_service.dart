import 'package:root_lib/core/entities/course/course.dart';

abstract interface class CoursesService {
  Future<List<Course>> getCoursesByMajor(
    String email, {
    SchoolMajor major = SchoolMajor.ipa,
  });
}
